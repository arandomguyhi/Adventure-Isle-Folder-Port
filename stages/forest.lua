local imgPath = 'stages/trinity/'

luaDebugMode = true
function onCreate()
    addHaxeLibrary('FlxBackdrop', 'flixel.addons.display')
    addHaxeLibrary('FlxFlicker', 'flixel.effects')

    setProperty('skipCountdown', true)

    -- AMY'S PART
    makeLuaSprite('back1', imgPath..'bg1', -15, 196)
    setProperty('back1.antialiasing', false)
    addLuaSprite('back1')

    makeAnimatedLuaSprite('back1P', imgPath..'bg1-prints', -15, 196)
    addAnimationByPrefix('back1P', 'anim', 'idle', 12, false)
    setProperty('back1P.antialiasing', false)
    addLuaSprite('back1P')
    setProperty('back1P.alpha', 0.001)

    makeLuaSprite('back2', imgPath..'bg2', 15, 200)
    setProperty('back2.antialiasing', false)
    addLuaSprite('back2')
    setProperty('back2.alpha', 0.001)

    runHaxeCode([[
        // HS means HardStyle
        var HSamy:FlxBackdrop = new FlxBackdrop(null, 0x01, 0, 0);
        HSamy.frames = Paths.getSparrowAtlas('characters/faith/amy/amy-hardstyle'); // i love you larry
        HSamy.animation.addByPrefix('idle', 'idle0', 24, true);
        HSamy.y = 220;
        HSamy.alpha = 0.001;
        addBehindGF(HSamy);
        setVar('HSamy', HSamy);
    ]])

    -- MICHAEL'S PART
    for i = 1,2 do
        makeLuaSprite('border'..i, imgPath..'michael/border', 0, -75+i*75)
        setProperty('border'..i..'.antialiasing', false)
        addLuaSprite('border'..i)
    end
    setProperty('border1.x', -500) setProperty('border2.x', 500)

    makeLuaSprite('mikeBg', imgPath..'michael/Michael BG', -130, 235)
    setProperty('mikeBg.antialiasing', false)
    addLuaSprite('mikeBg')
    setProperty('mikeBg.alpha', 0.001)

    -- SOLO
    makeLuaSprite('alone', imgPath..'john/alone', -297, 253)
    setProperty('alone.antialiasing', false)
    addLuaSprite('alone')
    setProperty('alone.alpha', 0.001)

    -- Garcia and Michael
    for i = 1,2 do
        makeLuaSprite('borderVert'..i, imgPath..'michael/border_vertical', -310+i*170, -82)
        setProperty('borderVert'..i..'.antialiasing', false)
        addLuaSprite('borderVert'..i, true)
        setProperty('borderVert'..i..'.alpha', 0.001)
    end
    setProperty('borderVert1.y', -82+300) setProperty('borderVert2.y', -82-300)

    makeLuaSprite('blackBorder', nil, -32, -82)
    makeGraphic('blackBorder', 62, 154, '000000')
    addLuaSprite('blackBorder', true)
    setProperty('blackBorder.alpha', 0.001)

    -- 2v2
    makeLuaSprite('2v2bg', imgPath..'2v2', -310, -165)
    setProperty('2v2bg.antialiasing', false)
    addLuaSprite('2v2bg')
    setProperty('2v2bg.alpha', 0.001)

    -- AMY'S FINAL PART
    makeLuaSprite('entrance', imgPath..'amy/entrance', -42-50, -42+130)
    setProperty('entrance.antialiasing', false)
    addLuaSprite('entrance')
    setProperty('entrance.alpha', 0.001)

    -- CUTSCENES
    makeAnimatedLuaSprite('pretty', imgPath..'transition/pretty')
    addAnimationByPrefix('pretty', 'anim', 'idle', 12, false)
    scaleObject('pretty', 4.05, 4.05)
    setObjectCamera('pretty', 'hud')
    screenCenter('pretty', 'XY')
    setProperty('pretty.antialiasing', false)
    addLuaSprite('pretty')
    setProperty('pretty.alpha', 0.001)

    makeAnimatedLuaSprite('suffer', imgPath..'transition/suffer')
    addAnimationByPrefix('suffer', 'anim', 'idle', 12, false)
    scaleObject('suffer', 4.05, 4.05)
    setObjectCamera('suffer', 'hud')
    screenCenter('suffer', 'XY')
    setProperty('suffer.antialiasing', false)
    addLuaSprite('suffer')
    setProperty('suffer.alpha', 0.001)

    makeAnimatedLuaSprite('bang', imgPath..'transition/bang')
    addAnimationByPrefix('bang', 'anim', 'idle', 12, false)
    scaleObject('bang', 4.05, 4.05)
    setObjectCamera('bang', 'hud')
    screenCenter('bang', 'XY')
    setProperty('bang.antialiasing', false)
    addLuaSprite('bang')
    setProperty('bang.alpha', 0.001)

    -- random shit
    makeLuaSprite('blackGraphic', nil)
    makeGraphic('blackGraphic', screenWidth, screenHeight, 'ffffff')
    setScrollFactor('blackGraphic', 0, 0)
    screenCenter('blackGraphic', 'XY')
    setObjectCamera('blackGraphic', 'hud')
    addLuaSprite('blackGraphic', true)
    setProperty('blackGraphic.color', getColorFromHex('000000'))

    -- song title shit
    makeLuaSprite('mortisTitle', 'titlecards/mortis', 0, 0)
    setObjectCamera('mortisTitle', 'camHUD')
    screenCenter('mortisTitle', 'XY')
    addLuaSprite('mortisTitle', true)
    setProperty('mortisTitle.alpha', 0.001)

    makeLuaSprite('mortisEvilTitle', 'titlecards/evilmortis', 0, 0)
    setObjectCamera('mortisEvilTitle', 'camHUD')
    screenCenter('mortisEvilTitle', 'XY')
    addLuaSprite('mortisEvilTitle', true)
    setProperty('mortisEvilTitle.visible', false)

    setProperty('camZooming', true)
    setProperty('health', 2)
    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('comboGroup.visible', false)
    setProperty('uiGroup.visible', false)
    setProperty('gf.alpha', 0.001)
