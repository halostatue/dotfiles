" Vim color file --- psc (peak sea color) "Lite version"
" Maintainer:   Pan, Shi Zhu <Go to the following URL for my email>
" URL:          https://www.vim.org/scripts/script.php?script_id=760
"               https://github.com/vim-scripts/peaksea.git
" Last Change:  25 Mon 2019
" Version:      3.7
"
"     This version is from vim-scripts/peaksea/pull#2.
"
"     Comments and e-mails are welcomed, thanks.
"
"     The peaksea color is simply a colorscheme with the default settings of
"     the original ps_color. Lite version means there's no custom settings
"     and fancy features such as integration with reloaded.vim
"
"     The full version of ps_color.vim will be maintained until Vim 8.
"     By then there will be only the lite version: peaksea.vim
"
" Note: Please set the background option in your .vimrc and/or .gvimrc
"
"     It is much better *not* to set 'background' option inside
"     a colorscheme file.  because ":set background" improperly
"     may cause colorscheme be sourced twice
"
" Color Scheme Overview:
"     :ru syntax/hitest.vim
"     :ru syntax/colortest.vim
"
" Relevant Help:
"     :h highlight
"     :h highlight-args
"     :h highlight-groups
"     :h highlight-link
"     :h gui-colors
"     :h cterm-colors
"
" Colors Order:
"     #rrggbb
"

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = expand("<sfile>:t:r")

