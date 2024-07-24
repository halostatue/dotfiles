vim9script

if !exists(':Scope')
  finish
endif

import autoload 'scope/fuzzy.vim'
import autoload 'scope/task.vim'
import autoload 'scope/popup.vim'

def FindGit()
  var dir = system("git rev-parse --show-toplevel 2>/dev/null")->trim()

  if v:shell_error != 0 || dir == getcwd()
    dir = '.'
  endif

  fuzzy.File(fuzzy.FindCmd(dir))
enddef

# Helper function: Filter a list of files using fuzzy matching on typed string
#
# 'lst'     represents a list of all files where each list entry is a dict of
#           the form `{ text: filename }`
# 'prompt'  string is what the user typed so far
def FilterItems(lst: list<dict<any>>, prompt: string): list<any>
  if prompt->empty()
    # when nothing is typed display all files in the popup window
    return [lst, [lst]]
  else
    var pat = prompt->trim()
    var matches = lst->matchfuzzypos(pat, {key: "text", limit: 1000})
    # return both the original list and filtered list
    return [lst, matches]
  endif
enddef

def FindFile()
  # create the popup object
  var menu: popup.FilterMenu = popup.FilterMenu.new(
    "File",
    [],
    (res, _key) => {
      execute $"e {res.text}"
    },
    null_function,
    FilterItems
  )

  # create async job object
  var job: task.AsyncCmd

  job = task.AsyncCmd.new('fd -tf --follow'->split(),
    (items: list<string>) => {
      # this function is called periodically as new file names are received
      if menu.Closed()
        job.Stop()
      endif

      var items_dict: list<dict<any>> = items->mapnew((_, v) => {
        return { text: v }
      })

      # stop after 10000 files (for example)
      if !menu.SetText(items_dict, FilterItems, 10000)
        job.Stop()
      endif
    })
enddef

nnoremap <leader>tf <scriptcmd>FindGit()<CR>
nnoremap <leader>tF <scriptcmd>FindFile()<CR>
nnoremap <leader>tg <scriptcmd>fuzzy.Grep('rg --vimgrep --smart-case')<CR>
nnoremap <leader>tG <scriptcmd>fuzzy.Grep('rg --vimgrep --smart-case', true, '<cword>')<CR>
nnoremap <leader>tb <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <leader>tB <scriptcmd>fuzzy.Buffer(true)<CR>
nnoremap <leader>ts <scriptcmd>fuzzy.BufSearch()<CR>
nnoremap <leader>tq <scriptcmd>fuzzy.Quickfix()<CR>
nnoremap <leader>tQ <scriptcmd>fuzzy.QuickfixHistory()<CR>
nnoremap <leader>tl <scriptcmd>fuzzy.Loclist()<CR>
nnoremap <leader>tL <scriptcmd>fuzzy.LoclistHistory()<CR>

nnoremap <leader>ta <scriptcmd>fuzzy.Autocmd()<CR>
nnoremap <leader>t: <scriptcmd>fuzzy.CmdHistory()<CR>
nnoremap <leader>tc <scriptcmd>fuzzy.Colorscheme()<CR>
nnoremap <leader>t; <scriptcmd>fuzzy.Command()<CR>
nnoremap <leader>tw <scriptcmd>fuzzy.Window()<CR>

# fuzzy.Filetype()	File types
# fuzzy.GitFile()	Files under git
# fuzzy.Help()	Vim help topics (tags)
# fuzzy.HelpfilesGrep()	Live grep Vim help files (doc/*.txt)
# fuzzy.Highlight()	Highlight groups
# fuzzy.Jumplist()	:h jumplist
# fuzzy.Keymap()	Key mappings, go to their declaration on <cr>
# fuzzy.LspDocumentSymbol()	Symbols supplied by Lsp
# fuzzy.MRU()	:h v:oldfiles
# fuzzy.Mark()	Vim marks (:h mark-motions)
# fuzzy.Option()	Vim options and their values
# fuzzy.Register()	Vim registers, paste contents on <cr>
# fuzzy.Tag()	:h ctags search

augroup scope-quickfix-history
  autocmd!

  autocmd QuickFixCmdPost chistory cwindow
  autocmd QuickFixCmdPost lhistory lwindow
augroup END

defcompile
