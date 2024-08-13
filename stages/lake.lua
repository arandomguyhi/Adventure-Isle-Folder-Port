local imgPath = 'stages/duck/'

--addCharacterToList('duckSeason-DogLeft', 'dad')
--addCharacterToList('duckSeason-DogRight', 'dad')

setVar('shooting_mode', false)

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

    setProperty('dad.alpha', 0.001)
end

function onUpdate()
end

function onEvent(name, value1, value2)
    if name == 'Teleport Dog' then
        --[[if value1 == 'left' then
            triggerEvent('Change Character', 'dad', 'duckSeason-DogLeft')]]
        if value1 == 'middle' then
            triggerEvent('Change Character', 'dad', 'duckSeason-DogMiddle')
        --[[else
            triggerEvent('Change Character', 'dad', 'duckSeason-DogRight')]]
        end
    end
end

function onStepHit()
    if curStep == 128 then
        setVar('camZoom', -.45)
    end
end