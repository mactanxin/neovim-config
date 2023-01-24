local function chooseRandomColor()
  local myColorTable = {
    "zephyr",
    "ui.gruvbox",
    "ui.ayu"
  }
	local rand = math.random(#myColorTable)
	return myColorTable[rand]
end

local randColor = chooseRandomColor()
--[[ require('zephyr') ]]
--[[ require('ui.gruvbox') ]]
require('ui.ayu')
require('lualine').setup()
