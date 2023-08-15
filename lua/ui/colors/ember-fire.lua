local colors = {
	"#cc241d",
	"#d0321c",
	"#d53e1a",
	"#d94819",
	"#dc5217",
	"#e05c16",
	"#e36515",
	"#e66f15",
	"#e97815",
	"#ec8115",
	"#ef8917",
	"#f19219",
	"#f39b1c",
	"#f5a320",
	"#f7ac24",
	"#f9b429",
	"#fabd2f",
}
for i, color in ipairs(colors) do
	vim.cmd("hi StartLogo" .. i .. " guifg=" .. color .. " ctermfg=18   gui=NONE cterm=NONE")
end
