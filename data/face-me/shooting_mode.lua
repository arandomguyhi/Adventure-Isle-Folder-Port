addHaxeLibrary('FlxColor', 'flixel.util')

local dogPath = 'characters/duck_season/'

luaDebugMode = true
function onCreate()
    for i = 1,2 do -- testing with 2 sprites for now
        makeAnimatedLuaSprite('dogFront'..i, dogPath..'Dog_Shadow_Laugh', 1150, 1350)
        addAnimationByPrefix('dogFront'..i, 'idle', 'Dog Shadow Laugh instance 1', 24, true)
        addAnimationByPrefix('dogFront'..i, 'throw', 'Dog Laugh Shadow Throw instance 1', 24, false)
	playAnim('dogFront'..i, 'idle')
        scaleObject('dogFront'..i, 6, 5)
        setProperty('dogFront'..i..'.antialiasing', false) -- to optimize a bit
        addLuaSprite('dogFront'..i, true)

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
	playAnim('dogRight'..i, 'idle')
        scaleObject('dogRight'..i, 2, 2)
	setObjectOrder('dogRight'..i, getObjectOrder('bush'))
        setProperty('dogRight'..i..'.antialiasing', false)
        addLuaSprite('dogRight'..i)

	setProperty('dogFront'..i..'.visible', false)
	setProperty('dogLeft'..i..'.visible', false)
	setProperty('dogRight'..i..'.visible', false)
    end
    runHaxeCode("FlxG.mouse.load(Paths.image('stages/duck/crosshair').bitmap, 0.5, -73, -50);")
end

local dogSprGroup = {'dogFront1', 'dogFront2', 'dogLeft1', 'dogLeft2', 'dogRight1', 'dogRight2'}
function onEvent(name, value1, value2)
    if name == 'DogSpawn' then
	for d = 1,2 do
	    local randomIndex = getRandomInt(1,#dogSprGroup)
	    doguin = dogSprGroup[randomIndex]

	    if not getProperty(doguin..'.visible') then
		-- THIS IS SO BAD HELÇP :SOB:
		if doguin == 'dogLeft1' then
	    	    setProperty('dogLeft1.x', (getProperty('dogLeft2.visible') and getX('dogLeft2')-getWidth('dogLeft2') or getRandomInt(900,1300)))
	    	    setProperty('dogLeft1.y', getRandomInt(1270,1310))
		elseif doguin == 'dogLeft2' then
		    setProperty('dogLeft2.x', (getProperty('dogLeft1.visible') and getX('dogLeft1')+getWidth('dogLeft1') or getRandomInt(900,1300)))
	    	    setProperty('dogLeft2.y', getRandomInt(1270,1310))
		end
		if doguin == 'dogFront1' then
		    setProperty('dogFront1.x', (getProperty('dogFront2.visible') and getX('dogFront2')-getWidth('dogFront2') or getRandomInt(1150, 2150)))
		elseif doguin == 'dogFront2' then
		    setProperty('dogFront2.x', (getProperty('dogFront1.visible') and getX('dogFront1')+getWidth('dogFront1') or getRandomInt(1150, 2150)))
		end
		if doguin == 'dogRight1' then
		    setProperty('dogRight1.x', (getProperty('dogRight2.visible') and getX('dogRight2')+getWidth('dogRight2')-5 or 2500))
	    	    setProperty('dogRight1.y', getRandomInt(1200, 1250))
		elseif doguin == 'dogRight2' then
		    setProperty('dogRight2.x', (getProperty('dogRight1.visible') and getX('dogRight1')+getWidth('dogRight1')-10 or 2500))
	    	    setProperty('dogRight2.y', getRandomInt(1200, 1250))
	    	end

		setProperty(doguin..'.visible', true)
	    end

	    debugPrint(doguin)
	end
    end
end

function onUpdate(elapsed)
    if getVar('shooting_mode') then
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)

	if mouseReleased() then
	    playSound('duckseason/laser', 0.5)

	    runHaxeCode([[
		FlxG.mouse.load(Paths.image('stages/duck/crosshairTarget').bitmap, 0.5, -73, -50);
		new FlxTimer().start(0.1, function(tmr:FlxTimer) {
			FlxG.mouse.load(Paths.image('stages/duck/crosshair').bitmap, 0.5, -73, -50);
		});
	    ]])
	end

	for _,dogs in ipairs(dogSprGroup) do
	    runHaxeCode([[
		var dogSpr = game.getLuaObject(']]..dogs..[[');
		if (FlxG.mouse.overlaps(dogSpr)) {
		    if (FlxG.mouse.justPressed && dogSpr.visible) {
			FlxTween.tween(dogSpr.colorTransform, {redOffset: 255, greenOffset: 255, blueOffset: 255}, 0.1, {
			    onComplete: function(twn) {
				dogSpr.visible = false;

				dogSpr.colorTransform.redOffset = 0;
				dogSpr.colorTransform.greenOffset = 0;
				dogSpr.colorTransform.blueOffset = 0;
			    }
			});
		    }
		}
	    ]])
	end
    else
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
    end
end

function getWidth(obj)
    return getProperty(obj..'.width')
end

function getX(obj)
    return getProperty(obj..'.x')
end