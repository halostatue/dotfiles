vim9script

if !exists(':PickerEdit')
  finish
endif

if mapcheck('<Plug>(PickerEdit)') != ''
  nmap <unique> <leader>pe <Plug>(PickerEdit)
  nmap <unique> <leader>ps <Plug>(PickerSplit)
  nmap <unique> <leader>pt <Plug>(PickerTabedit)
  nmap <unique> <leader>pv <Plug>(PickerVsplit)
  nmap <unique> <leader>pb <Plug>(PickerBuffer)
  nmap <unique> <leader>p] <Plug>(PickerTag)
  nmap <unique> <leader>pw <Plug>(PickerStag)
  nmap <unique> <leader>po <Plug>(PickerBufferTag)
  nmap <unique> <leader>ph <Plug>(PickerHelp)
endif
