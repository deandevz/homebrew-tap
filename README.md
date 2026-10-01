# homebrew-tap

Tap do Homebrew para o app desktop do King Bot no Mac (Apple Silicon, macOS 14 ou mais novo).

```sh
brew install --cask deandevz/tap/king-bot
```

Depois da instalação o app se atualiza sozinho. O `brew upgrade` não mexe nele (`auto_updates true`).

O app ainda não tem assinatura de Developer ID nem notarização da Apple. Por isso o cask tira a quarentena do app
na instalação; sem isso o macOS bloqueia a primeira abertura.
