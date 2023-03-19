if status is-interactive
    set BROWSER open

    if functions --query has_app
        if has_app Marked
            function marked --description 'Opens a markdown file or markdown files in a folder.'
                for d in $argv
                    if test -d $d
                        marked $d/*.{md,mkd,mmd,markdown,mkdn}
                    else
                        open -a Marked $d
                    end
                end
            end
            complete -c marked -d "Markdown File" -a "*.{md,mkd,mmd,markdown,mkdn}"
        end

        if has_app Acorn
            function acorn
                open -a Acorn $argv
            end
            complete -c acorn -d Image -a "*.{png,jpg,jpeg,psd}"
            complete -c acorn -d Acorn -a "*.acorn"
        end

        if has_app ImageAlpha

            function alpha
                open -a ImageAlpha $argv
            end
            complete -c alpha -d Image -a "*.{png,gif}"
        end

        if has_app ImageOptim
            function optim
                open -a ImageOptim $argv
            end
            complete -c optim -d Image -a "*.{png,jpg,jpeg,gif}"
        end

        if has_app Byword
            function by
                open -a Byword $argv
            end
            complete -c by -d "Markdown File" -a "*.{md,mkd,mmd,markdown,mkdn}"
            complete -c by -d "Text File" -a "*.{text,txt}"
        end

        if has_app 'Google Chrome'
            function chrome
                open -a '/Applications/Google Chrome.app' $argv
            end
            complete -c chrome -d "HTML File" -a "*.{html,htm}"
        end

        if has_app 'MultiMarkdown Composer'
            function mmdc
                open -a '/Applications/MultiMarkdown Composer.app' $argv
            end
            complete -c mmdc -d "Markdown File" -a "*.{md,mkd,mmd,markdown,mkdn}"
            complete -c mmdc -d "Text File" -a "*.{text,txt}"
        end

        if has_app TaskPaper
            function tp
                open -a TaskPaper $argv
            end
            complete -c tp -d "TaskPaper File" -a "*.taskpaper"
        end

        if has_app Xcode
            function xc
                open -a Xcode $argv
            end
            complete -c xc -d "Xcode project" -a "*.xcodeproj"
        end

        function imgsize --description "Quickly get image dimensions from the command line"
            if test -f $argv
                set -l height (sips -g pixelHeight "$argv"|tail -n 1|awk '{print $2}')
                set -l width (sips -g pixelWidth "$argv"|tail -n 1|awk '{print $2}')
                echo "$width x $height"
            else
                echo "File not found"
            end
        end

        function o
            open -a $argv
        end
        complete -c o -a (basename -s .app /Applications{,/Setapp}/*.app|awk '{printf "\"%s\" ", $0 }')

        if has_app Dash
            function dash -d "Open argument in Dash"
                open "dash://"(urlenc $argv)
            end

            function dman -d "Open man page in Dash"
                open "dash://man:"(urlenc $argv)
            end
        end

    end

    if command --query jq
        function json-clean
            pbpaste | jq . | pbcopy
        end
    end

    # If using 1Password for SSH agent.
    for sock in ~/Library/Group\ Containers/*.com.1password/t/agent.sock
        test -S $sock
        or continue

        set -x SSH_AUTH_SOCK $sock
        break
    end

    # If using Secretive for SSH agent.
    if test -S ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
        set -x SSH_AUTH_SOCK ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    end

    # test (ssh-add -l | wc -l) -gt 0
    # or ssh-add --apple-load-keychain >/dev/null

    if has_app iTerm && test -f ~/.iterm2_shell_integration.fish && set -q ITERM_PROFILE
        source ~/.iterm2_shell_integration.fish
    end
end

set --query --global PNPM_HOME
or set --global --export PNPM_HOME ~/Library/pnpm
