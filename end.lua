local composer = require( "composer") 
local scene = composer.newScene()
local widget = require("widget")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local end_scope = {}
-- -----------------------------------------------------------------------------------
-- Scene event functions
function replay_event(event)
    local options = {effect = "fade", time = 200}
    composer.gotoScene("gamelogic", options)
end

function sound_on_event(event)
    -- body
    sound_on = not sound_on

    if(sound_on) then
        end_scope.sound_on.isVisible = true
        end_scope.sound_on.isEnabled = true
        end_scope.sound_off.isVisible = false
        end_scope.sound_off.isEnabled = false
    else
        end_scope.sound_on.isVisible = false
        end_scope.sound_on.isEnabled = false
        end_scope.sound_off.isVisible = true
        end_scope.sound_off.isEnabled = true
    end
end
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --N Shapes text
    local nshapes_text = display.newText( sceneGroup, "Game Over", swidth/2, sheight/9, native.systemFontBold, 35)
    nshapes_text:setFillColor( 0.9, 0.9, 0.9)
    end_scope.nshapes_text = nshapes_text
    --Play/pause button 
    local replay = widget.newButton( 
        {
            left = swidth/2.6,
            top = sheight/2.5, 
            defaultFile = "replay.png",
            width = 64,
            height = 64,
        }
    )     
    replay:addEventListener( "tap", replay_event )
    sceneGroup:insert(replay)
    end_scope.replay_button = replay
    --Sound on/off button 
    local sound_on = widget.newButton( 
        {
            left = swidth/2.2,
            top = sheight/1.1, 
            defaultFile = "volume.png",
            width = 32,
            height = 32,
        }
    )     
    end_scope.sound_on = sound_on
    sound_on:addEventListener( "tap", sound_on_event )
    sceneGroup:insert(sound_on)

    local sound_off = widget.newButton(
         {
            left = swidth/2.2,
            top = sheight/1.1, 
            defaultFile = "volumeoff.png",
            width = 32,
            height = 32,
        }
    )
    end_scope.sound_off = sound_off
    sound_off.isVisible = false
    sound_off.isEnabled = false
    sound_off:addEventListener( "tap", sound_on_event )
    sceneGroup:insert(sound_off)

    local final_score_text = display.newText( sceneGroup, "", swidth/2, sheight/4, native.systemFontBold,20)
    final_score_text:setFillColor( 0.9, 0.9, 0.9 )
    end_scope.final_score_text = final_score_text

end
 
 
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    if(event.params ~= nil and event.params.score ~= nil) then
        end_scope.final_score_text.text = "Score: "..event.params.score
    end
    --set background color
    display.setDefault("background",  0.1, 0.2, 0.5)

    if(sound_on) then
        end_scope.sound_on.isVisible = true
        end_scope.sound_on.isEnabled = true
        end_scope.sound_off.isVisible = false
        end_scope.sound_off.isEnabled = false
    else
        end_scope.sound_on.isVisible = false
        end_scope.sound_on.isEnabled = false
        end_scope.sound_off.isVisible = true
        end_scope.sound_off.isEnabled = true
    end

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