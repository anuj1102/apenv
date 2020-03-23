" bases
nn <silent> gb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> gB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> gs :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> gS :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> gl :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> gL :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nn <silent> gm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> gM :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> gN :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nn <silent> gv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> gV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>
