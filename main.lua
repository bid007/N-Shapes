-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar )

--Global variables for display height and width
sheight = display.contentHeight
swidth = display.contentWidth

--Go to menu scene
composer.gotoScene("gamecredit")