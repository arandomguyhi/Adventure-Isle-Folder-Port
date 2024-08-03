local imagePath = 'stages/smile/'

function onCreate()
    makeAnimatedLuaSprite("DEATHTOALL",imagePath..'DEATHTOALL',0,0)
    addAnimationByPrefix("DEATHTOALL","loop","loop",24,true)
    playAnim("DEATHTOALL","loop",true)
    setProperty("DEATHTOALL.visible", false);
    addLuaSprite('DEATHTOALL',false)

    makeAnimatedLuaSprite("laugh",imagePath..'windows/laugh',0,0)
    addAnimationByPrefix("laugh","loop","laugh dog",60,true)
    playAnim("laugh","loop",true)
    scaleObject("laugh", 0.4, 0.4, true)
    screenCenter("laugh","xy")
    setObjectCamera('laugh', 'camHUD')
    setProperty("laugh.visible", false);
    addLuaSprite('laugh',true)

    makeLuaText("afraid", "", 350, 300, 140);
    setTextFont("afraid", "StepRightUp.ttf");
    setTextAlignment("afraid",'left')
    setTextColor("afraid", "000000")
    setTextBorder("afraid", 0, "000000")
    setTextSize("afraid", 20);
    setObjectCamera('afraid', 'camHUD')
    setProperty("afraid.visible", false);
    addLuaText("afraid");
end

function onUpdate()
    setProperty('DEATHTOALL.x', getProperty('dad.x'))
    setProperty('DEATHTOALL.y', getProperty('dad.y') - 100)
end

function onStepHit()
    if songName == 'Minds Eye Squared' then
        if curStep == 1232 then
            setObjectCamera('DEATHTOALL', 'camUI')
            setProperty('DEATHTOALL.x', 0)
            setProperty('DEATHTOALL.y', 0)
            setProperty("DEATHTOALL.visible", true);
        end

        if curStep == 1992 then
            setProperty("laugh.visible", true);
            setProperty('camGame.visible',false)
            setProperty('camUI.visible',false)
            setProperty("afraid.visible", true);
            setTextString("afraid", "HA");
        end

        if curStep == 1993 then
            setTextString("afraid", "HAHA");
        end
        if curStep == 1994 then
            setTextString("afraid", "HAHAHA");
        end
        if curStep == 1995 then
            setTextString("afraid", "HAHAHAHA");
        end
        if curStep == 1996 then
            setTextString("afraid", "HAHAHAHAHA");
        end
        if curStep == 1997 then
            setTextString("afraid", "HAHAHAHAHAHA");
        end
        if curStep == 1998 then
            setTextString("afraid", "HAHAHAHAHAHAHA");
        end
        if curStep == 1999 then
            setTextString("afraid", "HAHAHAHAHAHAHAHA");
        end

        if curStep == 2000 then
            setProperty("laugh.visible", false);
            setProperty('camGame.visible',true)
            setProperty('camUI.visible',true)
            setProperty("afraid.visible", false);
        end

        if curStep == 2893 then
            --setObjectCamera('DEATHTOALL', 'camUI')
            setProperty("DEATHTOALL.visible", false);
        end

        if curStep == 3408 then
            --setObjectCamera('DEATHTOALL', 'camUI')
            setProperty('DEATHTOALL.x', 0)
            setProperty('DEATHTOALL.y', 0)
            setProperty("DEATHTOALL.visible", true);
        end
    end
end