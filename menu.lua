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
    return true
end

function sound_on_event(event)
    -- body
    sound_on = not sound_on
    
end
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --set background color
    display.setDefault("background", 247/255, 220/255, 111/255 )
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
    --Sound on/off button x = w/2.2, y = h/1.03
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