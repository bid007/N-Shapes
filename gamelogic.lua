local composer = require( "composer") 
local scene = composer.newScene()
local widget = require("widget")
local car = require("car")
local physics = require("physics")
local shapes = require("shapes")
local soundtable = require("soundTable")
physics.start()
physics.setGravity( 0, 0 )
-- physics.setDrawMode( "hybrid")
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
--Shape types index map
local shape_array = {"Circle", "Rectangle", "Pentagon", "Hexagon", "Triangle"}
local to_avoid_shape = shape_array[math.random(1,5)]
-- -----------------------------------------------------------------------------------
-- Scene event functions
function pause_event(event)
    -- body
    print("pause tapped")
    physics.pause()
    audio.pause(game_scope.car_sound)
    local options = {effect = "fade", time = 500}
    composer.gotoScene("menu", options)
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

function game_end(event)
    print("Okay lets finish the game Up")
    if(game_scope.game_loop_timer ~= nil) then
        timer.cancel(game_scope.game_loop_timer)
        if(sound_on) then
            audio.stop(game_scope.car_sound)
            audio.play(soundtable["gameoverSound"], {channel=4})
        end
    end
end
Runtime:addEventListener("end", game_end)

function update_score(event)
    if(game_scope.score ~= nil) then
        game_scope.score.text = game_scope.score.text + 1
    end
end
Runtime:addEventListener("update_score", update_score)
--------------------------------------------------------------------------------------
--Car inheritence methods 
local left_car = car:new(left_car_pos[0])

function left_car:spawn()
    self.shape = display.newImage(self.imgFile, self.xPos, self.yPos)
    self.shape.tag = self.tag
    self.shape.pp = self
    local image_outline = graphics.newOutline(2, self.imgFile, 1)
    physics.addBody( self.shape, "kinematic", {outline = image_outline})

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
    local image_outline = graphics.newOutline(2, self.imgFile, 1)
    physics.addBody( self.shape, "kinematic", {outline = image_outline})

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

    --Bottom rect 
    local bottom_rect = display.newRect( sceneGroup, 0, sheight-10, swidth, 50)
    bottom_rect.anchorX = 0
    bottom_rect.anchorY = 0
    bottom_rect.isVisible = false
    physics.addBody( bottom_rect)
    bottom_rect.isSensor = true
    bottom_rect.tag = "bottom_rect"
end
 
 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    display.setDefault( "background", 37/255, 51/255, 122/255)
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        physics.start()
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        local avoid_msg_txt = display.newText(sceneGroup, "Avoid "..to_avoid_shape, swidth/3, sheight/8, native.systemFontBold, 20)
        avoid_msg_txt.anchorY = 0
        avoid_msg_txt.anchorX = 0
        game_scope.avoid_msg_txt = avoid_msg_txt

        if(sound_on) then
            game_scope.car_sound = audio.play(soundtable["carSound"], {loops = -1, channel=1}) -- loop forever
        end

        local text_show_timer = timer.performWithDelay( 1000,
            function()
                if(game_scope.avoid_msg_txt ~= nil) then
                    avoid_msg_txt:removeSelf()
                end
            end
        ,1) 

        local game_loop_timer = timer.performWithDelay( 1000, 

            function()
                time_counter = time_counter + 1

                if(time_counter % generate_time == 0) then

                    local shape_type = shape_array[math.random(1,5)]
                    local shape_pos = math.random(0,1)
                    local x = right_car_pos[shape_pos].xPos
                    local shape = shapes:new({xPos = x-20, yPos=-50, type=shape_type})
                    shape:spawn();
                    shape:handle_collision_with_other(to_avoid_shape)
                    shape.shape:setLinearVelocity( 0, 150 )
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