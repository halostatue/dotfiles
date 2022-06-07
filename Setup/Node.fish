#! /usr/bin/env fish

if ! command --query npm
    echo >&2 NPM is not installed.
    return 1
end

# Upgrade to latest NPM. Also globally install both yarn and pnpm
set --local pnpm_version latest

switch (node --version)
    case 'v10*'
        set pnpm_version 5
    case 'v11*', 'v12*'
        set pnpm_version 6
    case 'v13*','v14*', 'v15*', 'v16*', 'v17*', 'v18*'
        set pnpm_version 7
end

npm install --global npm@latest yarn@latest pnpm@$pnpm_version

pnpm install --global --quiet \
    graphql \
    graphql@15 \
    graphql-config \
    graphql-config@3 \
    yargs \
    yargs@15 \
    @graphql-inspector/config \
    @graphql-inspector/config@2 \
    @graphql-inspector/loaders@2 \
    @graphql-tools/utils@8 \
    bson-ext \
    core-js@3 \
    yo \
    generator-ronin \
    openapi-types

# Install useful packages with pnpm
pnpm install --global \
    @2fd/graphdoc \
    @cyclonedx/bom \
    @graphql-cli/codegen \
    @graphql-cli/coverage \
    @graphql-cli/diff \
    @graphql-cli/generate \
    @graphql-cli/introspect \
    @graphql-cli/similar \
    @graphql-cli/validate \
    @graphql-inspector/cli \
    @redocly/cli \
    @vue/cli \
    @vue/devtools \
    @withgraphite/graphite-cli \
    ajv-cli \
    apollo \
    apollo-codegen \
    fx \
    graphql \
    graphql-cli \
    graphql-markdown \
    graphqldoc \
    insomnia-documenter \
    install-peerdeps \
    json5 \
    knex \
    logsene-cli \
    prettier \
    quicktype \
    raml2html \
    raml2html-full-markdown-theme \
    raml2html-markdown-theme \
    raml2html-markdown-theme-schema \
    raml2html-printable-theme \
    raml2html-slate-theme \
    redoc-cli \
    sass \
    sass-migrator \
    svgo \
    swagger-cli \
    typescript
