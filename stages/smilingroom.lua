local imgPath = 'stages/spread/'
local stwCount = 1

local stage1 = {'photoback', 'topphoto', 'photostatic', 'dad'}

luaDebugMode = true
function onCreate()
    addCharacterToList('dog2', 'dad')
    precacheImage(imgPath.."text/spreadtheword")

    runHaxeCode("FlxG.mouse.visible = true;")

    makeAnimatedLuaSprite('ibg', imgPath..'intro/startbg', 0, 0)
    addAnimationByPrefix('ibg', 'anim', 'transition', 12, false)
    addLuaSprite('ibg')

    makeAnimatedLuaSprite('ipc', imgPath..'intro/startpc', -10, 391)
    addAnimationByPrefix('ipc', 'anim', 'transition', 12, false)
    scaleObject('ipc', 1.01, 1.02)
    addLuaSprite('ipc', true)

    makeLuaSprite('photoback', imgPath..'backphoto', 390, 530)
    addLuaSprite('photoback')

    makeAnimatedLuaSprite('topphoto', imgPath..'topphoto', 325, 550)
    addAnimationByPrefix('topphoto', 'idle', 'topphoto', 24, true)
    addLuaSprite('topphoto', true)
    --setProperty('topwall.color', 0x000000)

    makeAnimatedLuaSprite('photostatic', imgPath..'photostatic', 450, 564)
    addAnimationByPrefix('photostatic', 'idle', 'loop', 24, true)
    addLuaSprite('photostatic', true)
    setProperty('photostatic.alpha', 0.2)

    makeAnimatedLuaSprite('vhs', imgPath..'intro/vhstop', 0, 0)
    addAnimationByPrefix('vhs', 'anim', 'vhs1', 24, false)
    setObjectCamera('vhs', 'other')
    scaleObject('vhs', 4.75, 4.75)
    screenCenter('vhs', 'XY')
    addLuaSprite('vhs')
    setProperty('vhs.alpha', 0.3)

    local wid, hgt = 752, 367

    makeLuaSprite('blackPc', nil, 325, 550)
    makeGraphic('blackPc', wid, hgt, '000000')
    addLuaSprite('blackPc')

    makeAnimatedLuaSprite('turnOn', imgPath..'intro/pcturnon', 325, 550)
    addAnimationByPrefix('turnOn', 'anim', 'pcturnon', 12, false)
    setProperty('turnOn.width', wid) setProperty('turnOn.height', hgt)
    scaleObject('turnOn', 0.432, 0.385)
    addLuaSprite('turnOn', true)
    setProperty('turnOn.alpha', 0.001)

    makeLuaSprite('wallpaper', imgPath..'intro/wallpaper', 255, 462)
    setProperty('wallpaper.width', wid)
    setProperty('wallpaper.height', hgt)
    scaleObject('wallpaper', 1.02, 1.02)
    addLuaSprite('wallpaper')
    setProperty('wallpaper.alpha', 0.001)

    makeAnimatedLuaSprite('apps', imgPath..'apps', 338, 570)
    addAnimationByPrefix('apps', 'idle', 'apps', 24, true)
    scaleObject('apps', 0.5, 0.5)
    addLuaSprite('apps')
    setProperty('apps.alpha', 0.001)

    makeLuaSprite('appHitbox', nil, 187, 318)
    makeGraphic('appHitbox', 38.5, 45, '5f61e8')
    setObjectCamera('appHitbox', 'other') -- kys mouse
    setProperty('appHitbox.alpha', 0.001) -- 0.5
    setProperty('appHitbox.visible', false)
    addLuaSprite('appHitbox')

    makeAnimatedLuaSprite('mailWindow', imgPath..'intro/mailwindow', 416, 585)
    addAnimationByPrefix('mailWindow', 'window', 'mailwindow1', 24, true)
    addAnimationByPrefix('mailWindow', 'enter', 'mailwindowenter', 24, false)
    scaleObject('mailWindow', 0.5, 0.5)
    setProperty('mailWindow.alpha', 0.001)
    addLuaSprite('mailWindow', true)

    makeLuaSprite('smileHitbox', nil, 419, 242)
    makeGraphic('smileHitbox', 82, 27, '000000')
    setObjectCamera('smileHitbox', 'other') -- kys mouse2
    setProperty('smileHitbox.alpha', 0.001)
    setProperty('smileHitbox.visible', false)
    addLuaSprite('smileHitbox')

    makeAnimatedLuaSprite('smileMail', imgPath..'intro/sendmail', 436, 583)
    addAnimationByPrefix('smileMail', 'idle', 'sendmailidle', 24, true)
    addAnimationByPrefix('smileMail', 'enter', 'sendmailenter', 24, false)
    scaleObject('smileMail', 0.4, 0.4)
    setProperty('smileMail.alpha', 0.001)
    addLuaSprite('smileMail', true)

    -- THE FINAL INTRO
    makeAnimatedLuaSprite("dogkill", 'stages/spread/WidespreadEnding/dogkill',-100,250)
    addAnimationByPrefix("dogkill", "jump", "jump",24,false)
    setProperty("dogkill.alpha", 0.001)
    addLuaSprite("dogkill", true)

    makeAnimatedLuaSprite("endbg1", 'stages/spread/WidespreadEnding/widespreadending1',0,0)
    addAnimationByPrefix("endbg1", "spread", "transition",12,false)
    scaleObject("endbg1", 2, 2, true)
    setProperty("endbg1.alpha", 0.001)
    setObjectCamera('endbg1', 'uiCam')
    addLuaSprite("endbg1", false)

    makeAnimatedLuaSprite("endbg2", 'stages/spread/WidespreadEnding/widespreadending2',0,0)
    addAnimationByPrefix("endbg2", "spazz", "spazz",12,false)
    scaleObject("endbg2", 2, 2, true)
    setProperty("endbg2.alpha", 0.001)
    setObjectCamera('endbg2', 'uiCam')
    addLuaSprite("endbg2", false)

    makeAnimatedLuaSprite("death", 'stages/spread/WidespreadEnding/widespreadending2top',0,0)
    addAnimationByPrefix("death", "embed", "embed",12,false)
    scaleObject("death", 1, 1, true)
    screenCenter("death", 'xy')
    setProperty("death.alpha", 0.001)
    setObjectCamera('death', 'uiCam')
    addLuaSprite("death", false)

    makeLuaSprite('blackGraphic', nil)
    makeGraphic('blackGraphic', screenWidth, screenHeight, 'ffffff')
    setScrollFactor('blackGraphic', 0, 0)
    screenCenter('blackGraphic', 'XY')
    addLuaSprite('blackGraphic', true)
    setProperty('blackGraphic.color', getColorFromHex('000000'))