" I don't want to abuse folding, but here folding is used to avoid confusion.
if &background=='light'
  " for background=light {{{2
  " LIGHT COLOR DEFINE START

  hi Normal             guifg=#000000   guibg=#e0e0e0   gui=NONE
  hi Search             guifg=Red       guibg=White     gui=NONE
  hi Visual             guifg=NONE      guibg=#a6caf0   gui=NONE
  hi Cursor             guifg=#f0f0f0   guibg=#008000   gui=NONE
  hi CursorIM           guifg=#f0f0f0   guibg=#800080   gui=NONE
  hi Special            guifg=#907000   guibg=NONE      gui=NONE
  hi Comment            guifg=#606000   guibg=NONE      gui=NONE
  hi Number             guifg=#907000   guibg=NONE      gui=NONE
  hi Constant           guifg=#007068   guibg=NONE      gui=NONE
  hi StatusLine         guifg=fg        guibg=#a6caf0   gui=NONE
  hi LineNr             guifg=#000000   guibg=#c0d0e0   gui=NONE
  hi Question           guifg=fg        guibg=#d0d090   gui=NONE
  hi PreProc            guifg=#009030   guibg=NONE      gui=NONE
  hi Statement          guifg=#2060a8   guibg=NONE      gui=NONE
  hi Type               guifg=#0850a0   guibg=NONE      gui=NONE
  hi Todo               guifg=#800000   guibg=#e0e090   gui=NONE
  " Note: THIS IS IN THE WARM SECTION
  hi Error              guifg=#c03000   guibg=NONE      gui=NONE
  hi Identifier         guifg=#a030a0   guibg=NONE      gui=NONE
  hi ModeMsg            guifg=fg        guibg=#b0b0e0   gui=NONE
  hi VisualNOS          guifg=fg        guibg=#b0b0e0   gui=NONE
  hi SpecialKey         guifg=#1050a0   guibg=NONE      gui=NONE
  hi NonText            guifg=#002090   guibg=#d0d0d0   gui=NONE
  hi Directory          guifg=#a030a0   guibg=NONE      gui=NONE
  hi ErrorMsg           guifg=fg        guibg=#f0b090   gui=NONE
  hi MoreMsg            guifg=#489000   guibg=NONE      gui=NONE
  hi Title              guifg=#a030a0   guibg=NONE      gui=NONE
  hi WarningMsg         guifg=#b02000   guibg=NONE      gui=NONE
  hi WildMenu           guifg=fg        guibg=#d0d090   gui=NONE
  hi Folded             guifg=NONE      guibg=#b0e0b0   gui=NONE
  hi FoldColumn         guifg=fg        guibg=#90e090   gui=NONE
  hi DiffAdd            guifg=NONE      guibg=#b0b0e0   gui=NONE
  hi DiffChange         guifg=NONE      guibg=#e0b0e0   gui=NONE
  hi DiffDelete         guifg=#002090   guibg=#d0d0d0   gui=NONE
  hi DiffText           guifg=NONE      guibg=#c0e080   gui=NONE
  hi SignColumn         guifg=fg        guibg=#90e090   gui=NONE

  hi IncSearch          guifg=#f0f0f0   guibg=#806060   gui=NONE
  hi StatusLineNC       guifg=fg        guibg=#c0c0c0   gui=NONE
  hi VertSplit          guifg=fg        guibg=#c0c0c0   gui=NONE
  hi Underlined         guifg=#6a5acd   guibg=NONE      gui=underline
  hi Ignore             guifg=bg        guibg=NONE
  " Note: THIS IS IN THE WARM SECTION
  if v:version >= 700
    if has('spell')
      hi SpellBad       guifg=NONE      guibg=NONE      guisp=#c03000
      hi SpellCap       guifg=NONE      guibg=NONE      guisp=#2060a8
      hi SpellRare      guifg=NONE      guibg=NONE      guisp=#a030a0
      hi SpellLocal     guifg=NONE      guibg=NONE      guisp=#007068
    endif
    hi Pmenu            guifg=fg        guibg=#e0b0e0
    hi PmenuSel         guifg=#f0f0f0   guibg=#806060   gui=NONE
    hi PmenuSbar        guifg=fg        guibg=#c0c0c0   gui=NONE
    hi PmenuThumb       guifg=fg        guibg=#c0e080   gui=NONE
    hi TabLine          guifg=fg        guibg=#c0c0c0   gui=NONE
    hi TabLineFill      guifg=fg        guibg=#c0c0c0   gui=NONE
    hi TabLineSel       guifg=fg        guibg=NONE      gui=NONE
    hi CursorColumn     guifg=NONE      guibg=#f0b090
    hi CursorLine       guifg=NONE      guibg=#c0c0c0   gui=underline
    hi MatchParen       guifg=NONE      guibg=#c0e080
  endif
  if v:version >= 800
    hi CursorLineNr     guifg=#686868   guibg=NONE      gui=underline
  endif

  " LIGHT COLOR DEFINE END

  " Vim 7 added stuffs
  if v:version >= 700
    hi Ignore           gui=NONE

    " the gui=undercurl guisp could only support in Vim 7
    if has('spell')
      hi SpellBad       gui=undercurl
      hi SpellCap       gui=undercurl
      hi SpellRare      gui=undercurl
      hi SpellLocal     gui=undercurl
    endif
    hi TabLine          gui=underline
    hi TabLineFill      gui=underline
    hi CursorLine       gui=underline
  endif

  " For reversed stuffs, clear the reversed prop and set the bold prop again
  hi IncSearch          gui=bold
  hi StatusLine         gui=NONE
  hi StatusLineNC       gui=NONE
  hi VertSplit          gui=bold
  hi Visual             gui=bold

  " Enable the bold property
  hi Question           gui=bold
  hi DiffText           gui=bold
  hi Statement          gui=bold
  hi Type               gui=bold
  hi MoreMsg            gui=bold
  hi ModeMsg            gui=bold
  hi NonText            gui=bold
  hi Title              gui=bold
  hi DiffDelete         gui=bold
  hi TabLineSel         gui=bold

  " gui define for background=light end here

  " generally, a dumb terminal is dark, we assume the light terminal has 256
  " color support.
  if &t_Co==8 || &t_Co==16
    set t_Co=256
  endif
  if &t_Co==256
    " 256color light terminal support here

    hi Normal           ctermfg=16      ctermbg=254     cterm=NONE
    " Comment/Uncomment the following line to disable/enable transparency
    "hi Normal           ctermfg=16      ctermbg=NONE    cterm=NONE
    hi Search           ctermfg=NONE    ctermbg=231     cterm=NONE
    hi Visual           ctermfg=NONE    ctermbg=153     cterm=NONE
    hi Cursor           ctermfg=255     ctermbg=28      cterm=NONE
    hi CursorIM         ctermfg=255     ctermbg=90      cterm=NONE
    hi Special          ctermfg=94      ctermbg=NONE    cterm=NONE
    hi Comment          ctermfg=58      ctermbg=NONE    cterm=NONE
    hi Number           ctermfg=94      ctermbg=NONE    cterm=NONE
    hi Constant         ctermfg=23      ctermbg=NONE    cterm=NONE
    hi StatusLine       ctermfg=fg      ctermbg=153     cterm=NONE
    hi LineNr           ctermfg=242     ctermbg=NONE    cterm=NONE
    hi Question         ctermfg=fg      ctermbg=186     cterm=NONE
    hi PreProc          ctermfg=28      ctermbg=NONE    cterm=NONE
    hi Statement        ctermfg=25      ctermbg=NONE    cterm=NONE
    hi Type             ctermfg=25      ctermbg=NONE    cterm=NONE
    hi Todo             ctermfg=88      ctermbg=186     cterm=NONE
    " Note: THIS IS IN THE WARM SECTION
    hi Error            ctermfg=160     ctermbg=NONE    cterm=NONE
    hi Identifier       ctermfg=127     ctermbg=NONE    cterm=NONE
    hi ModeMsg          ctermfg=fg      ctermbg=146     cterm=NONE
    hi VisualNOS        ctermfg=fg      ctermbg=146     cterm=NONE
    hi SpecialKey       ctermfg=25      ctermbg=NONE    cterm=NONE
    hi NonText          ctermfg=18      ctermbg=252     cterm=NONE
    " Comment/Uncomment the following line to disable/enable transparency
    "hi NonText          ctermfg=18      ctermbg=NONE    cterm=NONE
    hi Directory        ctermfg=127     ctermbg=NONE    cterm=NONE
    hi ErrorMsg         ctermfg=fg      ctermbg=216     cterm=NONE
    hi MoreMsg          ctermfg=64      ctermbg=NONE    cterm=NONE
    hi Title            ctermfg=127     ctermbg=NONE    cterm=NONE
    hi WarningMsg       ctermfg=124     ctermbg=NONE    cterm=NONE
    hi WildMenu         ctermfg=fg      ctermbg=186     cterm=NONE
    hi Folded           ctermfg=NONE    ctermbg=151     cterm=NONE
    hi FoldColumn       ctermfg=fg      ctermbg=114     cterm=NONE
    hi DiffAdd          ctermfg=NONE    ctermbg=146     cterm=NONE
    hi DiffChange       ctermfg=NONE    ctermbg=182     cterm=NONE
    hi DiffDelete       ctermfg=18      ctermbg=252     cterm=NONE
    hi DiffText         ctermfg=NONE    ctermbg=150     cterm=NONE
    hi SignColumn       ctermfg=fg      ctermbg=114     cterm=NONE

    hi IncSearch        ctermfg=255     ctermbg=95      cterm=NONE
    hi StatusLineNC     ctermfg=fg      ctermbg=250     cterm=NONE
    hi VertSplit        ctermfg=fg      ctermbg=250     cterm=NONE
    hi Underlined       ctermfg=62      ctermbg=NONE    cterm=underline
    hi Ignore           ctermfg=bg      ctermbg=NONE
    " Note: THIS IS IN THE WARM SECTION
    if v:version >= 700
      if has('spell')
        if 0
          " ctermsp is not supported in Vim7, we ignore it.
          hi SpellBad   cterm=undercurl ctermbg=NONE    ctermfg=160
          hi SpellCap   cterm=undercurl ctermbg=NONE    ctermfg=25
          hi SpellRare  cterm=undercurl ctermbg=NONE    ctermfg=127
          hi SpellLocal cterm=undercurl ctermbg=NONE    ctermfg=23
        else
          hi SpellBad   cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellCap   cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellRare  cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellLocal cterm=undercurl ctermbg=NONE    ctermfg=NONE
        endif
      endif
      hi Pmenu          ctermfg=fg      ctermbg=182
      hi PmenuSel       ctermfg=255     ctermbg=95      cterm=NONE
      hi PmenuSbar      ctermfg=fg      ctermbg=250     cterm=NONE
      hi PmenuThumb     ctermfg=fg      ctermbg=150     cterm=NONE
      hi TabLine        ctermfg=fg      ctermbg=250     cterm=NONE
      hi TabLineFill    ctermfg=fg      ctermbg=250     cterm=NONE
      hi TabLineSel     ctermfg=fg      ctermbg=NONE    cterm=NONE
      hi CursorColumn   ctermfg=NONE    ctermbg=216
      hi CursorLine     ctermfg=NONE    ctermbg=NONE    cterm=underline
      hi MatchParen     ctermfg=NONE    ctermbg=150
    endif
    if v:version >= 800
      hi CursorLineNr   ctermfg=242     ctermbg=NONE    cterm=underline
    endif

    hi TabLine          cterm=underline
    hi TabLineFill      cterm=underline
    hi CursorLine       cterm=underline

    " For reversed stuffs, clear the reversed prop and set the bold prop again
    hi IncSearch        cterm=bold
    hi StatusLine       cterm=bold
    hi StatusLineNC     cterm=bold
    hi VertSplit        cterm=bold
    hi Visual           cterm=bold

    hi NonText          cterm=bold
    hi Question         cterm=bold
    hi Title            cterm=bold
    hi DiffDelete       cterm=bold
    hi DiffText         cterm=bold
    hi Statement        cterm=bold
    hi Type             cterm=bold
    hi MoreMsg          cterm=bold
    hi ModeMsg          cterm=bold
    hi TabLineSel       cterm=bold

    "hi lCursor          ctermfg=bg       ctermbg=fg     cterm=NONE
  endif " t_Co==256
  " }}}2
