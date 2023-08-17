# Install fisher if not already installed.
if not functions --query fisher
    if not set --query XDG_CONFIG_HOME
        set XDG_CONFIG_HOME ~/.config
    end

    curl -sSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
        -o $XDG_CONFIG_HOME/fish/functions/fisher.fish
end

# Set up local machine configuration files
if functions --query __machine_config
    __machine_config platform host user
end

if not set --query --global EDITOR
    set --global --export EDITOR (which vim)
end

if not set --query --global VISUAL
    set --global --export VISUAL $EDITOR
end

if not set --query --global COMPOSER_DOCKER_CLI_BUILD
    set --global --export COMPOSER_DOCKER_CLI_BUILD 1
end

if not set --query --global DOCKER_BUILDKIT
    set --global --export DOCKER_BUILDKIT 1
end

# This should be an external, maybe (`halostatue/fish-tealdeer`?)
if command --query tldr && test (command --search tldr) = (path resolve $HOME/.cargo/bin/tldr)
    set --local completion
    set --local need true
    set --local home (path resolve $HOME)
    set --local completions (string match --groups-only --regex '('$home'[^ ]+)' $fish_complete_path)

    for completion in $completions
        test -s $completion/tldr.fish || continue
        set need false
        break
    end

    if $need
        set --local vendor (string match --groups-only --regex '('$home'[^ ]+/vendor_completions.d)' $completions)

        mkdir -p $completion
        curl -sSL \
            https://raw.githubusercontent.com/dbrgn/tealdeer/main/completion/fish_tealdeer \
            -o $completion/tldr.fish
    end
end

set CDPATH . ~/.links/ ~/dev ~/dev/kinetic ~/oss ~/oss/github ~

if command --query pngcrush
    function crush -d pngcrush
        pngcrush -e _sm.png -rem alla -brute -reduce $argv
    end
    complete -c crush -d PNG -a "*.png"
end

if command --query xplr
    if not set --query __xplr_no_xcd
        function xcd -d "cd to xplr target"
            cd (xlpr --print-pwd-as-result)
        end
    end
end

if command --query tere
    function tere
        set --local result (command tere $argv)
        if test -n "$result"
            cd -- $result
        end
    end
end

if command --query pandoc
    function docx2md --description "Convert docx to markdown: docx2md [source] [target]"
        pandoc -o "$2" --extract-media=(dirname "$argv[2]") "$argv[1]"
    end
end

function 64enc -d "encode a given image file as base64 and output css background property to clipboard"
    openssl base64 -in "$argv" | awk -v ext=(get_ext $argv) '{ str1=str1 $0 }END{ print "background:url(data:image/"ext";base64,"str1");" }' | pbcopy
    echo "$argv encoded to clipboard"
end

function 64font -d "encode a given font file as base64 and output css background property to clipboard"
    openssl base64 -in "$argv" | awk -v ext=(get_ext $argv) '{ str1=str1 $0 }END{ print "src:url(\"data:font/"ext";base64,"str1"\")  format(\""ext"\");" }' | pbcopy
    echo "$argv encoded as font and copied to clipboard"
end

function urlenc -d "url encode the passed string"
    if test (count $argv) -gt 0
        echo -n "$argv" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'
    else
        command cat | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'
    end
end

if functions --query has:keg
    if has:keg nnn
        source (brew --prefix nnn)/share/nnn/quitcd/quitcd.fish
    end
end

test -s "$HOME/.local/share/kx/scripts/kx.fish"
and source "$HOME/.local/share/kx/scripts/kx.fish"

