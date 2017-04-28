-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar )

local options = {
	frames = {
		{ x = 96, y = 67, width = 105, height = 94}, --purple circle 1
		{ x = 226, y = 67, width = 109, height = 94}, --red circle 2
		{ x = 361, y = 67, width = 109, height = 94}, --blue circle 2
		{ x = 498, y = 67, width = 104, height = 94}, --green circle 2

		{ x = 90, y = 224, width = 120, height = 86}, --purple rounded rect 1
		{ x = 228, y = 224, width = 120, height = 86}, --red rounded rect 2
		{ x = 360, y = 224, width = 120, height = 86}, --blue rounded rect 3
		{ x = 497, y = 224, width = 120, height = 86}, --green rounded rect 4

		{ x = 95, y = 352, width = 115, height = 81}, -- purple rect 1
		{ x = 230, y = 352, width = 115, height = 81}, -- red rect 2
		{ x = 364, y = 352, width = 115, height = 81}, -- blue rect 3
		{ x = 500, y = 352, width = 115, height = 81}, -- green rect 4

		{ x = 76, y = 500, width = 109, height = 105}, -- pruple pentagon 1
		{ x = 226, y = 500, width = 109, height = 105}, -- red pentagon 2
		{ x = 369, y = 500, width = 109, height = 105}, -- blue pentagon 3
		{ x = 500, y = 500, width = 109, height = 105}, -- green pentagon 4

		{ x = 62, y = 674, width = 121, height = 109}, -- purple hexagon 1
		{ x = 211, y = 674, width = 121, height = 109}, -- red hexagon 2
		{ x = 358, y = 674, width = 121, height = 109}, -- blue hexagon 3
		{ x = 507, y = 674, width = 121, height = 109}, -- green hexagon 4

		{ x = 55, y = 834, width = 102, height = 98}, -- purple triangle 1
		{ x = 213, y = 834, width = 102, height = 98}, -- red triangle 2
		{ x = 368, y = 834, width = 102, height = 98}, -- blue triangle 3
		{ x = 521, y = 834, width = 102, height = 98}, -- green triangle 4

	}
}

--Global variables for display height and width
sheight = display.contentHeight
swidth = display.contentWidth
sound_on = true
game_sprites = graphics.newImageSheet( "sprites_new.png", options );
--Shape types index map
shape_array = {"Circle", "Rectangle", "Pentagon", "Hexagon", "Triangle"}
to_avoid_shape = shape_array[math.random(1,5)]
-- Go to menu scene
composer.gotoScene("gamecredit", {effect="fade", time=1000})