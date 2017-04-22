local composer = require( "composer") 
local scene = composer.newScene()
local widget = require("widget")
local car = require("car")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local game_scope = {}
 local road_h = 630
 local road_w = 160
-- -----------------------------------------------------------------------------------
-- Scene event functions
function pause_event(event)
    -- body
    print("pause tapped")
    return true
end

function right_road_event(event)
    print("Right road tapped")
end

function left_road_event(event)
    print("left road tapped")
end

-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    display.setDefault( "background", 37/255, 51/255, 122/255)
    --Left road image
    local left_road = display.newImageRect( sceneGroup, "left.png", road_w, road_h)
    left_road.anchorX = 0
    left_road.anchorY = 0
    left_road.y = -60
    game_scope.left_road = left_road
    left_road:addEventListener( "tap", left_road_event)
    --Right road image
    local right_road = display.newImageRect( sceneGroup, "right.png", road_w, road_h)
    right_road.anchorX = 0
    right_road.anchorY = 0
    right_road.y = -60
    right_road.x = road_w
    game_scope.right_road = right_road
    right_road:addEventListener( "tap", right_road_event)
    --Pause button
    local pause = widget.newButton(
         {
            left = swidth/1.15,
            top = -40, 
            defaultFile = "pause.png",
            width = 24,
            height = 24,
        }
    )
    game_scope.pause = pause
    pause:addEventListener( "tap", pause_event)
    sceneGroup:insert(pause)
    --score value
    local score = display.newText( sceneGroup, 0, 10, -45, native.systemFontBold, 28)
    score.anchorY = 0
    score.anchorX = 0
    game_scope.score = score
    --Player cars
    local left_car = car:new({xPos=swidth/2, yPos=sheight/1.12})
    game_scope.left_car = left_car
    left_car:spawn()
    sceneGroup:insert(left_car.shape)
end
 
 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene