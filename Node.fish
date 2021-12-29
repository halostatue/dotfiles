#! /usr/bin/env fish

npm i -g \
    npm

# Peer dependencies. These are used to prevent complaints.
npm i -g \
    graphql \
    graphql-config \
    yargs \
    @graphql-inspector/config \
    bson-ext \
    yo \
    generator-ronin \
    openapi-types

npm upgrade -g npm

npm i -g \
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
    @redocly/openapi-cli \
    @vue/cli \
    @vue/devtools \
    ajv-cli \
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
    pnpm \
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
    typescript \
    yarn
