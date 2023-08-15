local colors = {
	"#14067E",
	"#15127B",
	"#161870",
	"#172466",
	"#182E5B",
	"#193A50",
	"#1A4647",
	"#1B5243",
	"#1C5F3F",
	"#1D6C3C",
	"#1E7939",
	"#1F8636",
	"#209330",
	"#21A02D",
	"#22AD2A",
	"#23B928",
	"#28CC4C",
}
for i, color in ipairs(colors) do
	vim.cmd("hi StartLogo" .. i .. " guifg=" .. color .. " ctermfg=18   gui=NONE cterm=NONE")
end