end

function onSpawnNote()
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'visible', false)
    end
end

function onUpdate()
    if getProperty('pretty.animation.curAnim.finished') then
        setProperty('pretty.alpha', 0.001)
    end
    if getProperty('suffer.animation.curAnim.finished') then
        setProperty('suffer.alpha', 0.001)
    end
    if getProperty('bang.animation.curAnim.finished') then
        setProperty('bang.alpha', 0.001)
    end

    if curStep >= 1327 and curStep <= 1472 then
        runHaxeCode([[
            getVar('HSamy').animation.copyFrom(dad.animation);
            getVar('HSamy').animation.curAnim.curFrame = dad.animation.curAnim.curFrame;
            getVar('HSamy').offset.set(dad.animOffsets.get(dad.animation.curAnim.name)[0], dad.animOffsets.get(dad.animation.curAnim.name)[1]);
        ]])
    end
end

function opponentNoteHit(i,d,t,s)
    setHealth(getHealth()-0.003 * (dadName:find('amy') and 1 or 1.5))
end

function goodNoteHit(i,d,t,s)
    if not s then
        setHealth(getHealth()+0.008)
    end
end


-- ALL SONG EVENTS BELOW
local allowStart = false
function onStartCountdown()
    if not allowStart then
        allowStart = true
        doTweenAlpha('mortistween', 'mortisTitle', 1, 1)
        return Function_Stop
    end
    return Function_Continue
end

function onSongStart()
    doTweenAlpha('bxl', 'blackGraphic', 0.001, 4, 'linear')

    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'visible', false)
    end
end

function onBeatHit()
    if curStep >= 1327 and curStep <= 1454 then
        setProperty('HSamy.x', -10)
        startTween('hardstyleamytween', 'HSamy', {x = -138}, 0.05, {}) -- velocity.x won't work for this

        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.01)
    end
end

function onStepHit()
	if curStep == 288 then
		setVar('camZoom', 0.5)
        setObjectCamera('blackGraphic', 'game')
	elseif curStep == 416 then
		setVar('camZoom', 1)
	elseif curStep == 480 then
		setProperty('camZooming', false)
		doTweenZoom('firstzoom', 'camGame', getProperty('defaultCamZoom')+0.5, 2, 'sineIn')
	end

    if curStep == 572 then
        setProperty('back1P.alpha', 1)
        playAnim('back1P', 'anim')
    elseif curStep == 578 then
        setProperty('blackGraphic.alpha', 1)
        setProperty('back1P.alpha', 0.001)
        setProperty('back2.alpha', 1)
        setProperty('back1.alpha', 0.001)
        setCharacterX('dad', 315) setCharacterY('dad', 270)
    elseif curStep == 584 then
        setProperty('pretty.alpha', 1)
        playAnim('pretty', 'anim')
	setVar('camZoom', 0)
    elseif curStep == 624 then
        setProperty('blackGraphic.alpha', 0.001)
	elseif curStep == 735 then
		doTweenZoom('oi', 'camGame', getProperty('defaultCamZoom')+1, 1.5, 'quadIn')
    end

    if curStep == 912 then
        setCharacterX('dad', 305) setCharacterY('dad', 275)
    elseif curStep == 1312 then
        setProperty('blackGraphic.alpha', 1)
    elseif curStep == 1327 then
        setProperty('isCameraOnForcedPos', true)
        setProperty('back2.alpha', 0.001)
        setProperty('blackGraphic.alpha', 0.001)

        setProperty('dad.alpha', 0.001)
        setProperty('HSamy.alpha', 0.5)
        setCharacterX('dad', 0) setCharacterY('dad', 220)
    elseif curStep == 1472 then
        setProperty('blackGraphic.alpha', 1)
        setProperty('HSamy.alpha', .001)
    end

    if curStep == 1488 then
        setProperty('blackGraphic.alpha', 0.001)
        for i = 1,2 do startTween('btween'..i, 'border'..i, {x = 0}, 2, {ease = 'circOut'})end
        doTweenX('charlesTween', 'boyfriend', 0, 2, 'circOut')
        setCharacterX('boyfriend', 500) setCharacterY('boyfriend', 77)

        setProperty('dad.alpha', 1)
        setCharacterX('dad', -502) setCharacterY('dad', 2)
        doTweenX('michaelTween', 'dad', 2, 2, 'circOut')
        setProperty('dad.color', getColorFromHex('000000'))
    elseif curStep == 1720 then
        setProperty('blackGraphic.alpha', 1)
    elseif curStep == 1724 then
        setProperty('suffer.alpha', 1)
        playAnim('suffer', 'anim')
    elseif curStep == 1759 then
        setProperty('blackGraphic.alpha', 0.001)
        setProperty('dad.color', getColorFromHex('FFFFFF'))
    elseif curStep == 1880 then
        doTweenAlpha('blackie', 'blackGraphic', 1, 0.5)
        doTweenZoom('zoomin', 'camGame', 20, 1, 'backInOut')
    end

    if curStep == 1888 then
        setProperty('border1.alpha', .001) setProperty('border2.alpha', .001)
        setProperty('mikeBg.alpha', 1)

        setCharacterX('boyfriend', 90) setCharacterY('boyfriend', 260) -- default
        setCharacterX('dad', 0) setCharacterY('dad', 295)
    elseif curStep == 1891 then
        doTweenAlpha('blackieOut', 'blackGraphic', 0.001, 2)
    end

    if curStep == 2285 then
        doTweenAlpha('blackie', 'blackGraphic', 1, 2)
    elseif curStep == 2286 then
        doTweenZoom('zoomin11', 'camGame', 6, 5, 'sineInOut')
    elseif curStep == 2332 then
        cancelTween('zoomin11')
        setProperty('dad.alpha', 0.001)

        doTweenAlpha('blackieOut', 'blackGraphic', 0.001, 2)
        setProperty('mikeBg.alpha', 0.001)
        setProperty('alone.alpha', 1)
    end

    if curStep == 2672 then
        setProperty('blackGraphic.color', getColorFromHex('ffffff'))
        doTweenAlpha('whiteFlash', 'blackGraphic', 1, 2)
    elseif curStep == 2704 then
        setProperty('alone.alpha', 0.001)
        setProperty('blackBorder.alpha', 1)
        for i=1,2 do setProperty('borderVert'..i..'.alpha', 1)end
        setProperty('dad.alpha', 1)

        setCharacterX('boyfriend', 16) setCharacterY('boyfriend', -58-300)
        setCharacterX('dad', -138) setCharacterY('dad', -52+300)

        doTweenY('border1twn', 'borderVert1', -82, 1.5, 'circOut')
        doTweenY('dadtween', 'dad', -52, 1.5, 'circOut')

        doTweenY('border2twn', 'borderVert2', -82, 1.5, 'circOut')
        doTweenY('bftween', 'boyfriend', -58, 1.5, 'circOut')
    elseif curStep == 2708 then
        doTweenAlpha('whiteFlash', 'blackGraphic', .001, 2)
    end

    if curStep == 2952 then
        setProperty('blackGraphic.color', getColorFromHex('000000'))
        doTweenAlpha('blackalp', 'blackGraphic', 1, 0.5)
        doTweenZoom('zoominlol', 'camGame', 8, 1.2, 'backInOut')
    elseif curStep == 2960 then
        cancelTween('zoominlol')
        doTweenAlpha('blackalp', 'blackGraphic', 0.001, 1)

        setProperty('blackBorder.alpha', .001)
        for i=1,2 do setProperty('borderVert'..i..'.alpha', .001)end
        setProperty('2v2bg.alpha', 1)

        setProperty('michael.alpha', 1)
        setProperty('gf.alpha', 1)

        setCharacterX('dad', 35) setCharacterY('dad', -34)
        setCharacterX('boyfriend', 82) setCharacterY('boyfriend', -110)
        setCharacterX('girlfriend', -312) setCharacterY('girlfriend', -166)
    end

    if curStep == 3599 then
        doTweenZoom('zoominagain', 'camGame', 5, 6, 'cubeIn')
    elseif curStep == 3631 then
        doTweenAlpha('somestage', '2v2bg', 0.001, 0.5)
    elseif curStep == 3636 then
        setProperty('bang.alpha', 1)
        playAnim('bang', 'anim')
    elseif curStep == 3656 then
        setCharacterX('dad', 140-50) setCharacterY('dad', 94)
        setCharacterX('boyfriend', -50) setCharacterY('boyfriend', 130)
        setProperty('gf.alpha', 0.001)
    elseif curStep == 3664 then
        cameraFlash('camGame', 'FF0000', 1)
        setProperty('entrance.alpha', 0.5)
        setProperty('michael.alpha', 0.001)
    end

	if curStep == 4039 then
		doTweenZoom('camGameZoom', 'camGame', 5.3, 0.75, 'cubeIn')
	elseif curStep == 4048 then
		cameraFlash('camGame', 'bce004', 1)
		setProperty('entrance.alpha', 0.001)
		setProperty('dad.alpha', 0.001)
		setProperty('camZooming', false)
		doTweenZoom('finalzoomtween', 'camGame', 3.5, 28, 'quadIn')
	elseif curStep == 4284 then
        for i = 4,7 do noteTweenAlpha('twn'..i, i, 0.001, 2)end
        doTweenAlpha('endtween1', 'crucifix1', 0.001, 2)
        doTweenAlpha('endtween2', 'crucifix2', 0.001, 2)
	end
end

function onEvent(n,v1,v2)
    if n == 'Play Animation' then
        if v1 == 'amyfastdrop' then
            setProperty('HSamy.x', -10)
            startTween('hardstyleamytween', 'HSamy', {x = -138}, 0.05, {})

            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.01)
        end
    end
end

function onTweenCompleted(tag)
	if tag == 'firstzoom' then
		setProperty('camZooming', true)
		setVar('camZoom', 1.5)
	end
    if tag == 'mortistween' then
        runHaxeCode([[
            FlxFlicker.flicker(game.getLuaObject('mortisTitle'), 1, 0.09, false);
            FlxFlicker.flicker(game.getLuaObject('mortisEvilTitle'), 1, 0.09, true);
        ]])
        runTimer('titleTimer', 2)
    end
end

function onTimerCompleted(tag)
    if tag == 'titleTimer' then
        doTweenAlpha('endTitle', 'mortisEvilTitle', 0.001, 1) runTimer('startSong', 1)
    elseif tag == 'startSong' then
        startCountdown()end
end