set fish_greeting ''

# Set up local machine configuration files
if functions --query __machine_config
    __machine_config platform host user
end

if not set --query LESSHISTFILE
    set --global --export LESSHISTFILE -
end

if not set --query EDITOR
    set --global --export EDITOR (which vim)
end

if not set --query VISUAL
    set --global --export VISUAL $EDITOR
end

if not set --query --global COMPOSER_DOCKER_CLI_BUILD
    set --global --export COMPOSER_DOCKER_CLI_BUILD 1
end

if not set --query --global DOCKER_BUILDKIT
    set --global --export DOCKER_BUILDKIT 1
end

# # This should be an external, maybe (`halostatue/fish-tealdeer`?)
# if command --query tldr && test (command --search tldr) = (path resolve $HOME/.cargo/bin/tldr)
#     set --local completion
#     set --local need true
#     set --local home (path resolve $HOME)
#     set --local completions (string match --groups-only --regex '('$home'[^ ]+)' $fish_complete_path)

#     for completion in $completions
#         test -s $completion/tldr.fish || continue
#         set need false
#         break
#     end

#     if $need
#         set --local vendor (string match --groups-only --regex '('$home'[^ ]+/vendor_completions.d)' $completions)

#         mkdir -p $completion
#         curl -sSL \
#             https://raw.githubusercontent.com/dbrgn/tealdeer/main/completion/fish_tealdeer \
#             -o $completion/tldr.fish
#     end
# end

set CDPATH . ~/.links/ ~/personal ~

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

function urlenc -d "url encode the passed string"
    if test (count $argv) -gt 0
        echo -n "$argv" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'
    else
        command cat | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'
    end
end

if functions --query has_keg
    if has_keg nnn
        source (brew --prefix nnn)/share/nnn/quitcd/quitcd.fish
    end
end

if command --query fzf
    if command --query rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
    end

    if command --query eza
        set -g fzf_preview_dir_cmd 'eza --all --color=always --classify=always'
    end

    if command --query delta
        set -g fzf_diff_highlighter delta --paging=never --width=20
    end

    if functions --query preview && not set --query fzf_preview_file_cmd
        set -g fzf_preview_file_cmd preview
    end

    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    if command --query fdfind fd
        set -g fzf_fd_opts --hidden
    end

    if not set --query FZF_DEFAULT_OPTS
        set --local colors \
            fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
            fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
            info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
            marker:#ff79c6,spinner:#ffb86c,header:#6272a4

        set --export FZF_DEFAULT_OPTS --color=(string join , $colors)
    end

    set --export --append FZF_DEFAULT_OPTS --bind ctrl-h:toggle-preview
end

if status is-interactive
    if test (uname -s) = Darwin
        switch "$TERM_PROGRAM"
            case ghostty
                # GhosTTY doesn't send \e for escape, but CSI u.
                bind escape,y yank-pop
                bind escape,. history-token-search-backward
                bind escape,l __fish_list_current_token
                bind escape,o __fish_preview_current_file
                bind escape,w __fish_whatis_current_token
                bind escape,d 'if test "$(commandline; printf .)" = \\n.; __fish_echo dirh; else; commandline -f kill-word; end'
                bind escape,s 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
                bind escape,h __fish_man_page
                bind escape,p __fish_paginate
                bind escape,\# __fish_toggle_comment_commandline
                bind escape,e edit_command_buffer
                bind escape,v edit_command_buffer
                bind escape,enter 'commandline -i \\n' expand-abbr
                bind escape,/ redo
                bind escape,t transpose-words
                bind escape,u upcase-word
                bind escape,c capitalize-word
                bind escape,backspace backward-kill-word
                bind escape,b prevd-or-backward-word
                bind escape,f nextd-or-forward-word
                bind escape,\< beginning-of-buffer
                bind escape,\> end-of-buffer

            case '*'
                set -g fish_escape_delay_ms 125
        end
    end

    set -g fish_prompt_pwd_dir_length 0
    set -g fish_prompt_pwd_full_dirs 1

    function restorepg
        pg_restore --verbose --clean -Fc -x --if-exists -j4 --no-acl --no-owner $argv[1]
    end

    function restoremysql
        mysql -u root <$argv[1]
    end

    if not set --query MAGIC_ENTER_GIT_COMMAND
        set --universal MAGIC_ENTER_GIT_COMMAND git status
    end

    if not set --query MAGIC_ENTER_LIST_COMMAND
        if command --query eza
            set --universal MAGIC_ENTER_LIST_COMMAND eza -l .
        else
            set --universal MAGIC_ENTER_LIST_COMMAND ls -lh .
        end
    end

    function magic_enter
        if test -z (string join0 -- (commandline))
            if __fish_is_git_repository
                eval $MAGIC_ENTER_GIT_COMMAND
            else
                printf "\n"
                eval $MAGIC_ENTER_LIST_COMMAND
            end

            printf "\n\n"

            commandline --function repaint
        else
            commandline --function execute
        end
    end

    if contains enter (bind --key-names)
        bind --key enter magic_enter
    end

    bind \cq magic_enter
    bind \r magic_enter

    if functions --query fzf_configure_bindings
        set --local __setup_fzf_bindings \
            --directory=\ct \
            --git_log=\cgl \
            --git_status=\cgs \
            --processes=\cgp \
            --history

        if command --query atuin mcfly
            set --erase __setup_fzf_bindings[-1]
        end

        fzf_configure_bindings $__setup_fzf_bindings

        set --erase __setup_fzf_bindings
    end

    if command --query atuin
        atuin init fish | source
    else if command --query mcfly
        mcfly init fish | source
    end

    if command --query zoxide
        zoxide init fish | source
    end

    if functions -q _tide_print_item
        # Do nothing. Tide should already be configured.
    else if command -q starship
        starship init fish | source
    end
end

if not command -q psql && test -d /Applications/Postgres.app/Contents/Versions/latest/bin
    fish_add_path --path --prepend /Applications/Postgres.app/Contents/Versions/latest/bin
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

if command --query fortune && status is-interactve
    fortune -s
end

if command --query fly && command --query flyctl
    complete --command fly --wraps flyctl
end

if command --query vim && not set --query PSQL_EDITOR
    set --global --export PSQL_EDITOR (command --search vim) -c ':set ft=sql'
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

# https://github.com/meaningful-ooo/sponge
if functions --query _sponge_remove_from_history
    set --global --export sponge_purge_only_on_exit true
end

# Prepare aqua

set --global --export AQUA_CONFIG_DIR "$HOME/.config/aquaproj-aqua"
set --global --export AQUA_GLOBAL_CONFIG "$AQUA_CONFIG_DIR/aqua.yaml"

if test -f "$AQUA_CONFIG_DIR/policy.yaml"
    set --global --export AQUA_POLICY_CONFIG "$AQUA_CONFIG_DIR/policy.yaml"
end

set --global --export AQUA_PROGRESS_BAR true
set --global --export AQUA_ROOT_DIR "$HOME/.local/share/aquaproj-aqua/bin"

if ! functions --query fish_right_prompt
    function fish_right_prompt
    end
end

if status is-interactive
    emit fish_postexec
end
