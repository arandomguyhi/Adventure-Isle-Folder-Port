local imgPath = 'stages/duck/'

luaDebugMode = true
function onCreate()
    setProperty('isCameraOnForcedPos', true)
    setVar('camZoom', -.5)

    makeLuaSprite('sky', imgPath..'sky', 0, 0)
    addLuaSprite('sky')

    makeLuaSprite('clouds', imgPath..'clouds', 0, 0)
    addLuaSprite('clouds')

    makeAnimatedLuaSprite('lake', imgPath..'lake', 350, 0)
    addAnimationByPrefix('lake', 'idle', 'lake', 24, true)
    scaleObject('lake', 2, 2)
    addLuaSprite('lake')

    makeLuaSprite('ground', imgPath..'ground', 0, 0)
    addLuaSprite('ground')

    makeLuaSprite('bush', imgPath..'bush', 490, 1080)
    addLuaSprite('bush')
end

function onCreatePost()
    dadCamX = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')
    dadCamY = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')

    setProperty('camFollow.x', dadCamX)
    setProperty('camFollow.y', dadCamY)
end