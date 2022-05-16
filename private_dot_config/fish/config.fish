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

set -qg EDITOR
or set -gx EDITOR (which vim)

set -gq VISUAL
or set -gx VISUAL (which vim)

if command -sq bat
    set -gq PAGER
    or set -gx PAGER (which bat) --style plain
end

set -gq COMPOSER_DOCKER_CLI_BUILD
or set -gx COMPOSER_DOCKER_CLI_BUILD 1

set -gq DOCKER_BUILDKIT
or set -gx DOCKER_BUILDKIT 1

set -qU PROJECT_PATHS
or set -U PROJECT_PATHS \
    ~/dev/kinetic \
    ~/dev/ascendis \
    ~/oss \
    ~/oss/mime-types-org \
    ~/oss/halostatue \
    ~/oss/terraform \
    ~/oss/private


functions --query path:unique
and path:unique --test $HOME/.local/bin $HOME/.bin $HOME/bin

functions --query path:make_unique
and path:make_unique

set CDPATH . ~/.links/ ~/dev ~/dev/kinetic ~/oss ~/oss/github ~

if command -sq pngcrush
    function crush -d pngcrush
        pngcrush -e _sm.png -rem alla -brute -reduce $argv
    end
    complete -c crush -d PNG -a "*.png"
end

if command -sq pandoc
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
    if command -sq fzf
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

        if command -sq rg
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

    fzf_configure_bindings \
        --directory=\ct \
        --git_log=\cgl \
        --git_status=\cgs \
        --processes=\cgp \
        --history

    command -sq zoxide
    and zoxide init fish | source

    if not functions --query tide
        if command -sq starship
            starship init fish | source
            starship completions fish | source
        end
    end

    if command -sq pipx && command -sq register-python-argcomplete
        register-python-argcomplete --shell fish pipx | source
    end

    # tabtab source for packages
    # uninstall by removing these lines
    test -f ~/.config/tabtab/fish/__tabtab.fish
    and source ~/.config/tabtab/fish/__tabtab.fish

    command -sq fortune
    and fortune -s
end

if test -x ~/.bun/bin/bun
    set -Uq BUN_INSTALL
    or set -Ux BUN_INSTALL $HOME/.bun

    contains $HOME/.bun/bin $fish_user_paths
    or fish_add_path $HOME/.bun/bin
end

emit fish_postexec
