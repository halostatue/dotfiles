#! /usr/bin/env fish

# go-install TARGET URI [VERSION] [-- COMMENT INFORMATION]
#
# TARGET is mandatory, but ignored. (It's used to help sort the binary list.)
#
# If URI is missing what looks like a hostname (^(\w+.)+\w+/), github.com
# will be prepended.
#
# If VERSION is omitted, latest will be specified.
#
# Comment information, if provided, must follow the literal --.
#
# Examples
#
# go-install age filippo.io/age/cmd/... v1 -- https://github.com/filosottile/age
# # go install filippo.io/age/cmd...@v1
#
# go-install gldv aarzilli/gdlv -- https://github.com/aarzilli/gdlv
# # go install github.com/aarzilli/gdlv@latest
function go-install
    set --local target $argv[1]
    set --local package_uri $argv[2]
    set --local package_version latest

    if not string match --regex --quiet '^(?:\w+\.)+\w+/' $package_uri
        set package_uri github.com/$package_uri
    end

    if test (count $argv) -gt 2 && test $argv[3] != --
        set package_version $argv[3]
    end

    set --local install_uri $package_uri@$package_version
    set --local app $target@$package_version

    printf ">>> Installing %s: %-50s\r" $app $install_uri

    if set --local output (go install $install_uri 2>&1 >/dev/null)
        printf ">>> Installed %s: %-50s\n" $app $install_uri
    else
        set --local error $status
        printf "!!! Error installing %s: %-50s\n" $app $install_uri
        printf "!!!       %s\n" $output
        exit $error
    end
end

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

go-install actionlint rhysd/actionlint/cmd/actionlint -- https://github.com/rhysd/actionlint
go-install age filippo.io/age/cmd/... v1 -- https://github.com/filosottile/age
go-install certstrap square/certstrap -- https://github.com/square/certstrap
go-install checkmake mrtazz/checkmake/cmd/checkmake -- https://github.com/mrtazz/checkmake
go-install chezmoi twpayne/chezmoi -- https://github.com/twpayne/chezmoi
go-install css-checker ruilisi/css-checker -- https://github.com/ruilisi/css-checker
go-install dasel tomwright/dasel/cmd/dasel -- https://github.com/tomwright/dasel
go-install dlv go-delve/delve/cmd/dlv -- https://github.com/go-delve/delve
go-install dsq multiprocessio/dsq -- https://github.com/multiprocessio/dsq
go-install echo-server jmalloc/echo-server/... -- https://github.com/jmalloc/echo-server
go-install editorconfig-checker editorconfig-checker/editorconfig-checker/cmd/editorconfig-checker -- https://github.com/editorconfig-checker/editorconfig-checker/cmd/editorconfig-checker
go-install efm-langserver mattn/efm-langserver -- https://github.com/mattn/efm-langserver
go-install errcheck kisielk/errcheck -- https://github.com/kisielk/errcheck
go-install fac mkchoi212/fac -- https://github.com/mkchoi212/fac
go-install fillstruct davidrjenni/reftools/cmd/fillstruct -- https://github.com/davidrjenni/reftools
go-install fillswitch davidrjenni/reftools/cmd/fillswitch -- https://github.com/davidrjenni/reftools
go-install fixplurals davidrjenni/reftools/cmd/fixplurals -- https://github.com/davidrjenni/reftools
go-install fq wader/fq -- https://github.com/wader/fq
go-install fzz mrnugget/fzz -- https://github.com/mrnugget/fzz
go-install gdlv aarzilli/gdlv -- https://github.com/aarzilli/gdlv
go-install git-branches shurcooL/git-branches -- https://github.com/shurcooL/git-branches
go-install go-outline ramya-rao-a/go-outline -- https://github.com/ramya-rao-a/go-outline
go-install go-symbols acroca/go-symbols -- https://github.com/acroca/go-symbols
go-install goawk benhoyt/goawk -- https://github.com/benhoyt/goawk
go-install gogetdoc zmb3/gogetdoc -- https://github.com/zmb3/gogetdoc
go-install golangci-lint golangci/golangci-lint/cmd/golangci-lint -- https://github.com/golangci/golangci-lint
go-install gomodifytags fatih/gomodifytags -- https://github.com/fatih/gomodifytags
go-install gopls golang.org/x/tools/gopls -- https://golang.org/x/tools/gopls
go-install gorename golang.org/x/tools/cmd/gorename -- https://golang.org/x/tools/cmd/gorename
go-install gotags jstemmer/gotags -- https://github.com/jstemmer/gotags
go-install graphjin dosco/graphjin -- https://github.com/dosco/graphjin
go-install hcledit minamijoyo/hcledit -- https://github.com/minamijoyo/hcledit
go-install iferr koron/iferr -- https://github.com/koron/iferr
go-install impl josharian/impl -- https://github.com/josharian/impl
go-install inframap cycloidio/inframap -- https://github.com/cycloidio/inframap
go-install jump gsamokovarov/jump -- https://github.com/gsamokovarov/jump
go-install keyify honnef.co/go/tools/cmd/keyify -- https://honnef.co/go/tools/cmd/keyify
go-install ksuid/cmd/ksuid segmentio/ksuid/cmd/ksuid -- https://github.com/segmentio/ksuid
go-install lazygit jesseduffield/lazygit -- https://github.com/jesseduffield/lazygit
go-install lefthook evilmartians/lefthook -- https://github.com/evilmartians/lefthook
go-install license nishanths/license -- https://github.com/nishanths/license
go-install mage magefile/mage -- https://github.com/magefile/mage
go-install mark kovetskiy/mark -- https://github.com/kovetskiy/mark
go-install motion fatih/motion -- https://github.com/fatih/motion
go-install myaws minamijoyo/myaws -- https://github.com/minamijoyo/myaws
go-install node-prune tj/node-prune -- https://github.com/tj/node-prune
go-install oauth2c cloudentity/oauth2c -- https://github.com/cloudentity/oauth2c
go-install psqldef k0kubun/sqldef/cmd/psqldef -- https://github.com/k0kubun/sqldef
go-install pxl ichinaski/pxl -- https://github.com/ichinaski/pxl
go-install revive mgechev/revive -- https://github.com/mgechev/revive
go-install scc boyter/scc -- https://github.com/boyter/scc
go-install sqlite3def k0kubun/sqldef/cmd/sqlite3def -- https://github.com/k0kubun/sqldef
go-install sqls lighttiger2505/sqls -- https://github.com/lighttiger2505/sqls
go-install staticcheck honnef.co/go/tools/cmd/staticcheck -- https://honnef.co/go/tools/cmd/staticcheck
go-install structlayout honnef.co/go/tools/cmd/structlayout -- https://honnef.co/go/tools/cmd/structlayout
go-install structlayout-optimize honnef.co/go/tools/cmd/structlayout-optimize -- https://honnef.co/go/tools/cmd/structlayout-optimize
go-install structlayout-pretty honnef.co/go/tools/cmd/structlayout-pretty -- https://honnef.co/go/tools/cmd/structlayout-pretty
go-install tfautomv padok-team/tfautomv -- https://github.com/padok-team/tfautomv
go-install tfedit minamijoyo/tfedit -- https://github.com/minamijoyo/tfedit
go-install tfmigrate minamijoyo/tfmigrate -- https://github.com/minamijoyo/tfmigrate
go-install tfupdate minamijoyo/tfupdate -- https://github.com/minamijoyo/tfupdate
