# Defined in .config/functions/gobin-sources.fish
function gobin-sources
    for bin in $HOME/go/bin/*
        test -x $bin; or continue

        set -l shortbin (string replace $HOME/go/bin/ '' $bin)

        printf "%s: " $shortbin

        strings $bin |
            string replace -f -r "$HOME/go/(pkg/mod|src)/(.*?$shortbin)(@.*)?/.*\.go" '$2' |
            string replace -r "@.*?/" / |
            uniq |
            ruby -ne 'puts $_.gsub(/!(.)/) { $1.upcase }'
    end
end
