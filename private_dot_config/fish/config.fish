# Install fisher if not already installed.
if not functions --query fisher
    if not set --query XDG_CONFIG_HOME
        set XDG_CONFIG_HOME ~/.config
    end

    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Set up local configuration files
__local_config platform host user

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

if not set --query --universal PROJECT_PATHS
    set --universal PROJECT_PATHS \
        ~/dev/kinetic \
        ~/dev/ascendis \
        ~/oss \
        ~/oss/mime-types-org \
        ~/oss/halostatue \
        ~/oss/terraform \
        ~/oss/private
end

set CDPATH . ~/.links/ ~/dev ~/dev/kinetic ~/oss ~/oss/github ~

if command --query pngcrush
    function crush -d pngcrush
        pngcrush -e _sm.png -rem alla -brute -reduce $argv
    end
    complete -c crush -d PNG -a "*.png"
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
    if has:keg chruby-fish
        source (brew --prefix chruby-fish)/share/chruby/chruby.fish
        # source (brew --prefix chruby-fish)/share/chruby/auto.fish
        set -Uq RUBIES $RUBIES
        set -Ux RUBIES $RUBIES
    end

    if has:keg nnn
        source (brew --prefix nnn)/share/nnn/quitcd/quitcd.fish
    end
end

test -s "$HOME/.local/share/kx/scripts/kx.fish"
and source "$HOME/.local/share/kx/scripts/kx.fish"

if status is-interactive
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

    if not functions --query tide
        if command --query starship
            starship init fish | source
            starship completions fish | source
        end
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
end

if test -x ~/.bun/bin/bun
    set -Uq BUN_INSTALL
    or set -Ux BUN_INSTALL $HOME/.bun

    contains $HOME/.bun/bin $fish_user_paths
    or fish_add_path $HOME/.bun/bin
end

if set --query PNPM_HOME
    mkdir -p $PNPM_HOME
    fish_add_path --path $PNPM_HOME
end

if command --query fortune && status is-interactve
    fortune -s
end

if command --query bat
    abbr --universal --add cat bat

    set --query PAGER
    or set --global --export PAGER bat --style plain

    set --query MANPAGER
    or set --global --export MANPAGER "sh -c 'col -bx | bat --language man --plain'"
else if command --query batcat
    abbr --universal --add cat batcat

    set --query PAGER
    or set --global --export PAGER batcat --style plain

    set --query MANPAGER
    or set --global --export MANPAGER "sh -c 'col -bx | batcat --language man --plain'"
end

if command --query exa
    abbr --universal --add ls exa
    abbr --universal --add lg 'exa --git'
    abbr --universal --add l 'exa -lah'
    abbr --universal --add la 'exa -a'
    abbr --universal --add ll 'exa -l'
    abbr --universal --add lt 'exa -lT'
else
    abbr --universal --add l 'ls -lAh'
    abbr --universal --add la 'ls -A'
    abbr --universal --add ll 'ls -l'
end

set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

ulimit -n 10480

emit fish_postexec
