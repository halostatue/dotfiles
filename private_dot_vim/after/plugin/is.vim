scriptencoding utf-8

if maparg('<Plug>(anzu-n-with-echo)') !=# ''
  nmap n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zz
  nmap N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zz

  if maparg('<Plug>(asterisk-z*)') !=# ''
    nmap * <Plug>(asterisk-z*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)
    nmap g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)
    nmap # <Plug>(asterisk-z#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)
    nmap g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)<Plug>(anzu-search-status-update)
  else
    nmap * <Plug>(is-star)<Plug>(anzu-search-status-update)
    nmap g* <Plug>(is-gstar)<Plug>(anzu-search-status-update)
    nmap # <Plug>(is-#)<Plug>(anzu-search-status-update)
    nmap g# <Plug>(is-g#)<Plug>(anzu-search-status-update)
  endif
else
  nmap n <Plug>(is-n)zz
  nmap N <Plug>(is-N)zz

  if maparg('<Plug>(asterisk-z*)') !=# ''
    nmap * <Plug>(asterisk-z*)<Plug>(is-nohl-1)
    nmap g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
    nmap # <Plug>(asterisk-z#)<Plug>(is-nohl-1)
    nmap g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
  else
    nmap * <Plug>(is-star)
    nmap g* <Plug>(is-gstar)
    nmap # <Plug>(is-#)
    nmap g# <Plug>(is-g#)
  endif
endif
