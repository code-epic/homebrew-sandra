cask "sandradc" do
  version "0.1.2"
  sha256 "5334d5756a428b882a5e9fdcd39ff2d4b7f6d4a12ed2b88c7da9571fe51e750e" # Lee la nota abajo

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
