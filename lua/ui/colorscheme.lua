local function chooseRandomColor()
	local myColorTable = {
		"zephyr",
		"ui.gruvbox",
		"ui.ayu",
	}
	local rand = math.random(#myColorTable)
	return myColorTable[rand]
end

local randColor = chooseRandomColor()
require("ui.ayu")
