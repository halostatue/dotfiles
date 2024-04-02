status is-interactive
or return

if set --local bat (command --search bat batcat)[1]
    set bat (basename $bat)
    abbr --add cat $bat

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

if command --query eza
    abbr --add ls eza
else
    abbr --erase (
        abbr --show |
            string match --regex --groups-only "(\w+)\s+'?eza.*"
    )

    abbr --add l ls -lAh
    abbr --add la ls -A
    abbr --add ll ls -l
end

function expand_dotdots
    echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add expand_dotdots --regex '\.\.\.\.+' --function expand_dotdots --position anywhere

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
