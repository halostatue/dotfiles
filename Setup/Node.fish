#! /usr/bin/env fish

if ! command --query npm
    echo >&2 NPM is not installed.
    return 1
end

if command --query corepack
    corepack enable
    corepack prepare pnpm@latest --activate
    corepack prepare yarn@1 --activate
end

npm install --global --silent --quiet \
    @cyclonedx/bom \
    @mermaid-js/mermaid-cli \
    @redocly/cli \
    jsondiff \
    quicktype \
    svgo
