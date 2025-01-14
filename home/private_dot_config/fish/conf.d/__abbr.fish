status is-interactive
or return

# Turn `m ` in command position into `math ''`, with the cursor between the quotes.
abbr m --set-cursor "math '%'"

if set --local bat (command --search bat batcat)[1]
    set bat (basename $bat)
    abbr --add -- cat $bat

    set --query PAGER
    or set --global --export PAGER $bat --style plain

    if command --query batman
        abbr --add -- man batman
        complete --command batman --wraps man
    else
        abbr --show | string match --quiet --regex 'man\s+batman'
        and abbr --erase man

        set --query MANPAGER
        or set --global --export MANPAGER "sh -c 'col -bx | $bat --language man --plain'"
    end

    if command --query batpipe
        batpipe | source
    end

    if command --query batdiff && command --query delta
        set --export BATDIFF_USE_DELTA true
    end
else
    abbr --show | string match --quiet --regex 'cat\s+bat'
    and abbr --erase cat
end

function autocd
    set --query argv[1]
    or return 1

    type --query "$argv[1]"
    and return 1

    echo -- $argv[1] | read --local --tokenize dirs
    string match --quiet --regex '^(.+)?/*'
    or set --prepend dirs $CDPATH/$argv

    path is --type dir --perm exec -- $dirs
    or return 1

    echo -- cd $argv[1]
end

abbr --add autocd --regex '.*/' --function autocd

function multicd
    set --function length (math (string length -- $argv[1]) - 1)
    echo cd (string repeat -n $length ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function histreplace
    switch $argv[1]
        case '!!'
            echo -- $history[1]
            return 0
        case '!$'
            echo -- $history[1] | read -lat tokens
            echo -- $tokens[-1]
            return 0
        case '^*^*'
            set --function kv (string split '^' -- $argv[1])
            or return

            string split \n -- $history[1] | string replace -- $kv[2] $kv[3] | string collect
            return 0
    end

    return 1
end

abbr --add !! --position anywhere --function histreplace
abbr --add '!$' --position anywhere --function histreplace
abbr --add '\^.*\^.*' --position anywhere --function histreplace
