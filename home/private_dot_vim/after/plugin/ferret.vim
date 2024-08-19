vim9script

if !packix#IsPluginInstalled('wincent/ferret')
  finish
endif

nmap <unique> <leader>ff <Plug>(FerretAck)
nmap <unique> <leader>fl <Plug>(FerretAck)
nmap <unique> <leader>fr <Plug>(FerretAcks)
nmap <unique> <leader>fs <Plug>(FerretAckWord)
