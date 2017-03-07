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
function copyFile( srcName, srcPath, dstName, dstPath, overwrite )

    local results = false

    local fileExists = doesFileExist( srcName, srcPath )
    if ( fileExists == false ) then
        return nil  -- nil = Source file not found
    end

    -- Check to see if destination file already exists
    if not ( overwrite ) then
        if ( fileLib.doesFileExist( dstName, dstPath ) ) then
            return 1  -- 1 = File already exists (don't overwrite)
        end
    end

    -- Copy the source file to the destination file
    local rFilePath = system.pathForFile( srcName, srcPath )
    local wFilePath = system.pathForFile( dstName, dstPath )

    local rfh = io.open( rFilePath, "rb" )
    local wfh, errorString = io.open( wFilePath, "wb" )

    if not ( wfh ) then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
        return false
    else
        -- Read the file and write to the destination directory
        local data = rfh:read( "*a" )
        if not ( data ) then
            print( "Read error!" )
            return false
        else
            if not ( wfh:write( data ) ) then
                print( "Write error!" )
                return false
            end
        end
    end

    results = 2  -- 2 = File copied successfully!

    -- Close file handles
    rfh:close()
    wfh:close()

    return results
end
copyFile( "rickRoll.mp4.txt", nil, "rickRoll.mp4", system.DocumentsDirectory, true )

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
	                       local coronaVideo = system.pathForFile( "rickRoll.mp4", system.DocumentsDirectory )
							           messengerShare.show({video=coronaVideo})
	                end
	        end
	} )
end
