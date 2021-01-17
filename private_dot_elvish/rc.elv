use readline-binding
use direnv
use epm
use re

epm:install &silent-if-installed=$true \
  github.com/zzamboni/elvish-modules     \
  github.com/zzamboni/elvish-completions \
  github.com/zzamboni/elvish-themes      \
  github.com/xiaq/edit.elv               \
  github.com/muesli/elvish-libs          \
  github.com/iwoloschin/elvish-packages

edit:insert:binding[Alt-Backspace] = $edit:kill-small-word-left~
edit:insert:binding[Alt-d] = $edit:kill-small-word-right~

use github.com/zzamboni/elvish-modules/alias
alias:new dfc e:dfc -W -l -p -/dev/disk1s4,devfs
# alias:new ls e:ls --color=auto
alias:new more less

use github.com/xiaq/edit.elv/smart-matcher
smart-matcher:apply

use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/ssh
use github.com/zzamboni/elvish-completions/builtins

use github.com/zzamboni/elvish-completions/git
git:git-command = hub
git:init

use github.com/zzamboni/elvish-completions/comp

use github.com/zzamboni/elvish-themes/chain
chain:bold-prompt = $true

chain:segment-style = [
  &dir=          session
  &chain=        session
  &arrow=        session
  &git-combined= session
]

use github.com/muesli/elvish-libs/theme/powerline

edit:prompt-stale-transform = { each [x]{ styled $x[text] "gray" } }

edit:-prompt-eagerness = 10

use github.com/zzamboni/elvish-modules/long-running-notifications

use github.com/zzamboni/elvish-modules/bang-bang

use github.com/zzamboni/elvish-modules/dir
alias:new cd &use=[github.com/zzamboni/elvish-modules/dir] dir:cd
alias:new cdb &use=[github.com/zzamboni/elvish-modules/dir] dir:cdb

edit:insert:binding[Alt-i] = $dir:history-chooser~

edit:insert:binding[Alt-b] = $dir:left-small-word-or-prev-dir~
edit:insert:binding[Alt-f] = $dir:right-small-word-or-next-dir~

use github.com/zzamboni/elvish-modules/terminal-title

private-loaded = ?(use private)

E:LESS = "-i -R"

E:EDITOR = "vim"

E:LC_ALL = "en_US.UTF-8"

use github.com/zzamboni/elvish-modules/util

use github.com/muesli/elvish-libs/git

use github.com/iwoloschin/elvish-packages/update
update:curl-timeout = 3
update:check-commit &verbose

-exports- = (alias:export)

