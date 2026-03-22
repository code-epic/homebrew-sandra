class SandraServer < Formula
  desc "Sandra Server - Plataforma middleware empresarial"
  homepage "https://github.com/code-epic/sandra"
  version "1.0.1"
  
  # URL se actualizará dinámicamente según la arquitectura
  if Hardware::CPU.arm?
    url "https://github.com/code-epic/sandra/releases/download/v#{version}/sandra-server-v#{version}-darwin-arm64.tar.gz"
    sha256 "PLACEHOLDER_SHA256_ARM64"
  else
    url "https://github.com/code-epic/sandra/releases/download/v#{version}/sandra-server-v#{version}-darwin-amd64.tar.gz"
    sha256 "PLACEHOLDER_SHA256_AMD64"
  end
  
  license "MIT"
  
  # Dependencias opcionales
  depends_on "php" => :optional
  
  def install
    # Crear directorio de instalación
    (var"sandra").mkpath
    (var"sandra/bin").mkpath
    (var"sandra/log").mkpath
    (var"sandra/tmp").mkpath
    (var"sandra/file").mkpath
    (var"sandra/signature").mkpath
    (var"sandra/public_web/consola").mkpath
    (var"sandra/public_web/www").mkpath
    (var"sandra/public_web/err").mkpath
    
    # Instalar binario principal
    bin.install "sandrad"
    
    # Instalar herramientas adicionales
    bin.install "bin/sandra_scanf" if File.exist?("bin/sandra_scanf")
    bin.install "bin/sandra_dwn" if File.exist?("bin/sandra_dwn")
    bin.install "bin/sandra_sms" if File.exist?("bin/sandra_sms")
    
    # Instalar archivos de configuración
    etc.install "sandra.ini" => "sandra/sandra.ini" unless (etc/"sandra/sandra.ini").exist?
    
    # Instalar certificados
    (var"sandra/signature").install Dir["signature/*"] if Dir.exist?("signature")
    
    # Instalar archivos web
    (var"sandra/public_web/consola").install Dir["public_web/consola/*"] if Dir.exist?("public_web/consola")
    (var"sandra/public_web/www").install Dir["public_web/www/*"] if Dir.exist?("public_web/www")
    (var"sandra/public_web/err").install Dir["public_web/err/*"] if Dir.exist?("public_web/err")
    
    # Instalar script de instalación
    (share/"sandra").install "install-macos.sh" if File.exist?("install-macos.sh")
    (share/"sandra").install "cmd/sandrad.service" if File.exist?("cmd/sandrad.service")
    
    # Crear enlace simbólico para el servicio launchd
    (prefix/"com.codeepic.sandrad.plist").write plist_content
  end
  
  def post_install
    # Crear usuario y grupo sandra si no existen
    system "sudo", "dscl", ".", "-create", "/Users/sandra" 2>/dev/null || true
    system "sudo", "dscl", ".", "-create", "/Groups/sandra" 2>/dev/null || true
    
    # Establecer permisos
    system "sudo", "chown", "-R", "sandra:sandra", var/"sandra" 2>/dev/null || true
    
    ohai "Sandra Server instalado"
    ohai "Para iniciar el servicio:"
    ohai "  sudo brew services start sandra-server"
    ohai ""
    ohai "URLs de acceso:"
    ohai "  https://localhost          - Servidor web"
    ohai "  https://localhost/consola  - Consola de administración"
  end
  
  def caveats
    <<~EOS
      Sandra Server requiere privilegios de root para:
      - Binding de puertos bajos (80, 443)
      - Gestión del servicio launchd
      
      Configuración:
        Configuración principal: #{etc}/sandra/sandra.ini
        Directorio de datos:     #{var}/sandra
        Logs:                    #{var}/sandra/log
      
      Comandos útiles:
        sudo brew services start sandra-server    - Iniciar servicio
        sudo brew services stop sandra-server     - Detener servicio
        sudo brew services restart sandra-server  - Reiniciar servicio
        sudo launchctl list | grep sandra         - Ver estado
      
      Puertos utilizados (configurables en sandra.ini):
        - 80:   HTTP
        - 443:  HTTPS principal
        - 8443: WebSocket Chat
      
      Para actualizar la configuración después de cambios:
        sudo brew services restart sandra-server
      
      Soporte:
        Documentación: https://github.com/code-epic/sandra/tree/main/docs
        Issues:        https://github.com/code-epic/sandra/issues
    EOS
  end
  
  service do
    run [opt_bin/"sandrad"]
    keep_alive true
    run_type :immediate
    require_root true
    log_path var/"sandra/log/sandrad.out.log"
    error_log_path var/"sandra/log/sandrad.err.log"
    environment_variables PATH: std_service_path_env
  end
  
  def plist_content
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>com.codeepic.sandrad</string>
          
          <key>ProgramArguments</key>
          <array>
              <string>#{opt_bin}/sandrad</string>
          </array>
          
          <key>WorkingDirectory</key>
          <string>#{var}/sandra</string>
          
          <key>UserName</key>
          <string>sandra</string>
          
          <key>GroupName</key>
          <string>sandra</string>
          
          <key>RunAtLoad</key>
          <true/>
          
          <key>KeepAlive</key>
          <dict>
              <key>SuccessfulExit</key>
              <false/>
          </dict>
          
          <key>ThrottleInterval</key>
          <integer>5</integer>
          
          <key>StandardOutPath</key>
          <string>#{var}/sandra/log/sandrad.out.log</string>
          
          <key>StandardErrorPath</key>
          <string>#{var}/sandra/log/sandrad.err.log</string>
          
          <key>EnvironmentVariables</key>
          <dict>
              <key>PATH</key>
              <string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
          </dict>
      </dict>
      </plist>
    EOS
  end
  
  test do
    # Verificar que el binario existe
    assert_predicate bin/"sandrad", :exist?
    
    # Verificar versión
    system "#{bin}/sandrad", "--version" if File.exist?("#{bin}/sandrad")
  end
end
