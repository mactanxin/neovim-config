local colors = 
{'#58b674', '#3cb67d', '#00b688', '#00b594', '#00b4a0', '#00b3ac', '#00b1b9', '#00afc6', '#00add2', '#00aadd', '#00a7e7', '#00a3f0', '#009ef6', '#0099fb', '#0093fd', '#008dfd', '#3385fa'}
for i, color in ipairs(colors) do
	vim.cmd("hi StartLogo" .. i .. " guifg=" .. color .. " ctermfg=18   gui=NONE cterm=NONE")
end