#CAML_LD_LIBRARY_PATH=/Users/austin/.opam/4.02.3/lib/stublibs
#MANWIDTH=80
#MANPATH=/Users/austin/.brew/share/man:/Users/austin/.fzf/man:/usr/local/share/man:/usr/local/man:/usr/share/man:/Library/TeX/Distributions/.DefaultTeX/Contents/Man:/usr/local/MacGPG2/share/man:/opt/X11/share/man:/Users/austin/.opam/4.02.3/man
#LESS_TERMCAP_mb=[01;31m
#__hzsh_zsh_root=/Users/austin/.dotfiles/zsh
#HOSTNAME=Austins-Retina-MacBook-Pro.local
#TERM_PROGRAM=Apple_Terminal
#LESS_TERMCAP_md=[01;31m
#GEM_HOME=/Users/austin/.gem/ruby/2.4.4
#LESS_TERMCAP_me=[0m
#FZF_CTRL_R_OPTS=--preview='echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'
#SHELL=/bin/zsh
#TERM=dumb
#ERL_AFLAGS=-kernel shell_history enabled shell_history_file_bytes 5242880
#TMPDIR=/var/folders/h4/9s97cl8d7_5_p6szq7qv32g00000gn/T/
#PERL5LIB=/Users/austin/perl5/lib/perl5:/Users/austin/.opam/4.02.3/lib/perl5:/Users/austin/perl5/lib/perl5:/Users/austin/.opam/4.02.3/lib/perl5:
#Apple_PubSub_Socket_Render=/private/tmp/com.apple.launchd.KisOfC1n5f/Render
#DIRENV_DIR=-/Users/austin
#TERM_PROGRAM_VERSION=404
#RUST_SRC_PATH=/Users/austin/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src
#PERL_MB_OPT=--install_base "/Users/austin/perl5"
#LESS_TERMCAP_ue=[0m
#TERM_SESSION_ID=44F88999-EC4F-4648-866A-302FFFD3FB61
#OCAML_TOPLEVEL_PATH=/Users/austin/.opam/4.02.3/lib/toplevel
#USER=austin
#RPROMPT=${vcs_info_msg_0_}
#SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.KTPhWPN9q5/Listeners
#__hzsh_plugins_git_identity_path=/Users/austin/.cache/zsh/git-identities
#PAGER=less
#FZF_DEFAULT_OPTS=--bind='ctrl-o:execute(code {})+abort,ctrl-e:execute(vim {})+abort,ctrl-v:execute(gvim {})+abort'
#DIRENV_WATCHES=eJx0zr1qwzAQAOB3udlUlk6_3jsWunQqHc7SqRW4MkiyWwh59-wheYGP7_MC7zR-YAHx0bl1QUcfpYoXrmeLMMHbnkb5ZVikQW2lMlpO8Ppf-uiwjHbwdXpGxL3m8i1SaVxPQdu2_4kYVqeyN0Q-BHKYWCFZO5vVobLOYvI-c2TJc0qcMmqfpUenUHOwnh6MLJq70dctAAD__5j8Qm4=
#PERL_LCOAL_LIB_ROOT=
#LSCOLORS=Gxfxcxdxbxegedabagacad
#LESS_TERMCAP_us=[01;32m
#OPAMUTF8MSGS=1
#PATH=/Users/austin/.gem/ruby/2.4.4/bin:/Users/austin/.rubies/ruby-2.4.4/lib/ruby/gems/2.4.0/bin:/Users/austin/.rubies/ruby-2.4.4/bin:/Users/austin/.cargo/bin:/Users/austin/perl5/bin:/Users/austin/.opam/4.02.3/bin:/Users/austin/.dotfiles/zsh/hzplugs/macvim/bin:/usr/local/texlive/2018/bin/x86_64-darwin:/Users/austin/.brew/sbin:/Users/austin/.brew/bin:/Users/austin/.dotfiles/zsh/hzplugs/mac/bin:/Users/austin/.dotfiles/zsh/hzplugs/interactive/bin:/Users/austin/.cabal/bin:/Users/austin/.dotfiles/zsh/hzplugs/golang/bin:/Users/austin/.dotfiles/zsh/hzplugs/git-hub/bin:/Users/austin/.dotfiles/zsh/hzplugs/git/bin:.git/safe/../../exe:.git/safe/../../bin:/Users/austin/.mix:/Users/austin/.kiex/bin:/Users/austin/.local/bin:/Users/austin/bin:/Users/austin/.dotfiles/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/usr/local/MacGPG2/bin:/opt/X11/bin:/Users/austin/.fzf/bin:/Users/austin/.brew/Cellar/go/1.11/libexec/bin:/Users/austin/go/bin
#__hzsh_marked_path=/Applications/Marked 2.app/
#PWD=/Users/austin
#EDITOR=vim
#LANG=en_CA.UTF-8
#FZF_ALT_C_OPTS=--preview='tree -C {} | head -200' --header-lines=1 --select-1 --exit-0
#XPC_FLAGS=0x0
#RUBY_ENGINE=ruby
#PLATFORM=Darwin
#XPC_SERVICE_NAME=0
#GPG_TTY=/dev/ttys001
#SHLVL=1
#HOME=/Users/austin
#GOROOT=/Users/austin/.brew/Cellar/go/1.11/libexec
#GEM_ROOT=/Users/austin/.rubies/ruby-2.4.4/lib/ruby/gems/2.4.0
#PROMPT=%{[36m%}%(2~.%~.%/)%{[39m%}
#%(?,%{%{[32m%}%}☺%{%{[39m%}%},%{%{[31m%}%}☹%{%{[39m%}%}) %{[32m%}%h%{[39m%} %{%(!.[31m.[33m)%}%(!.☢.‣)%{[39m%} 
#LESS=FRX
#LOGNAME=austin
#FZF_CTRL_T_OPTS=--preview='highlight -O xterm256 -l {} 2> /dev/null || bat --color=always {} || cat {} || tree -C {}' 2> /dev/null | head -200' --select-1 --exit-0
#GEM_PATH=/Users/austin/.gem/ruby/2.4.4:/Users/austin/.rubies/ruby-2.4.4/lib/ruby/gems/2.4.0
#FZF_CTRL_T_COMMAND=pt -g "" --hidden --ignore .git
#LESS_TERMCAP_so=[01;44;33m
#RUBY_ROOT=/Users/austin/.rubies/ruby-2.4.4
#GOPATH=/Users/austin/go
#REPORTTIME=2
#__hzsh_zsh_bookmarks_cache=/Users/austin/.cache/zsh/zbookmarks
#DISPLAY=/private/tmp/com.apple.launchd.681xKNFok2/org.macosforge.xquartz:0
#RUBYOPT=
#__hzsh_package_root=/Users/austin/.dotfiles/packages
#DIRENV_DIFF=eJxU0EmTmkAcBfCvMvU_Sw2yyFKVQ4sICi2yuDCXLsDuEUGGzQGcmu-eSnJIcn2_d3nvC2rQv75nUIH-BctNtDwYjhkRx4xBh2VYiPiKd-_21rXHWzKIMPunFJpGYEagQ_W8DVShQxKmSick2jE8t9VdTNd2e95avQozMDaB4ZrE2JDIc8wd6KBlvJrxIhNkJmmJxNS5JmRSJstzcSELTGKawpQFlWEGq01g7o5ktQlAB-710NG2e00eXZ9Xf_WEIsM2Q9CBbkf-2c6b4Yl85C3Fx6U8lMWCiLfu9Kj8xs6UsAlOEi7y6TRcZY0brjS29grBhvIMuBjZI5-Wc_-QsTr-OLd36mJsp1WRym_HvPBPQonL2lP3NeMe-XCz0-Fyrq3RFe9qPg-T47j3Lw-BSEV8bOi0431uaTvxyVi_efLn8SN1vfhzw2VCtM34JsP3htUHWh1sb6iuC-xuG4W_ZD1CK0Lkm-rfpR8wAzNwCVq7yPq1kStoW9HypbvSsiTXvOs_2umFVkla0sv_KWF5SUk69bR7kQVJUFUeZrB3UbT2Agw6rJJ2-P1khKyCTqBDcisGk6H3HVPfxXi5Z-iPdjRraQ86vFn-iIOn8TmhQNQi6-z4vYOZEDmJ06_OAnx__wwAAP__Mp-_kw==
#RUBY_VERSION=2.4.4
#SECURITYSESSIONID=186a8
#PERL_MM_OPT=INSTALL_BASE=/Users/austin/perl5
#__hzsh_dotfile_root=/Users/austin/.dotfiles
#LESS_TERMCAP_se=[0m
#__CF_USER_TEXT_ENCODING=0x1F5:0x0:0x52
#VIM=/Applications/MacVim.app/Contents/Resources/vim
#VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime
#MYVIMRC=/Users/austin/.vim-hz/vimrc
#SSH_ASKPASS=/Applications/MacVim.app/Contents/MacOS/macvim-askpass
#SUDO_ASKPASS=/Applications/MacVim.app/Contents/MacOS/macvim-askpass
#GIT_TERMINAL_PROMPT=
#rubies_path=/Users/austin/.rubies
#ROWS=62
#LINES=62
#COLUMNS=106
#COLORS=16777216
#VIM_SERVERNAME=VIM
#OLDPWD=/Users/austin
#_=/usr/bin/env
