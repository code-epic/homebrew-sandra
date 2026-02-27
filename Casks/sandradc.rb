cask "sandradc" do
  version "0.1.2"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5" # Lee la nota abajo

  # Esta es la ruta exacta que proporcionaste
  url "https://github.com/code-epic/sandra-desktop-container/releases/download/untagged-cf10835d472d53a3c09f/SandraDC_0.1.2_universal.dmg"
  
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
