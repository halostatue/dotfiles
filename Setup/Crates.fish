function __ci
    argparse -N1 n/nightly -- $argv

    if set -q $_flag_nightly
        rustup run nightly cargo install $argv
    else
        cargo install $argv
    end
end

# Useful general utilities
__ci abscissa # Application microframework generator
__ci ag # angle-grinder log dicer
__ci bat # syntax highlighting `cat` https://github.com/sharkdp/bat
__ci bottom
__ci broot
__ci broot # Command-line file manager
__ci cargo-audit # audit security on crates
__ci cargo-authors # list the authors of all dependencies
__ci cargo-benchcmp
__ci cargo-bump
__ci cargo-cli
__ci cargo-clone # fetch the source of a crate
__ci cargo-config # config like git config
__ci cargo-cook # produce build artifacts
__ci cargo-count
__ci cargo-ctags
__ci cargo-deadlinks # check documentation for dead links
__ci cargo-do
__ci cargo-edit # `cargo add`, etc. Manipulate cargo.toml from the CLI
__ci cargo-edit-locally
__ci cargo-expand # Shows the result of macro and derive expansion
__ci cargo-info
__ci cargo-license
__ci cargo-lichking # Show dependency licensing
__ci cargo-modules # Show treeview of module
__ci cargo-outdated # Show when dependencies are outdated
__ci cargo-readme # Generate README from doc comments
__ci cargo-release # Smooth the release process
__ci cargo-show
__ci cargo-update # Check for outdated executables
__ci cargo-watch # Watch the crate source for a build repeater
__ci chars # unicode character info display https://github.com/antifuchs/chars
__ci choose
__ci committed
__ci cpc
__ci diffr
__ci diffsitter
__ci difftastic
__ci dotenv-linter
__ci drill
__ci du-dust # intuitive disk usage
__ci dua-cli
__ci dune
__ci eva # calculator like bc https://github.com/nerdypepper/eva
__ci exa # modern ls https://the.exa.website
__ci fastmod
__ci fd-find # a find alternative https://github.com/sharkdp/fd
__ci fnm
__ci frum
__ci fselect
__ci git-absorb
__ci git-brws # useful tools for git https://github.com/rhysd/git-brws
__ci git-historian
__ci git-journal
__ci git-stack
__ci gitui # fork-like tui https://github.com/extrawurst/gitui
__ci gobang
__ci gping
__ci grex
__ci hck
__ci hexyl # modern tui hex viewer https://github.com/sharkdp/hexyl
__ci ht
__ci htmlq
__ci huniq
__ci hurl
__ci hyperfine # benchmarking tool https://github.com/sharkdp/hyperfine
__ci just # an alternative to Make https://github.com/casey/just
__ci loc
__ci loop-rs # a loop command for commands https://github.com/Miserlou/Loop
__ci lsd
__ci mcfly
__ci mdcat # `cat` markdown files https://github.com/lunaryorn/mdcat
__ci mrml-cli
__ci natls
__ci navi
__ci nu
__ci procs
__ci rage
__ci ripgrep # better ag https://github.com/BurntSushi/ripgrep
__ci rm-improved
__ci rnr
__ci scryer-prolog
__ci sd
__ci shellharden
__ci skim # fuzzy finder in rust
__ci starship # prompt utility
__ci stringsext
__ci svgbob_cli # ASCII-art to SVG https://github.com/ivanceras/svgbob
__ci taplo-cli
__ci tealdeer # tldr in rust https://github.com/dbrgn/tealdeer/
__ci tidy-viewer
__ci titlecase # titlecase text https://docs.rs/crate/titlecase/1.1.0
__ci tokei # lines of code counter https://github.com/XAMPPRocky/tokei
__ci toml-fmt # TOML formatter (loses comments)
__ci typos-cli
__ci watchexec # file watcher and command runner
__ci watchexec-cli
__ci xcp
__ci xh
__ci xsv # CSV toolkit https://github.com/BurntSushi/xsv
__ci ytop
__ci zellij
__ci zoxide

functions -e __ci

# vim: ft=fish