elseif &background=='dark'
  " for background=dark {{{2
  " DARK COLOR DEFINE START

  hi Normal             guifg=#d0d0d0    guibg=#202020  gui=NONE
  hi Comment            guifg=#d0d090    guibg=NONE     gui=NONE
  hi Constant           guifg=#80c0e0    guibg=NONE     gui=NONE
  hi Number             guifg=#e0c060    guibg=NONE     gui=NONE
  hi Identifier         guifg=#f0c0f0    guibg=NONE     gui=NONE
  hi Statement          guifg=#c0d8f8    guibg=NONE     gui=NONE
  hi PreProc            guifg=#60f080    guibg=NONE     gui=NONE
  hi Type               guifg=#b0d0f0    guibg=NONE     gui=NONE
  hi Special            guifg=#e0c060    guibg=NONE     gui=NONE
  hi Error              guifg=#f08060    guibg=NONE     gui=NONE
  hi Todo               guifg=#800000    guibg=#d0d090  gui=NONE
  hi Search             guifg=NONE       guibg=#800000  gui=NONE
  hi Visual             guifg=#000000    guibg=#a6caf0  gui=NONE
  hi Cursor             guifg=#000000    guibg=#00f000  gui=NONE
  " Note: THIS IS IN THE COOL SECTION
  hi CursorIM           guifg=#000000    guibg=#f0c0f0  gui=NONE
  hi StatusLine         guifg=#000000    guibg=#a6caf0  gui=NONE
  hi LineNr             guifg=#b0b0b0    guibg=NONE     gui=NONE
  hi Question           guifg=#000000    guibg=#d0d090  gui=NONE
  hi ModeMsg            guifg=fg         guibg=#000080  gui=NONE
  hi VisualNOS          guifg=fg         guibg=#000080  gui=NONE
  hi SpecialKey         guifg=#b0d0f0    guibg=NONE     gui=NONE
  hi NonText            guifg=#6080f0    guibg=#101010  gui=NONE
  hi Directory          guifg=#80c0e0    guibg=NONE     gui=NONE
  hi ErrorMsg           guifg=#d0d090    guibg=#800000  gui=NONE
  hi MoreMsg            guifg=#c0e080    guibg=NONE     gui=NONE
  hi Title              guifg=#f0c0f0    guibg=NONE     gui=NONE
  hi WarningMsg         guifg=#f08060    guibg=NONE     gui=NONE
  hi WildMenu           guifg=#000000    guibg=#d0d090  gui=NONE
  hi Folded             guifg=NONE       guibg=#004000  gui=NONE
  hi FoldColumn         guifg=#e0e0e0    guibg=#008000  gui=NONE
  hi DiffAdd            guifg=NONE       guibg=#000080  gui=NONE
  hi DiffChange         guifg=NONE       guibg=#800080  gui=NONE
  hi DiffDelete         guifg=#6080f0    guibg=#202020  gui=NONE
  hi DiffText           guifg=#000000    guibg=#c0e080  gui=NONE
  hi SignColumn         guifg=#e0e0e0    guibg=#008000  gui=NONE
  hi IncSearch          guifg=#000000    guibg=#d0d0d0  gui=NONE
  hi StatusLineNC       guifg=#000000    guibg=#c0c0c0  gui=NONE
  hi VertSplit          guifg=#000000    guibg=#c0c0c0  gui=NONE
  hi Underlined         guifg=#80a0ff    guibg=NONE     gui=underline
  hi Ignore             guifg=#000000    guibg=NONE
  " Note: THIS IS IN THE COOL SECTION
  if v:version >= 700
    if has('spell')
    " the guisp= could only support in Vim 7
      hi SpellBad       guifg=NONE       guibg=NONE     guisp=#f08060
      hi SpellCap       guifg=NONE       guibg=NONE     guisp=#6080f0
      hi SpellRare      guifg=NONE       guibg=NONE     guisp=#f0c0f0
      hi SpellLocal     guifg=NONE       guibg=NONE     guisp=#c0d8f8
    endif
    hi Pmenu            guifg=fg         guibg=#800080
    hi PmenuSel         guifg=#000000    guibg=#d0d0d0  gui=NONE
    hi PmenuSbar        guifg=fg         guibg=#000080  gui=NONE
    hi PmenuThumb       guifg=fg         guibg=#008000  gui=NONE
    hi TabLine          guifg=fg         guibg=#008000  gui=NONE
    hi TabLineFill      guifg=fg         guibg=#008000  gui=NONE
    hi TabLineSel       guifg=fg         guibg=NONE     gui=NONE
    hi CursorColumn     guifg=NONE       guibg=#800000  gui=NONE
    hi CursorLine       guifg=NONE       guibg=NONE     gui=underline
    hi MatchParen       guifg=NONE       guibg=#800080
  endif
  if v:version >= 800
    hi CursorLineNr     guifg=#b0b0b0    guibg=NONE     gui=underline
  endif

  " DARK COLOR DEFINE END

  " Vim 7 added stuffs
  if v:version >= 700
    hi Ignore           gui=NONE

    " the gui=undercurl could only support in Vim 7
    if has('spell')
      hi SpellBad       gui=undercurl
      hi SpellCap       gui=undercurl
      hi SpellRare      gui=undercurl
      hi SpellLocal     gui=undercurl
    endif
    hi TabLine          gui=underline
    hi TabLineFill      gui=underline
    hi Underlined       gui=underline
    hi CursorLine       gui=underline
  endif

  " gui define for background=dark end here

  if &t_Co==8 || &t_Co==16
    " for 8-color and 16-color term
    hi Normal           ctermfg=LightGrey   ctermbg=NONE
    hi Special          ctermfg=Yellow      ctermbg=NONE
    hi Comment          ctermfg=DarkYellow  ctermbg=NONE
    hi Constant         ctermfg=Blue        ctermbg=NONE
    hi Number           ctermfg=Yellow      ctermbg=NONE
    hi LineNr           ctermfg=DarkGrey    ctermbg=NONE
    hi PreProc          ctermfg=Green       ctermbg=NONE
    hi Statement        ctermfg=Cyan        ctermbg=NONE
    hi Type             ctermfg=Cyan        ctermbg=NONE
    hi Error            ctermfg=Red         ctermbg=NONE
    hi Identifier       ctermfg=Magenta     ctermbg=NONE
    hi SpecialKey       ctermfg=Cyan        ctermbg=NONE
    hi NonText          ctermfg=Blue        ctermbg=NONE
    hi Directory        ctermfg=Blue        ctermbg=NONE
    hi MoreMsg          ctermfg=Green       ctermbg=NONE
    hi Title            ctermfg=Magenta     ctermbg=NONE
    hi WarningMsg       ctermfg=Red         ctermbg=NONE
    hi DiffDelete       ctermfg=Blue        ctermbg=NONE

    hi Search           ctermfg=NONE        ctermbg=DarkRed
    hi Visual           ctermfg=Black       ctermbg=DarkCyan
    hi Cursor           ctermfg=Black       ctermbg=Green
    hi StatusLine       ctermfg=Black       ctermbg=DarkCyan
    hi Question         ctermfg=Black       ctermbg=DarkYellow
    hi Todo             ctermfg=DarkRed     ctermbg=DarkYellow
    hi Folded           ctermfg=White       ctermbg=DarkGreen
    hi ModeMsg          ctermfg=Grey        ctermbg=DarkBlue
    hi VisualNOS        ctermfg=Grey        ctermbg=DarkBlue
    hi ErrorMsg         ctermfg=DarkYellow  ctermbg=DarkRed
    hi WildMenu         ctermfg=Black       ctermbg=DarkYellow
    hi FoldColumn       ctermfg=White       ctermbg=DarkGreen
    hi SignColumn       ctermfg=White       ctermbg=DarkGreen
    hi DiffText         ctermfg=Black       ctermbg=DarkYellow

    if v:version >= 700
      if has('spell')
        hi SpellBad     ctermfg=NONE        ctermbg=DarkRed
        hi SpellCap     ctermfg=NONE        ctermbg=DarkBlue
        hi SpellRare    ctermfg=NONE        ctermbg=DarkMagenta
        hi SpellLocal   ctermfg=NONE        ctermbg=DarkGreen
      endif
      hi Pmenu          ctermfg=fg          ctermbg=DarkMagenta
      hi PmenuSel       ctermfg=Black       ctermbg=fg
      hi PmenuSbar      ctermfg=fg          ctermbg=DarkBlue
      hi PmenuThumb     ctermfg=fg          ctermbg=DarkGreen
      hi TabLine        ctermfg=fg          ctermbg=DarkGreen    cterm=underline
      hi TabLineFill    ctermfg=fg          ctermbg=DarkGreen    cterm=underline
      hi CursorColumn   ctermfg=NONE        ctermbg=DarkRed

      hi TabLineSel     ctermfg=fg          ctermbg=NONE
      hi CursorLine     ctermfg=NONE        ctermbg=NONE         cterm=underline

      hi MatchParen     ctermfg=NONE        ctermbg=DarkMagenta
    endif
    if v:version >= 800
      hi CursorLineNr   ctermfg=DarkGrey    ctermbg=NONE         cterm=underline
    endif
    if &t_Co==8
      " 8-color terminal support, this assumes 16-color is available through
      " setting the 'bold' attribute, will get bright foreground color.
      " However, the bright background color is not available for 8-color terms.
      "
      " You can manually set t_Co=16 in your .vimrc to see if your terminal
      " supports 16-color
      hi DiffText       cterm=NONE
      hi Visual         cterm=NONE
      hi Cursor         cterm=NONE
      hi Comment        cterm=NONE
      hi Todo           cterm=NONE
      hi StatusLine     cterm=NONE
      hi Question       cterm=NONE
      hi DiffChange     cterm=NONE
      hi ModeMsg        cterm=NONE
      hi VisualNOS      cterm=NONE
      hi ErrorMsg       cterm=NONE
      hi WildMenu       cterm=NONE
      hi DiffAdd        cterm=NONE
      hi Folded         cterm=NONE
      hi DiffDelete     cterm=NONE
      hi Normal         cterm=NONE
      hi PmenuThumb     cterm=NONE
      hi Search         cterm=bold
      hi Special        cterm=bold
      hi Constant       cterm=bold
      hi Number         cterm=bold
      hi LineNr         cterm=bold
      hi PreProc        cterm=bold
      hi Statement      cterm=bold
      hi Type           cterm=bold
      hi Error          cterm=bold
      hi Identifier     cterm=bold
      hi SpecialKey     cterm=bold
      hi NonText        cterm=bold
      hi MoreMsg        cterm=bold
      hi Title          cterm=bold
      hi WarningMsg     cterm=bold
      hi FoldColumn     cterm=bold
      hi SignColumn     cterm=bold
      hi Directory      cterm=bold
      hi DiffDelete     cterm=bold
    else
      " Background > 7 is only available with 16 or more colors

      hi WarningMsg     cterm=NONE
      hi Search         cterm=NONE
      hi Visual         cterm=NONE
      hi Cursor         cterm=NONE
      hi Special        cterm=NONE
      hi Comment        cterm=NONE
      hi Constant       cterm=NONE
      hi Number         cterm=NONE
      hi LineNr         cterm=NONE
      hi PreProc        cterm=NONE
      hi Todo           cterm=NONE
      hi Error          cterm=NONE
      hi Identifier     cterm=NONE
      hi Folded         cterm=NONE
      hi SpecialKey     cterm=NONE
      hi Directory      cterm=NONE
      hi ErrorMsg       cterm=NONE
      hi Normal         cterm=NONE
      hi PmenuThumb     cterm=NONE
      hi WildMenu       cterm=NONE
      hi FoldColumn     cterm=NONE
      hi SignColumn     cterm=NONE
      hi DiffAdd        cterm=NONE
      hi DiffChange     cterm=NONE
      hi Question       cterm=NONE
      hi StatusLine     cterm=NONE
      hi DiffText       cterm=NONE
      hi IncSearch      cterm=reverse
      hi StatusLineNC   cterm=reverse
      hi VertSplit      cterm=reverse

      " Well, well, bold font with color 0-7 is not possible.
      " So, the Question, StatusLine, DiffText cannot act as expected.

      hi Statement      cterm=NONE
      hi Type           cterm=NONE
      hi MoreMsg        cterm=NONE
      hi ModeMsg        cterm=NONE
      hi NonText        cterm=NONE
      hi Title          cterm=NONE
      hi VisualNOS      cterm=NONE
      hi DiffDelete     cterm=NONE
      hi TabLineSel     cterm=NONE

    endif
  elseif &t_Co==256
    " 256color dark terminal support here
    hi Normal           ctermfg=252     ctermbg=234     cterm=NONE
    " Comment/Uncomment the following line to disable/enable transparency
    hi Normal           ctermfg=252     ctermbg=NONE    cterm=NONE
    hi Comment          ctermfg=186     ctermbg=NONE    cterm=NONE
    hi Constant         ctermfg=74      ctermbg=NONE    cterm=NONE
    hi Number           ctermfg=179     ctermbg=NONE    cterm=NONE
    hi Identifier       ctermfg=225     ctermbg=NONE    cterm=NONE
    hi Statement        ctermfg=153     ctermbg=NONE    cterm=NONE
    hi PreProc          ctermfg=84      ctermbg=NONE    cterm=NONE
    hi Type             ctermfg=153     ctermbg=NONE    cterm=NONE
    hi Special          ctermfg=179     ctermbg=NONE    cterm=NONE
    hi Error            ctermfg=209     ctermbg=NONE    cterm=NONE
    hi Todo             ctermfg=88      ctermbg=186     cterm=NONE
    hi Search           ctermfg=NONE    ctermbg=88      cterm=NONE
    hi Visual           ctermfg=16      ctermbg=153     cterm=NONE
    hi Cursor           ctermfg=16      ctermbg=46      cterm=NONE
    " Note: THIS IS IN THE COOL SECTION
    hi CursorIM         ctermfg=16      ctermbg=225     cterm=NONE
    hi StatusLine       ctermfg=16      ctermbg=153     cterm=NONE
    hi LineNr           ctermfg=145     ctermbg=NONE    cterm=NONE
    hi Question         ctermfg=16      ctermbg=186     cterm=NONE
    hi ModeMsg          ctermfg=fg      ctermbg=18      cterm=NONE
    hi VisualNOS        ctermfg=fg      ctermbg=18      cterm=NONE
    hi SpecialKey       ctermfg=153     ctermbg=NONE    cterm=NONE
    hi NonText          ctermfg=69      ctermbg=233     cterm=NONE
    " Comment/Uncomment the following line to disable/enable transparency
    hi NonText          ctermfg=69      ctermbg=NONE    cterm=NONE
    hi Directory        ctermfg=74      ctermbg=NONE    cterm=NONE
    hi ErrorMsg         ctermfg=186     ctermbg=88      cterm=NONE
    hi MoreMsg          ctermfg=150     ctermbg=NONE    cterm=NONE
    hi Title            ctermfg=225     ctermbg=NONE    cterm=NONE
    hi WarningMsg       ctermfg=209     ctermbg=NONE    cterm=NONE
    hi WildMenu         ctermfg=16      ctermbg=186     cterm=NONE
    hi Folded           ctermfg=NONE    ctermbg=22      cterm=NONE
    hi FoldColumn       ctermfg=254     ctermbg=28      cterm=NONE
    hi DiffAdd          ctermfg=NONE    ctermbg=18      cterm=NONE
    hi DiffChange       ctermfg=NONE    ctermbg=90      cterm=NONE
    hi DiffDelete       ctermfg=69      ctermbg=234     cterm=NONE
    hi DiffText         ctermfg=16      ctermbg=150     cterm=NONE
    hi SignColumn       ctermfg=254     ctermbg=28      cterm=NONE
    hi IncSearch        ctermfg=16      ctermbg=252     cterm=NONE
    hi StatusLineNC     ctermfg=16      ctermbg=250     cterm=NONE
    hi VertSplit        ctermfg=16      ctermbg=250     cterm=NONE
    hi Underlined       ctermfg=111     ctermbg=NONE    cterm=underline
    hi Ignore           ctermfg=16      ctermbg=NONE
    " Note: THIS IS IN THE COOL SECTION
    if v:version >= 700
      if has('spell')
        " the ctermsp= is not supported in Vim 7 we simply ignored
        if 0
          hi SpellBad   cterm=undercurl ctermbg=NONE    ctermfg=209
          hi SpellCap   cterm=undercurl ctermbg=NONE    ctermfg=69
          hi SpellRare  cterm=undercurl ctermbg=NONE    ctermfg=225
          hi SpellLocal cterm=undercurl ctermbg=NONE    ctermfg=153
        else
          hi SpellBad   cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellCap   cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellRare  cterm=undercurl ctermbg=NONE    ctermfg=NONE
          hi SpellLocal cterm=undercurl ctermbg=NONE    ctermfg=NONE
        endif
      endif
      hi Pmenu          ctermfg=fg      ctermbg=90
      hi PmenuSel       ctermfg=16      ctermbg=252     cterm=NONE
      hi PmenuSbar      ctermfg=fg      ctermbg=18      cterm=NONE
      hi PmenuThumb     ctermfg=fg      ctermbg=28      cterm=NONE
      hi TabLine        ctermfg=fg      ctermbg=28      cterm=NONE
      hi TabLineFill    ctermfg=fg      ctermbg=28      cterm=NONE
      hi TabLineSel     ctermfg=fg      ctermbg=NONE    cterm=NONE
      hi CursorColumn   ctermfg=NONE    ctermbg=88      cterm=NONE
      hi CursorLine     ctermfg=NONE    ctermbg=NONE    cterm=underline
      hi MatchParen     ctermfg=NONE    ctermbg=90
      hi TabLine        cterm=underline
      hi TabLineFill    cterm=underline
      hi Underlined     cterm=underline
      hi CursorLine     cterm=underline
    endif
    if v:version >= 800
      hi CursorLine     ctermfg=145     cterm=underline
    endif

  endif " t_Co

  " }}}2
endif

" Links:
"
" COLOR LINKS DEFINE START

hi link        String       Constant
" Character must be different from strings because in many languages
" (especially C, C++) a 'char' variable is scalar while 'string' is pointer,
" mistaken a 'char' for a 'string' will cause disaster!
hi link        Character    Number
hi link        SpecialChar  LineNr
hi link        Tag          Identifier
hi link        cCppOut      LineNr
" The following are not standard hi links,
" these are used by DrChip
hi link        Warning      MoreMsg
hi link        Notice       Constant
" these are used by Calendar
hi link        CalToday     PreProc
" these are used by TagList
hi link        MyTagListTagName     IncSearch
hi link        MyTagListTagScope    Constant

" COLOR LINKS DEFINE END

" vim: et:nosta:sw=2:ts=4:sts=4:fenc=utf-8
" vim600: fdm=marker:fdl=1:
