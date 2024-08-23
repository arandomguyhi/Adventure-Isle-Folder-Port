addHaxeLibrary('FlxRect', 'flixel.math')

setProperty('skipArrowStartTween', true)

function onCreate()
    removeHScript('scripts/VideoSpriteScript')

    makeLuaSprite('base', 'healthbars/duck/base', 0, 609.5)
    setObjectCamera('base', 'hud')
    scaleObject('base', 0.5, 0.5)
    screenCenter('base', 'X')
    addLuaSprite('base')
    setProperty('base.alpha', 0.001)

    makeLuaSprite('duckBarP2', 'healthbars/duck/duck-p2', 0, 630)
    setObjectCamera('duckBarP2', 'hud')
    scaleObject('duckBarP2', 0.51, 0.51)
    screenCenter('duckBarP2', 'X')
    addLuaSprite('duckBarP2')
    setProperty('duckBarP2.alpha', 0.001)

    makeLuaSprite('duckBarP1', 'healthbars/duck/duck-p1', 0, 630)
    setObjectCamera('duckBarP1', 'hud')
    scaleObject('duckBarP1', 0.51, 0.51)
    screenCenter('duckBarP1', 'X')
    addLuaSprite('duckBarP1')
    setProperty('duckBarP1.alpha', 0.001)

    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('uiGroup.visible', false)
    setProperty('comboGroup.visible', false)

    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'visible', false)
	setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 0.001)
    end
end

function onUpdatePost()
    runHaxeCode([[
        var scaleValue = 1.9608;
        var duckBar = game.getLuaObject('duckBarP1');
        var barWidth:Int = Std.int((game.health / 2) * duckBar.width*scaleValue);

        duckBar.clipRect = new FlxRect(duckBar.width*scaleValue - barWidth, 0, barWidth, duckBar.height*scaleValue);
    ]])
end

function onStepHit()
    if curStep == 64 then
	for i, things in ipairs({'base', 'duckBarP1', 'duckBarP2', 'dad'}) do
	    startTween('tweencoiso'..i, things, {alpha = 1}, 0.5, {ease = 'sineInOut'})
	    noteTweenAlpha('bomdia'..i+3, i+3, 1, 0.5, 'sineInOut')
	end
    end
end

function onCountdownTick(c)
    local countSpr = {'countdownReady', 'countdownSet', 'countdownGo'}
    setProperty(countSpr[c]..'.visible', false)
end

function goodNoteHit(i,d,t,s)
    if not s then addHealth(.02)end
end

function onSpawnNote()
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'visible', false)
    end
end