if status is-interactive
    if command --query just
        just --completions fish | source
    end

    if command --query wezterm
        wezterm shell-completion --shell fish | source
    end

    if command --query chezmoi
        chezmoi completion fish | source
    end

    if command --query orbctl
        orbctl completion fish | source
    end

    if command --query fzf
        function fp --description 'Search your $PATH'
            set -l loc (echo $PATH | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:path]'")

            if test (count $loc) = 1
                set -l cmd (rg --files -L $loc | rev | cut -d'/' -f1 | rev | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:exe] => $loc'")
                if test (count $cmd) = 1
                    echo $cmd
                else
                    fp
                end
            end
        end

        function kp --description "Kill processes"
            set -l __kp__pid ''

            if contains -- --tcp $argv
                set __kp__pid (lsof -Pwni tcp | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:tcp]'" | awk '{print $2}')
            else
                set __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
            end

            if test "x$__kp__pid" != x
                if test "x$argv[1]" != x
                    echo $__kp__pid | xargs kill $argv[1]
                else
                    echo $__kp__pid | xargs kill -9
                end
                kp
            end
        end

        function ks --description "Kill http server processes"
            set -l __ks__pid (lsof -Pwni tcp | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:tcp]'" | awk '{print $2}')
            set -l __ks__kc $argv[1]

            if test "x$__ks__pid" != x
                if test "x$argv[1]" != x
                    echo $__ks__pid | xargs kill $argv[1]
                else
                    echo $__ks__pid | xargs kill -9
                end
                ks
            end
        end

        if command --query rg
            set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
        end

        function gcb --description "delete git branches"
            set delete_mode -d

            if contains -- --force $argv
                set force_label ':force'
                set delete_mode -D
            end

            set -l branches_to_delete (git branch | sed -E 's/^[* ] //g' | fzf -m --header="[git:branch:delete$force_label]")

            if test -n "$branches_to_delete"
                git branch $delete_mode $branches_to_delete
            end
        end
    end

    function l
        ll $argv
    end

    function restoredb
        # pg_restore --verbose --clean -Fc -x --if-exists -d $database $filename
        # pg_restore --verbose --clean --create -Fc -x --if-exists $filename
        pg_restore --verbose --clean -Fc -x --if-exists -j4 --no-acl --no-owner $argv[1]
    end

    function restoremysql
        mysql -u root <$argv[1]
    end

    function magic_enter
        if test -z (string join0 -- (commandline))
            if __fish_is_git_repository
                set -q MAGIC_ENTER_GIT_COMMAND
                or set MAGIC_ENTER_GIT_COMMAND 'git status -u .'
                eval $MAGIC_ENTER_GIT_COMMAND
            else
                set -q MAGIC_ENTER_OTHER_COMMAND
                or set MAGIC_ENTER_OTHER_COMMAND 'ls -lh .'
                eval $MAGIC_ENTER_OTHER_COMMAND
            end

            printf "\n\n"

            commandline -f repaint
        else
            commandline -f execute
        end
    end

    contains enter (bind -K)
    and bind -k enter magic_enter

    bind \cq magic_enter
    bind \r magic_enter
    bind \n magic_enter

    set --local __setup_fzf_bindings \
        --directory=\ct \
        --git_log=\cgl \
        --git_status=\cgs \
        --processes=\cgp \
        --history

    if not command --query atuin mcfly
        set --erase __setup_fzf_bindings[-1]
    end

    fzf_configure_bindings $__setup_fzf_bindings

    set --erase __setup_fzf_bindings

    if command --query atuin
        atuin init fish | source
        atuin gen-completions --shell fish | source
    else if command --query mcfly
        mcfly init fish | source
    end

    if command --query zoxide
        zoxide init fish | source
    end

    if command --query pipx && command --query register-python-argcomplete
        register-python-argcomplete --shell fish pipx | source
    end

    # tabtab source for packages
    # uninstall by removing these lines
    if test -f ~/.config/tabtab/fish/__tabtab.fish
        source ~/.config/tabtab/fish/__tabtab.fish
    end

    if command --query hof
        hof completion fish | string replace -r '(alias _="hof")' '#$1' | source
    end

    if command --query op
        op completion fish | source
    end

    if functions --query tide
        # IlanCosman/tide@v5 configuration
    else if functions --query _hydro_prompt
        # jorgebucaran/hydo configuration
        if ! set --query --universal hydro_multiline
            set --universal hydro_multiline true
        end
    else if command --query starship
        starship init fish | source
        starship completions fish | source
    end
end

if test -x $HOME/.bun/bin/bun
    if ! set --global --query BUN_INSTALL
        set --global --export BUN_INSTALL $HOME/.bun
    end

    if ! contains $HOME/.bun/bin $PATH && ! contains $HOME/.bun/bin $fish_user_paths
        fish_add_path --path $HOME/.bun/bin
    end

    # This is currently broken. See oven-sh/bun#2977.
    # if ! test -s completions/bun.fish
    #     bun completions
    # end
end

if set --query PNPM_HOME
    mkdir -p $PNPM_HOME
    fish_add_path --path $PNPM_HOME
end

if command --query fortune && status is-interactve
    fortune -s
end

if command --query bat
    abbr --add cat bat

    set --query PAGER
    or set --global --export PAGER bat --style plain

    set --query MANPAGER
    or set --global --export MANPAGER "sh -c 'col -bx | bat --language man --plain'"
else if command --query batcat
    abbr --add cat batcat

    set --query PAGER
    or set --global --export PAGER batcat --style plain

    set --query MANPAGER
    or set --global --export MANPAGER "sh -c 'col -bx | batcat --language man --plain'"
end

if command --query exa
    abbr --add ls exa
    abbr --add lg 'exa --git'
    abbr --add l 'exa -lah'
    abbr --add la 'exa -a'
    abbr --add ll 'exa -l'
    abbr --add lt 'exa -lT'
else
    abbr --add l 'ls -lAh'
    abbr --add la 'ls -A'
    abbr --add ll 'ls -l'
end

if command --query fly flyctl
    complete --command fly --wraps flyctl
end

if command --query vim && not set --query PSQL_EDITOR
    set --global --export PSQL_EDITOR (command --search vim) -c ':set ft=sql'
end

if not set --query FZF_DEFAULT_OPTS
    set --local colors \
        fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
        fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
        info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
        marker:#ff79c6,spinner:#ffb86c,header:#6272a4

    set --export FZF_DEFAULT_OPTS --color=(string join , $colors)
end

function in_ssh
    test -n "$SSH_CLIENT" || test -n "$SSH_TTY"
end

function is_vscode
    test -n $TERM_PROGRAM = vscode
end

# fish_add_path --append .git/safe/../../node_modules/.bin
# fish_add_path .git/safe/../../bin .git/safe/../../exe

function expand_dotdots
    echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add expand_dotdots --regex '\.\.\.+' --function expand_dotdots --position anywhere

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function last_history_item
    echo $history[1]
end
abbr --add !! --position anywhere --function last_history_item

function last_history_argument
    echo (echo $history[1] | string split ' ')[-1]
end
abbr --add '!$' --position anywhere --function last_history_argument

ulimit -n 10480

emit fish_postexec
