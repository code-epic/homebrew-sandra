cask "sandradc" do
  version "0.1.3"
  sha256 "b4aa378b2059f400a00ccf0fe9bc37f5cf3485c94fcb66ff6524948129ca51c4" # Lee la nota abajo

  # Esta es la ruta exacta que proporcionaste
  url "https://github.com/code-epic/sandra-desktop-container/releases/download/app-v0.1.3/SandraDC_0.1.3_universal.dmg"
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
