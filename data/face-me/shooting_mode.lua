local dogPath = 'characters/duck_season/'

luaDebugMode = true
function onCreate()
    for i = 1,2 do -- testing with 2 sprites for now
        makeAnimatedLuaSprite('dogFront'..i, dogPath..'Dog_Shadow_Laugh')
        addAnimationByPrefix('dogFront'..i, 'idle', 'Dog Shadow Laugh instance 1', 24, true)
        addAnimationByPrefix('dogFront'..i, 'throw', 'Dog Laugh Shadow Throw instance 1', 24, false)
        scaleObject('dogFront'..i, 2, 2)
	setObjectOrder('dogFront'..i, getObjectOrder('bush'))
        setProperty('dogFront'..i..'.antialiasing', false) -- to optimize a bit
        addLuaSprite('dogFront'..i)

        makeAnimatedLuaSprite('dogLeft'..i, dogPath..'Dog_Shadow_Wave')
        addAnimationByPrefix('dogLeft'..i, 'idle', 'Dog shadow wave instance 1', 24, true)
        addAnimationByPrefix('dogLeft'..i, 'throw', 'Dog Shadow wave throw instance 1', 24, false)
	playAnim('dogLeft'..i, 'idle')
        scaleObject('dogLeft'..i, 1.8, 1.8)
	setObjectOrder('dogLeft'..i, getObjectOrder('bush'))
        setProperty('dogLeft'..i..'.antialiasing', false)
        addLuaSprite('dogLeft'..i)

        makeAnimatedLuaSprite('dogRight'..i, dogPath..'Dog_Shadow')
        addAnimationByPrefix('dogRight'..i, 'idle', 'Dog shadow Idle instance 1', 24, true)
        addAnimationByPrefix('dogRight'..i, 'throw', 'Dog Shadow Throw instance 1', 24, false)
        scaleObject('dogRight'..i, 1, 1)
	setObjectOrder('dogRight'..i, getObjectOrder('bush'))
        setProperty('dogRight'..i..'.antialiasing', false)
        addLuaSprite('dogRight'..i)

	setProperty('dogFront'..i..'.visible', false)
	setProperty('dogLeft'..i..'.visible', false)
	setProperty('dogRight'..i..'.visible', false)
    end
    runHaxeCode("FlxG.mouse.load(Paths.image('stages/duck/crosshairTarget').bitmap, 0.5, -72, -50);")
end

function onUpdate(elapsed)
    if getVar('shooting_mode') then
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
    else
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
    end
end

local dogCount = 1
function onEvent(name, value1, value2)
    if name == 'DogSpawn' then
	for d = 1,2 do
	    local dogSprGroup = {'dogFront1', 'dogFront2', 'dogLeft1', 'dogLeft2', 'dogRight1', 'dogRight2'}
	    local randomDog = getRandomInt(1, #dogSprGroup)
	    doguin = dogSprGroup[randomDog]

	    local dogVis = getProperty(doguin..'.visible')
	    setProperty(doguin..'.visible', (dogVis and true or true)) -- im so smart hahah

	    if doguin == 'dogLeft1' or doguin == 'dogLeft2' then
	    	setProperty('dogLeft'..d..'.x', getRandomInt(900,1400))
	    	setProperty('dogLeft'..d..'.y', getRandomInt(1270,1310))
	    end
	end

	dogCount = dogCount + 1
	runTimer('attack'..dogCount, 2)
    end
end

function onTimerCompleted(tag)
    for i = 1,dogCount do
   	if tag == 'attack'..i then
	    -- i'll make they attack later !!!!
	    debugPrint('attack '..i)
	end
    end
end