end

function onCreatePost()
    makeLuaSprite('vig', imgPath..'vignette')
    setObjectCamera('vig', 'other')
    screenCenter('vig', 'XY')
    addLuaSprite('vig', true)

    for _, objs in pairs(stage1) do
        setProperty(objs..'.alpha', 0.001)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'STW Text' then
        makeAnimatedLuaSprite("SPREADTHEWORD"..stwCount, 'stages/spread/text/spreadtheword',getRandomFloat(-290, 800),getRandomFloat(350, 650))
        addAnimationByPrefix("SPREADTHEWORD"..stwCount, "spreadtheword", "spreadtheword",24,false)
        scaleObject("SPREADTHEWORD"..stwCount, getRandomFloat(0.25,2), getRandomFloat(0.25,2), true)
        setProperty("SPREADTHEWORD"..stwCount..".angle", getRandomFloat(-30,30))
        addLuaSprite("SPREADTHEWORD"..stwCount, true)
        playAnim("SPREADTHEWORD"..stwCount, "spreadtheword", true)
        runTimer("DISSAPEARLOL"..stwCount,0.5)
        stwCount = stwCount + 1;
    end
end

local startSong = false;
local finishSong = false;

function onStartCountdown()
    if not startSong then
        startSong = true
        runTimer('pcCutscene', .5)
        return Function_Stop
    end
    return Function_Continue
