#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_4-install-vscode-extensions.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*install-vscode-extensions* | true | '*' | 1) exit ;;
esac

if ! command -v code >/dev/null 2>&1; then
  return
fi

code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension anweber.httpbook
code --install-extension anweber.reveal-button
code --install-extension anweber.statusbar-commands
code --install-extension anweber.vscode-httpyac
code --install-extension atlassian.atlascode
code --install-extension BriteSnow.vscode-toggle-quotes
code --install-extension casualjim.gotemplate
code --install-extension chrislajoie.vscode-modelines
code --install-extension chuckjonas.apex-pmd
code --install-extension chuckjonas.salesforce-diff
code --install-extension codezombiech.gitignore
code --install-extension cschleiden.vscode-github-actions
code --install-extension DanielKnights.vscode-mjml
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension dbaeumer.vscode-eslint
code --install-extension deerawan.vscode-dash
code --install-extension eamodio.gitlens
code --install-extension EditorConfig.EditorConfig
code --install-extension EliverLara.andromeda
code --install-extension erlang-ls.erlang-ls
code --install-extension esbenp.prettier-vscode
code --install-extension fabiowquixada.vscode-isml-linter
code --install-extension FinancialForce.lana
code --install-extension firefox-devtools.vscode-firefox-debug
code --install-extension florinpatrascu.vscode-elixir-snippets
code --install-extension foxundermoon.shell-format
code --install-extension ghgofort.sfcc-metadata-explorer
code --install-extension ginfuru.ginfuru-vscode-jekyll-syntax
code --install-extension ginfuru.vscode-jekyll-snippets
code --install-extension GitHub.vscode-pull-request-github
code --install-extension golang.go
code --install-extension GraphQL.vscode-graphql
code --install-extension hashicorp.terraform
code --install-extension ismailnguyen.fortuneteller
code --install-extension JakeBecker.elixir-ls
code --install-extension jakob101.RelativePath
code --install-extension jock.svg
code --install-extension johnpapa.vscode-peacock
code --install-extension jq-syntax-highlighting.jq-syntax-highlighting
code --install-extension kongeor.vsc-fennel
code --install-extension lokalise.i18n-ally
code --install-extension luggage66.AWK
code --install-extension lunaryorn.fish-ide
code --install-extension mrmlnc.vscode-attrs-sorter
code --install-extension mrorz.language-gettext
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension ms-vsliveshare.vsliveshare-audio
code --install-extension novacode.sfccboilerplate
code --install-extension octref.vetur
code --install-extension pantajoe.vscode-elixir-credo
code --install-extension pflannery.vscode-versionlens
code --install-extension pgourlain.erlang
code --install-extension Pivotal.vscode-boot-dev-pack
code --install-extension Pivotal.vscode-spring-boot
code --install-extension quicktype.quicktype
code --install-extension rebornix.ruby
code --install-extension redhat.ansible
code --install-extension redhat.fabric8-analytics
code --install-extension redhat.java
code --install-extension redhat.vscode-commons
code --install-extension redhat.vscode-xml
code --install-extension redhat.vscode-yaml
code --install-extension RedVanWorkshop.sfcc-cartridge-overrides
code --install-extension Rubymaniac.vscode-direnv
code --install-extension rust-lang.rust
code --install-extension ryanluker.vscode-coverage-gutters
code --install-extension salesforce.salesforce-vscode-slds
code --install-extension salesforce.salesforcedx-vscode
code --install-extension salesforce.salesforcedx-vscode-apex
code --install-extension salesforce.salesforcedx-vscode-apex-debugger
code --install-extension salesforce.salesforcedx-vscode-apex-replay-debugger
code --install-extension salesforce.salesforcedx-vscode-core
code --install-extension salesforce.salesforcedx-vscode-lightning
code --install-extension salesforce.salesforcedx-vscode-lwc
code --install-extension salesforce.salesforcedx-vscode-soql
code --install-extension salesforce.salesforcedx-vscode-visualforce
code --install-extension samuelcolvin.jinjahtml
code --install-extension shadowtime2000.eta-vscode
code --install-extension sissel.shopify-liquid
code --install-extension skyapps.fish-vscode
code --install-extension SqrTT.prophet
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension tamasfe.even-better-toml
code --install-extension timonwong.shellcheck
code --install-extension Tyriar.sort-lines
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-spring-boot-dashboard
code --install-extension vscjava.vscode-spring-initializr
code --install-extension vscodevim.vim
code --install-extension Wattenberger.footsteps
code --install-extension webhint.vscode-webhint
code --install-extension wingrunr21.vscode-ruby
code --install-extension wix.vscode-import-cost
code --install-extension wmaurer.change-case
code --install-extension XadillaX.viml
code --install-extension xavbergeron.vim-leave-insertmode
code --install-extension yzhang.markdown-all-in-one
code --install-extension Zeplin.zeplin
