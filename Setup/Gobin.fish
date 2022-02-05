#! /usr/bin/env fish

function __i
    set -l p
    for p in $argv
        echo ">>> Installing "$p
        if go install $p
            echo "<<< Installed "$p
        else
            echo "!!! Error installing "$p
        end
    end
end

__i github.com/acroca/go-symbols@latest
__i github.com/asciimoo/wuzz@latest
__i github.com/boyter/scc@latest
__i github.com/davidrjenni/reftools/cmd/fillstruct@latest
__i github.com/evilmartians/lefthook@latest
__i github.com/fatih/gomodifytags@latest
__i github.com/fatih/motion@latest
__i github.com/golangci/golangci-lint/cmd/golangci-lint@latest
__i github.com/gsamokovarov/jump@latest
__i github.com/ichinaski/pxl@latest
__i github.com/josharian/impl@latest
__i github.com/jstemmer/gotags@latest
__i github.com/kisielk/errcheck@latest
__i github.com/go-delve/delve/cmd/dlv@latest
__i github.com/klauspost/asmfmt/cmd/asmfmt@latest
__i github.com/koron/iferr@latest
__i github.com/kovetskiy/mark@latest
__i github.com/linde12/kod@latest
__i github.com/magefile/mage@latest
__i github.com/mdempsky/gocode@latest
__i github.com/mgechev/revive@latest
__i github.com/mikepea/go-jira-ui/jira-ui@latest
__i github.com/mkchoi212/fac@latest
__i github.com/mrnugget/fzz@latest
__i github.com/nishanths/license@latest
__i github.com/pengwynn/flint@latest
__i github.com/ramya-rao-a/go-outline@latest
__i github.com/rogpeppe/godef@latest
__i github.com/rs/curlie@latest
__i github.com/segmentio/ksuid/cmd/ksuid@latest
__i github.com/shurcooL/git-branches@latest
__i github.com/square/certstrap@latest
__i github.com/svent/sift@latest
__i github.com/tj/node-prune@latest
__i github.com/variadico/noti/cmd/noti@latest
__i github.com/wader/fq@latest
__i github.com/zmb3/gogetdoc@latest
