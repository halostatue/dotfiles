#! /usr/bin/env fish

if ! command --query npm
    echo >&2 NPM is not installed.
    return 1
end

if command --query corepack
    corepack prepare pnpm@latest --activate
    corepack prepare yarn@1 --activate
end

# Upgrade to latest NPM. Also globally install both yarn and pnpm
set --local node_version (node --version)
set --local pnpm_version latest
set --local nvm_version latest

switch $node_version
    case 'v12*'
        set pnpm_version ^6
        set nvm_version ^8
        # case 'v14*', 'v16*', 'v18*'
        #     set pnpm_version 7
end

npm install --global --silent --quiet \
    npm@$nvm_version \
    yarn@latest \
    pnpm@$pnpm_version

# Install useful packages with pnpm
pnpm install --global --silent \
    @cyclonedx/bom \
    @fsouza/prettierd \
    @graphql-codegen/cli '@types/node@>=13' @babel/core@^7 graphql@^16 \
    @graphql-inspector/cli @graphql-tools/utils@^9 \
    @magidoc/cli \
    @mermaid-js/mermaid-cli \
    @redocly/cli core-js@^3 webpack@^5 react-is@^16.8 \
    alex \
    apollo graphql@^14 \
    eslint-cli \
    graphql-markdown \
    graphqldoc \
    insomnia-documenter \
    pino-tiny \
    prettier \
    quicktype \
    sass \
    sass-migrator \
    svgo \
    typescript

pnpm install --global --silent \
    dockerfile-language-server-nodejs \
    svelte-language-server \
    typescript-language-server \
    vim-language-server \
    vls \
    vscode-css-languageserver-bin \
    vscode-html-languageserver-bin \
    vscode-langservers-extracted \
    yaml-language-server

pnpm install --global --silent \
    json-diff

switch $node_version
    case 'v12*'
        # noop
    case '*'
        pnpm install --global --silent \
            @withgraphite/graphite-cli \
            spectaql
end
