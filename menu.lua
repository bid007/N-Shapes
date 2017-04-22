local composer = require( "composer") 
local scene = composer.newScene()
local widget = require("widget")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local menu_scope = {}
-- -----------------------------------------------------------------------------------
-- Scene event functions
function play_event(event)
    print("Okay lets play");
end

function sound_on_event(event)
    -- body
    sound_on = not sound_on

    if(sound_on) then
        menu_scope.sound_on.isVisible = true
        menu_scope.sound_on.isEnabled = true
        menu_scope.sound_off.isVisible = false
        menu_scope.sound_off.isEnabled = false
    else
        menu_scope.sound_on.isVisible = false
        menu_scope.sound_on.isEnabled = false
        menu_scope.sound_off.isVisible = true
        menu_scope.sound_off.isEnabled = true
    end
end
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --set background color
    display.setDefault("background", 242/255, 109/255, 33/255)
    --N Shapes text
    local nshapes_text = display.newText( sceneGroup, "N-Shapes", swidth/2, sheight/9, native.systemFontBold, 30)
    nshapes_text:setFillColor( 0.1, 0.1, 0.1)
    menu_scope.nshapes_text = nshapes_text
    --Play/pause button 
    local play = widget.newButton( 
        {
            left = swidth/2.6,
            top = sheight/2.5, 
            defaultFile = "play.png",
            width = 80,
            height = 80,
        }
    )     
    play:addEventListener( "tap", play_event )
    sceneGroup:insert(play)
    menu_scope.play_button = play
    --Sound on/off button 
    local sound_on = widget.newButton( 
        {
            left = swidth/2.2,
            top = sheight/1.03, 
            defaultFile = "volume.png",
            width = 32,
            height = 32,
        }
    )     
    menu_scope.sound_on = sound_on
    sound_on:addEventListener( "tap", sound_on_event )
    sceneGroup:insert(sound_on)

    local sound_off = widget.newButton(
         {
            left = swidth/2.2,
            top = sheight/1.03, 
            defaultFile = "volumeoff.png",
            width = 32,
            height = 32,
        }
    )
    menu_scope.sound_off = sound_off
    sound_off.isVisible = false
    sound_off.isEnabled = false
    sound_off:addEventListener( "tap", sound_on_event )
    sceneGroup:insert(sound_off)

    --- remove this. Just for check ---
    local test_img = display.newImage(game_sprites, math.random(1,24))
    sceneGroup:insert(test_img)
    test_img:scale(0.4,0.4)
    test_img.anchorX = 0; test_img.anchorY = 0;
    test_img.x = math.random(20, 200);test_img.y = math.random(20, 200)
    --- remove this ---
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