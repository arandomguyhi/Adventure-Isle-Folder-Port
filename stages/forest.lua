local imgPath = 'stages/trinity/'

luaDebugMode = true
function onCreate()
    addHaxeLibrary('FlxBar', 'flixel.ui')
    addHaxeLibrary('FlxBarFillDirection', 'flixel.ui')
    addHaxeLibrary('FlxBackdrop', 'flixel.addons.display')

    setProperty('skipCountdown', true)

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

    for i = 1,2 do
        makeLuaSprite('border'..i, imgPath..'michael/border', 0, -75+i*75)
        setProperty('border'..i..'.antialiasing', false)
        addLuaSprite('border'..i)
    end
    setProperty('border1.x', -500) setProperty('border2.x', 500)

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

    makeLuaSprite('blackGraphic', nil)
    makeGraphic('blackGraphic', screenWidth, screenHeight, '000000')
    setScrollFactor('blackGraphic', 0, 0)
    screenCenter('blackGraphic', 'XY')
    addLuaSprite('blackGraphic', true)

    setProperty('health', 2)
    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('comboGroup.visible', false)
    setProperty('uiGroup.visible', false)
    setProperty('gf.alpha', 0.001)

    for i = 0,3 do
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
    end

    runHaxeCode([[
        var crucifix = new FlxBar(FlxG.width-100, 150, FlxBarFillDirection.BOTTOM_TO_TOP, 31, 144, game, "health", 0, 2);
        crucifix.createImageBar(Paths.image("healthbars/trinity/bar-p2"), Paths.image("healthbars/trinity/bar-p1"));
	    crucifix.cameras = [game.camHUD];
        crucifix.scale.set(3, 3.1);
	    crucifix.updateHitbox();
        game.add(crucifix);
    ]])
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

    if curStep >= 1327 and curStep <= 1472 then
        runHaxeCode([[
            getVar('HSamy').animation.copyFrom(dad.animation);
            getVar('HSamy').animation.curAnim.curFrame = dad.animation.curAnim.curFrame;
            getVar('HSamy').offset.set(dad.animOffsets.get(dad.animation.curAnim.name)[0], dad.animOffsets.get(dad.animation.curAnim.name)[1]);
        ]])
    end
end

function opponentNoteHit(i,d,t,s)
    if not s then setHealth(getHealth()-0.007) end
end

function goodNoteHit(i,d,t,s)
    if not s then
        setHealth(getHealth()+0.007)
    end
end

function onSongStart()
    doTweenAlpha('bxl', 'blackGraphic', 0.001, 4, 'linear')
end

function onBeatHit()
    if curStep >= 1327 and curStep <= 1454 then
        setProperty('HSamy.x', -10)
        startTween('hardstyleamytween', 'HSamy', {x = -138}, 0.05, {}) -- velocity.x won't work for this
    end
end

function onStepHit()
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
    elseif curStep == 624 then
        setProperty('blackGraphic.alpha', 0.001)
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
    end
end

function onEvent(n,v1,v2)
    if n == 'Play Animation' then
        if v1 == 'amyfastdrop' then
            setProperty('HSamy.x', -10)
            startTween('hardstyleamytween', 'HSamy', {x = -138}, 0.05, {})
        end
    end
end