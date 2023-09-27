syntax match pythonEquals "[=+\-*/|&]"
hi pythonEquals ctermfg=Magenta guifg=#AA23FF

syntax match pythonMethodCall "\.\zs\w\+\ze("
hi pythonMethodCall ctermfg=Blue guifg=#0055AA

syntax match pythonFString "f\zs'.*'"
syntax match pythonFString 'f\zs".*"'
hi pythonFString ctermfg=Red guifg=#BA2220


