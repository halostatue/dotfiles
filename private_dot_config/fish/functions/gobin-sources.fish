# Defined in /var/folders/6t/2xp3hp2j1vd5yyklq0b6_lbw0000gn/T//fish.V9KiNA/gobin-sources.fish @ line 2
function gobin-sources
  for bin in $HOME/go/bin/*
    test -x $bin; or continue 

    set -l shortbin (string replace $HOME/go/bin/ '' $bin) 

    printf "%s: " $shortbin

    strings $bin |
      string replace -f -r "$HOME/go/(pkg/mod|src)/(.*?$shortbin)(@.*)?/.*\.go" '$2' |
      string replace -r "@.*?/" '/' |
      uniq |
      ruby -ne 'puts $_.gsub(/!(.)/) { $1.upcase }'
  end
end
