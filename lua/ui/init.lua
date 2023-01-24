local function chooseRandomColor()
	local myThemeTable = {
		"ui.colors.gruvbox_colors",
		"ui.colors.purple-green",
		"ui.colors.emerald",
		"ui.colors.ember-fire",
	}
	local rand = math.random(#myThemeTable)
	return myThemeTable[rand]
end

--[[ require("ui.startup-screen") ]]
require("ui.dashboard")
require("ui.colorscheme")
--[[ require("ui.colors.ember-fire") ]]
require(chooseRandomColor())