end

function onEndSong()
    if thirdeye == true then
        return Function_Continue;
    else
        playAnim("dad", "singDOWN")
        setProperty("camHUD.alpha", 0.001)
        runTimer("jump", 0.30)
        if finishSong == true then
            return Function_Continue;
        end
        return Function_Stop;
    end
end

local canShow = false
local canSelect = false
function onUpdate()
    if getProperty('controls.ACCEPT') then
        startCountdown()
    end

    if getProperty('turnOn.animation.finished') and canShow then
        setProperty('turnOn.alpha', 0.001)
        setProperty('wallpaper.alpha', 1)
        setProperty('apps.alpha', 1)
    end

    if canSelect and mouseOverlaps('appHitbox', 'camOther') then
        setProperty('appHitbox.alpha', 0.5)
        if mouseReleased() then
            canSelect = false
            doTweenAlpha('windowAlpha', 'mailWindow', 1, 0.1)
            playAnim('mailWindow', 'enter')
            setProperty('smileHitbox.visible', true)
        end
    else
        setProperty('appHitbox.alpha', 0.001)
    end

    if getProperty('smileHitbox.visible') and mouseOverlaps('smileHitbox', 'other') and mouseReleased() then
        setProperty('smileHitbox.visible', false)
        doTweenAlpha('windowAlpha', 'smileMail', 1, 0.1)
        playAnim('smileMail', 'enter')
    end

    if getProperty('mailWindow.animation.curAnim.name') == 'enter' and
    getProperty('mailWindow.animation.curAnim.finished') then
        playAnim('mailWindow', 'window', true)
    end
    if getProperty('smileMail.animation.curAnim.name') == 'enter' and
    getProperty('smileMail.animation.curAnim.finished') then
        playAnim('smileMail', 'idle', true)
    end
end

function onTimerCompleted(tag)
    for i = 1,stwCount do
        if tag == 'DISSAPEARLOL'..i then
            removeLuaSprite('SPREADTHEWORD'..i, false)
        end
    end

    if tag == 'jump' then
        playSound("endings/widespread", 1, "endingsound")
        setProperty("dogkill.alpha", 1)
        playAnim("dogkill", "jump", true)
        setProperty('dad.alpha', 0.001)
        runTimer("showmessage", 0.37)
    end

    if tag == 'showmessage' then
        removeLuaSprite("dogkill", true)
        playAnim("endbg1", "spread", true)
        setProperty("endbg1.alpha", 1)
        runTimer("symbol", 0.49)
    end

    if tag == 'symbol' then
        removeLuaSprite("endbg1", true)
        playAnim("endbg2", "spazz", true)
        setProperty("endbg2.alpha", 1)
        playAnim("death", "embed", true)
        setProperty("death.alpha", 1)
        
        runTimer("endingsequence", 5)
    end

    if tag == 'endingsequence' then
        finishSong = true;
        endSong()
    end

    if tag == 'pcCutscene' then
        doTweenAlpha('hiworld', 'blackGraphic', 0.001, 0.5)
        setProperty('turnOn.alpha', 1)

        playAnim('vhs', 'anim')
        playAnim('ipc', 'anim')
        playAnim('turnOn', 'anim', true)

        doTweenZoom('zoomTween1', 'camGame', 1.3, 4, 'linear')
        runTimer('pcTurnOn', 1.8)
    end

    if tag == 'pcTurnOn' then
        playSound('windows/XP')
        canShow = true
        doTweenAlpha('lolaou', 'vhs', 0.001, 0.5)
    end
end

function onTweenCompleted(tag)
    if tag == 'zoomTween1' then
        canSelect = true
        setProperty('appHitbox.visible', true)
    end
end

function mouseOverlaps(obj, camera)
    local mX = getMouseX(camera)
    local mY = getMouseY(camera)
    local x = getProperty(obj..'.x')
    local y = getProperty(obj..'.y')
    local wid = getProperty(obj..'.width')
    local hgt = getProperty(obj..'.height')
    return (mX > x) and (mX < x + wid) and (mY > y) and (mY < y + hgt)
end