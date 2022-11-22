#! /usr/bin/env fish

function i
    set -l p
    for p in $argv
        set -l width (math (count $p) + 20 '*' - 1)
        printf ">>> Installing %s" $p
        if go install $p >/dev/null 2>&1
            printf "\r>>> Installed "$p"  \n"
        else
            set -l st $status
            printf "\r!!! Error installing "$p"  \n"
            exit $st
        end
    end
end

i github.com/aarzilli/gdlv@latest # https://github.com/aarzilli/gdlv
i github.com/acroca/go-symbols@latest # https://github.com/acroca/go-symbols
i github.com/benhoyt/goawk@latest # https://github.com/benhoyt/goawk
i github.com/boyter/scc@latest # https://github.com/boyter/scc
i github.com/cycloidio/inframap@latest # https://github.com/cycloidio/inframap
i github.com/davidrjenni/reftools/cmd/fillstruct@latest # https://github.com/davidrjenni/reftools
i github.com/davidrjenni/reftools/cmd/fillswitch@latest # https://github.com/davidrjenni/reftools
i github.com/davidrjenni/reftools/cmd/fixplurals@latest # https://github.com/davidrjenni/reftools
i github.com/dosco/graphjin@latest # https://github.com/dosco/graphjin
i github.com/evilmartians/lefthook@latest # https://github.com/evilmartians/lefthook
i github.com/fatih/gomodifytags@latest # https://github.com/fatih/gomodifytags
i github.com/fatih/motion@latest # https://github.com/fatih/motion
i github.com/go-delve/delve/cmd/dlv@latest # https://github.com/go-delve/delve
i github.com/golangci/golangci-lint/cmd/golangci-lint@latest # https://github.com/golangci/golangci-lint
i github.com/gsamokovarov/jump@latest # https://github.com/gsamokovarov/jump
i github.com/ichinaski/pxl@latest # https://github.com/ichinaski/pxl
i github.com/jesseduffield/lazygit@latest # https://github.com/jesseduffield/lazygit
i github.com/jmalloc/echo-server/...@latest # https://github.com/jmalloc/echo-server
i github.com/josharian/impl@latest # https://github.com/josharian/impl
i github.com/jstemmer/gotags@latest # https://github.com/jstemmer/gotags
i github.com/k0kubun/sqldef/cmd/psqldef@latest # https://github.com/k0kubun/sqldef
i github.com/k0kubun/sqldef/cmd/sqlite3def@latest # https://github.com/k0kubun/sqldef
i github.com/kisielk/errcheck@latest # https://github.com/kisielk/errcheck
i github.com/koron/iferr@latest # https://github.com/koron/iferr
i github.com/kovetskiy/mark@latest # https://github.com/kovetskiy/mark
i github.com/lighttiger2505/sqls@latest # https://github.com/lighttiger2505/sqls
i github.com/magefile/mage@latest # https://github.com/magefile/mage
i github.com/mattn/efm-langserver@latest # https://github.com/mattn/efm-langserver
i github.com/mgechev/revive@latest # https://github.com/mgechev/revive
i github.com/minamijoyo/hcledit@latest # https://github.com/minamijoyo/hcledit
i github.com/minamijoyo/tfedit@latest # https://github.com/minamijoyo/tfedit
i github.com/minamijoyo/tfmigrate@latest # https://github.com/minamijoyo/tfmigrate
i github.com/minamijoyo/tfupdate@latest # https://github.com/minamijoyo/tfupdate
i github.com/minamijoyo/myaws@latest # https://github.com/minamijoyo/myaws
i github.com/mkchoi212/fac@latest # https://github.com/mkchoi212/fac
i github.com/mrnugget/fzz@latest # https://github.com/mrnugget/fzz
i github.com/multiprocessio/dsq@latest # https://github.com/multiprocessio/dsq
i github.com/nishanths/license@latest # https://github.com/nishanths/license
i github.com/padok-team/tfautomv@latest # https://github.com/padok-team/tfautomv
i github.com/ramya-rao-a/go-outline@latest # https://github.com/ramya-rao-a/go-outline
i github.com/rhysd/actionlint/cmd/actionlint@latest # https://github.com/rhysd/actionlint
i github.com/ruilisi/css-checker@latest # https://github.com/ruilisi/css-checker
i github.com/segmentio/ksuid/cmd/ksuid@latest # https://github.com/segmentio/ksuid
i github.com/shurcooL/git-branches@latest # https://github.com/shurcooL/git-branches
i github.com/square/certstrap@latest # https://github.com/square/certstrap
i github.com/tj/node-prune@latest # https://github.com/tj/node-prune
i github.com/tomwright/dasel/cmd/dasel@latest # https://github.com/tomwright/dasel
i github.com/twpayne/chezmoi@latest # https://github.com/twpayne/chezmoi
i github.com/wader/fq@latest # https://github.com/wader/fq
i github.com/zmb3/gogetdoc@latest # https://github.com/zmb3/gogetdoc
i golang.org/x/tools/gopls@latest # https://golang.org/x/tools/gopls
i golang.org/x/tools/cmd/gorename@latest # https://golang.org/x/tools/cmd/gorename
i honnef.co/go/tools/cmd/keyify@latest # https://honnef.co/go/tools/cmd/keyify
i honnef.co/go/tools/cmd/staticcheck@latest # https://honnef.co/go/tools/cmd/staticcheck
i honnef.co/go/tools/cmd/structlayout-optimize@latest # https://honnef.co/go/tools/cmd/structlayout-optimize
i honnef.co/go/tools/cmd/structlayout-pretty@latest # https://honnef.co/go/tools/cmd/structlayout-pretty
i honnef.co/go/tools/cmd/structlayout@latest # https://honnef.co/go/tools/cmd/structlayout
