local messengerShare = require "plugin.messengerShare"
local widget = require("widget")

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
local messangerIcon = display.newImage("messanger.png")
messangerIcon:scale( .5, .5 )
messangerIcon.x, messangerIcon.y = display.contentCenterX, 60
print( messengerShare.canShow() )
local shareButton1
shareButton1 = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY+70,
        labelColor = { default={ 0, 0, 1 }, over={ 0, 0, 0, 0.5 } },
        id = "shareUrl",
        label = "Share Url",
        onEvent = function ( e )
                if (e.phase == "ended") then
                       messengerShare.show({url="https://scotth.tech", quote = "insert cool quote here"}) 
                end
        end
} )
local shareButton2
shareButton2 = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY,
        labelColor = { default={ 0, 0, 1 }, over={ 0, 0, 0, 0.5 } },
        id = "shareImage",
        label = "Share Image",
        onEvent = function ( e )
                if (e.phase == "ended") then
                       local coronaImagePath = system.pathForFile( "coronaImage.png" )
						messengerShare.show({photos={coronaImagePath}, hashtag = "#CoronaSdk"})
                end
        end
} )
if (system.getInfo("platform")~= "ios") then
	local shareButton3
	shareButton3 = widget.newButton( {
	        x = display.contentCenterX,
	        y = display.contentCenterY-70,
	        labelColor = { default={ 0, 0, 1 }, over={ 0, 0, 0, 0.5 } },
	        id = "shareVideo",
	        label = "Share Video",
	        onEvent = function ( e )
	                if (e.phase == "ended") then
	                       local coronaVideo = system.pathForFile( "rickRoll.mp4" )
							messengerShare.show({video=coronaVideo})
	                end
	        end
	} )
end