syntax match pythonEquals "[=+\-*/|&]"
hi pythonEquals ctermfg=Magenta guifg=#AA23FF

syntax match pythonMethodCall "\.\zs\w\+\ze("
hi pythonMethodCall ctermfg=Blue guifg=#0055AA

" syntax match pythonFString "f\zs'.*'"
" syntax match pythonFString 'f\zs".*"'
" hi pythonFString ctermfg=Red guifg=#BA2220

syntax region pythonFString start=/f'/ end=/'/ contains=pythonFStringBraces
syntax region pythonFString start=/f"/ end=/"/ contains=pythonFStringBraces
syntax region pythonFStringBraces start=/{/ end=/}/ contained
hi pythonFString ctermfg=Blue guifg=#0055AA
hi pythonFStringBraces cterm=none ctermbg=none guifg=NONE guibg=NONE

