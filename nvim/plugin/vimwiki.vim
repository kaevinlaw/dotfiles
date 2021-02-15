" vimwiki
let g:vimwiki_list = [ { 'path': '~/vimviki/', 'syntax' : 'markdown' , 'ext' : '.md' } ]
let g:vimwiki_global_ext = 0
let g:vimwiki_url_maxsave=0
au FileType vimwiki setlocal shiftwidth=4 tabstop=4 expandtab
