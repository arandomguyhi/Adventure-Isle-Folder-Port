local imgPath = 'stages/duck/'

addCharacterToList('duckSeason-DogLeft', 'dad')
addCharacterToList('duckSeason-DogRight', 'dad')

setVar('shooting_mode', false)

luaDebugMode = true
function onCreate()
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
    setProperty('dad.alpha', 0.001)
end

function onUpdate()
end

function onEvent(name, value1, value2)
    if name == 'Teleport Dog' then
        if value1 == 'left' then
            triggerEvent('Change Character', 'dad', 'duckSeason-DogLeft')

	    setCharacterX('dad', -200)
	    setCharacterY('dad', 1270)

	    setProperty('defaultCamZoom', 0.6)
        elseif value1 == 'middle' then
            triggerEvent('Change Character', 'dad', 'duckSeason-DogMiddle')

	    setCharacterX('dad', 1000)
	    setCharacterY('dad', 1000)

	    setProperty('defaultCamZoom', 0.55)
        else
            triggerEvent('Change Character', 'dad', 'duckSeason-DogRight')
	    setProperty('defaultCamZoom', 0.55)
        end
    end
end

function onStepHit()
    if curStep == 128 then
        setVar('camZoom', -.45)
    elseif curStep == 1408 then
	doTweenAlpha('dadTween', 'dad', 0.001, 0.5, 'sineInOut')
    end
end