local messengerShare = require "plugin.messengerShare"
local widget = require("widget")
-- for android file system
local function doesFileExist( fname, path )

    local results = false

    -- Path for the file
    local filePath = system.pathForFile( fname, path )

    if ( filePath ) then
        local file, errorString = io.open( filePath, "r" )

        if not file then
            -- Error occurred; output the cause
            print( "File error: " .. errorString )
        else
            -- File exists!
            print( "File found: " .. fname )
            results = true
            -- Close the file handle
            file:close()
        end
    end

    return results
end

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
local messangerIcon = display.newImage("messanger.png")
messangerIcon:scale( .5, .5 )
messangerIcon.x, messangerIcon.y = display.contentCenterX, 60
print( messengerShare.canShow() )
local shareButton1
shareButton1 = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY+50,
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
        y = display.contentCenterY-50,
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
