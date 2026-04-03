cask "sandradc" do
  version "0.1.5"
  sha256 "70e92969802bf3ac8b63383b0105ef3462bf8213976953b58bb02835614ece37" # Lee la nota abajo

  # Esta es la ruta exacta que proporcionaste
  url "https://github.com/code-epic/sandra-desktop-container/releases/download/app-v0.1.5/SandraDC_0.1.5_universal.dmg"
  name "SandraDC"
  desc "Sandra Desktop Container"
  homepage "https://github.com/code-epic/sandra-desktop-container"

  # Basado en tu productName de tauri.conf.json
  app "SandraDC.app"

  zap trash: [
    "~/Library/Application Support/com.sandra.desktop",
    "~/Library/Preferences/com.sandra.desktop.plist",
    "~/Library/Saved Application State/com.sandra.desktop.savedState",
  ]
end
