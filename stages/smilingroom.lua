local imgPath = 'stages/spread/'
local stwCount = 1

function onCreate()
    addCharacterToList('dog2', 'dad')
    precacheImage(imgPath.."text/spreadtheword")

    makeLuaSprite('wallpaper', imgPath..'backphoto', 390, 530)
    addLuaSprite('wallpaper')

    makeAnimatedLuaSprite('topwall', imgPath..'topphoto', 325, 550)
    addAnimationByPrefix('topwall', 'idle', 'topphoto', 24, true)
    addLuaSprite('topwall', true)
    --setProperty('topwall.color', 0x000000)

    makeAnimatedLuaSprite('wallstatic', imgPath..'photostatic', 450, 564)
    addAnimationByPrefix('wallstatic', 'idle', 'loop', 24, true)
    addLuaSprite('wallstatic', true)
    setProperty('wallstatic.alpha', 0.1)

    -- THE FINAL "CUTSCENE"
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
end

function onCreatePost()
    makeLuaSprite('vig', imgPath..'vignette')
    setObjectCamera('vig', 'hud')
    screenCenter('vig', 'XY')
    addLuaSprite('vig', true)
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

local finishSong = false;
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
end