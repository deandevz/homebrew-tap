cask "puxa" do
  version "1.4"
  sha256 "be09880d4eb98c355925ddf9720021ad696a9a16bf9ac89b6a840ff28629ea6c"

  url "https://github.com/deandevz/puxa-releases/releases/download/v#{version}/Puxa-#{version}.zip"
  name "Puxa"
  desc "Baixador de vídeos do YouTube nativo, em cima do yt-dlp"
  homepage "https://github.com/deandevz/puxa-releases"

  # o próprio app se atualiza (confere a assinatura e pergunta antes); o brew só instala
  auto_updates true
  depends_on macos: :sonoma
  depends_on formula: ["yt-dlp", "ffmpeg", "deno"]

  app "Puxa.app"

  # sem Developer ID nem notarização, o Gatekeeper bloqueia o app em quarentena
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Puxa.app"], must_succeed: false
  end

  uninstall quit: "com.dean.puxa"

  zap trash: [
    "~/Library/Application Support/Puxa",
    "~/Library/Caches/Puxa",
    "~/Library/Preferences/com.dean.puxa.plist",
  ]

  caveats <<~EOS
    O Puxa ainda não é notarizado pela Apple: este cask tira a quarentena do app
    na instalação para o macOS abri-lo. Depois disso o app se atualiza sozinho.
  EOS
end
