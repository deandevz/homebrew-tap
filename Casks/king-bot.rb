cask "king-bot" do
  version "0.2.3"
  sha256 "0ac363748737d6098b632bbbed1244932114b3709a9c6e365718e3526e57188b"

  url "https://bot.kingdeanprod.com/downloads/mac/King-Bot-#{version}-arm64-mac.zip"
  name "King Bot"
  desc "App desktop do King Bot: empresta o computador aos agentes"
  homepage "https://bot.kingdeanprod.com/"

  # o próprio app se atualiza (electron-updater); o brew só instala
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "King Bot.app"

  # sem Developer ID nem notarização, o Gatekeeper bloqueia o app em quarentena
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/King Bot.app"], must_succeed: false
  end

  uninstall quit: "com.kingdeanprod.kingbot"

  zap trash: [
    "~/Library/Application Support/King Bot",
    "~/Library/Caches/com.kingdeanprod.kingbot.ShipIt",
    "~/Library/Caches/kingbot-desktop-updater",
    "~/Library/Preferences/com.kingdeanprod.kingbot.plist",
  ]

  caveats <<~EOS
    O King Bot ainda não é notarizado pela Apple: este cask tira a quarentena do app
    na instalação para o macOS abri-lo. Depois disso o app se atualiza sozinho.
  EOS
end
