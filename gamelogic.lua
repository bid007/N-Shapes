local composer = require( "composer") 
local scene = composer.newScene()
local widget = require("widget")
local car = require("car")
local physics = require("physics")
local shapes = require("shapes")
physics.start()
physics.setGravity( 0, 9.8 )
-- physics.setDrawMode( "debug" )
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local game_scope = {}
 local road_h = 630
 local road_w = 160
 --Left car positions
 local left_car_pos = {
    [0] = {
        xPos = swidth/8,
        yPos = sheight/1.1
    },
    [1] = {
        xPos = swidth/2.65,
        yPos = sheight/1.1
    }
 }
 --Right car positions
 local right_car_pos = {
    [0] = {
        xPos = swidth/1.6,
        yPos = sheight/1.1
    },
    [1] = {
        xPos = swidth/1.13,
        yPos = sheight/1.1
    }
 }
 --Left and right car initial postions
 local left_pos_index = false
 local right_pos_index = true

--Time Counter
local time_counter = 0 
local generate_time = 2
-- -----------------------------------------------------------------------------------
-- Scene event functions
function pause_event(event)
    -- body
    print("pause tapped")
    return true
end

function right_road_event(event)
    right_pos_index = not right_pos_index
    if(right_pos_index) then
        --Position 1
        local event_dict = {
            name = "right_car_tap",
            xPos = right_car_pos[1].xPos,
            yPos = right_car_pos[1].yPos,
        }
        Runtime:dispatchEvent( event_dict)

    else
        --Position 0
        local event_dict = {
            name = "right_car_tap",
            xPos = right_car_pos[0].xPos,
            yPos = right_car_pos[0].yPos,
        }
        Runtime:dispatchEvent( event_dict)
    end
end

function left_road_event(event)
    left_pos_index = not left_pos_index
    if(left_pos_index) then
        --Position 1
        local event_dict = {
            name = "left_car_tap",
            xPos = left_car_pos[1].xPos,
            yPos = left_car_pos[1].yPos,
        }
        -- game_scope.left_road:dispatchEvent( event )
        Runtime:dispatchEvent( event_dict)
    else
        --Position 0
        local event_dict = {
            name = "left_car_tap",
            xPos = left_car_pos[0].xPos,
            yPos = left_car_pos[0].yPos
        }
        -- game_scope.left_road:dispatchEvent( event )
        Runtime:dispatchEvent(event_dict)
    end
end
--------------------------------------------------------------------------------------
--Car inheritence methods 
local left_car = car:new(left_car_pos[0])

function left_car:spawn()
    self.shape = display.newImage(self.imgFile, self.xPos, self.yPos)
    self.shape.tag = self.tag
    self.shape.pp = self
    physics.addBody( self.shape, "kinematic")

    local function event_listener(event)
        transition.to( self.shape, {time=200, x = event.xPos, y = event.yPos})
    end
    Runtime:addEventListener( "left_car_tap", event_listener)
end

local right_car = car:new(right_car_pos[1])

function right_car:spawn()
    self.shape = display.newImage(self.imgFile, self.xPos, self.yPos)
    self.shape.tag = self.tag
    self.shape.pp = self
    physics.addBody( self.shape, "kinematic")

    local function event_listener(event)
        transition.to( self.shape, {time=200, x = event.xPos, y = event.yPos})
    end
    Runtime:addEventListener( "right_car_tap", event_listener)
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
    -- --Right road image
    local right_road = display.newImageRect( sceneGroup, "right.png", road_w, road_h)
    right_road.anchorX = 0
    right_road.anchorY = 0
    right_road.y = -60
    right_road.x = road_w
    game_scope.right_road = right_road
    right_road:toBack()
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
    -- --score value
    local score = display.newText( sceneGroup, 0, 10, -45, native.systemFontBold, 28)
    score.anchorY = 0
    score.anchorX = 0
    game_scope.score = score
    --Player cars

    -- Left car
    local left_car_object = left_car:new()
    game_scope.left_car_object = left_car_object
    left_car_object:spawn()
    sceneGroup:insert(left_car_object.shape)

    --Right car
    local right_car_object = right_car:new()
    game_scope.right_car_object = right_car_object
    right_car_object:spawn()
    sceneGroup:insert(right_car_object.shape)
end
 
 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
         
        local game_loop_timer = timer.performWithDelay( 1000,  
            function()
                time_counter = time_counter + 1
                if(time_counter % generate_time == 0) then
                    print("Okay generated")
                    local shape = shapes:new({xPos =swidth/2, yPos=-50, type="circle"})
                    shape:spawn();
                    sceneGroup:insert(shape.shape)
                end
                -- if(time_counter == 5) then
                --         time_counter = 0
                --         generate_time = 1
                -- end 
            end
        ,-1)
        game_scope.game_loop_timer = game_loop_timer
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