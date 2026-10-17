cask "niri-os" do
  version "0.1.1"
  sha256 "d2f8e64184b6d6223ef85e43417fb079c836a69fad72b10ac67b1b5c8854d7a9"

  url "https://github.com/deandevz/niri-os-releases/releases/download/v#{version}/NiriOS-#{version}.zip"
  name "NiriOS"
  desc "Gerenciador de janelas em fita horizontal, no modelo do niri"
  homepage "https://github.com/deandevz/niri-os-releases"

  # o próprio app se atualiza (confere a assinatura e pergunta antes); o brew só instala
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "NiriOS.app"

  # sem Developer ID nem notarização, o Gatekeeper bloqueia o app em quarentena
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/NiriOS.app"], must_succeed: false
  end

  # sair pelo macOS devolve as janelas pra dentro da tela antes
  uninstall quit: "com.kingdeanprod.niri-os"

  zap trash: [
    "~/.config/niri-os",
    "~/Library/Application Support/niri-os",
    "~/Library/Caches/com.kingdeanprod.niri-os",
    "~/Library/HTTPStorages/com.kingdeanprod.niri-os",
    "~/Library/Logs/niri-os.log",
    "~/Library/Logs/niri-os.old.log",
    "~/Library/Preferences/com.kingdeanprod.niri-os.plist",
  ]

  caveats <<~EOS
    O NiriOS ainda não é notarizado pela Apple: este cask tira a quarentena do app
    na instalação para o macOS abri-lo. Na primeira abertura ele pede Acessibilidade
    e Gravação de Tela e mostra os atalhos. Depois disso o app se atualiza sozinho.
  EOS
end
