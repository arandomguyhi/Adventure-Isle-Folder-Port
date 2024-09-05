
local imagePath = 'stages/smile/'

Monitor = {
    width = getPropertyFromClass("flixel.FlxG", "stage.fullScreenWidth"),
    height = getPropertyFromClass("flixel.FlxG", "stage.fullScreenHeight")
}

local windowCount = 1
local windows = {'DEATH', 'DOG', 'SARAH', 'SMILE', 'SPREADTHEWORD'};
local windowString = '';

local windowChecks = {}
local windowHealth = {}

local xpCount = 1
local xpWins = {'AREYOUHAVINGFUN', 'CHECKTHESEMOVES', 'HISARATAYLOR', 'INYOURROOM', 'LOVELAUGHLOVE','PAYATTENTION'};
local xpString = '';

local xpChecks = {}
local xpHealth = {}

function window_center()
    return (Monitor.width - 1280) / 2, (Monitor.height - 720) / 2
end
function onCreate() 
    setProperty('skipCountdown',true)
    --for i = 1,#windows do
    --    precacheImage('stages/smile/windows/'..windows[i]);
    --end
    addHaxeLibrary('Lib', 'openfl');

    makeLuaSprite("black",'',-2000,-1000);
    makeGraphic("black",4000,4000,'000000')
    setObjectCamera("black", 'camUI')
    addLuaSprite("black",true)
    setProperty('uiGroup.alpha',0)
    setObjectOrder("black", 99)
    setProperty('botplayTxt.alpha',0)
    for i = 0,3 do
        setPropertyFromGroup('playerStrums', i, 'alpha', 0)
    end

    setProperty('_customP1Bar.alpha',0);
    setProperty('_customP2Bar.alpha',0);
    setProperty('windowFrame.alpha',0);
    setProperty('iconP1.alpha',0);
    setProperty('iconP2.alpha',0);

    makeLuaSprite('polaroid',imagePath..'PEEKABOO',0,0);
    scaleLuaSprite("polaroid", 0.0, 0.0)
    screenCenter("polaroid", 'xy');
    setObjectCamera("polaroid", 'camFilter')
    setProperty('polaroid.alpha',0)
    addLuaSprite("polaroid",true);

end

function onCreatePost()
	addHaxeLibrary('FlxG','flixel');
    --c_x, c_y = window_center()
    --WindowFollow = {x = c_x, y = c_y}
    
    --setPropertyFromClass("lime.app.Application", "current.window.width", 1280)
    --setPropertyFromClass("lime.app.Application", "current.window.height", 720)
end

--function lerp(a, b, c)return a + c * (b - a)end
--function bound(a, b, c)return a < b and b or a > c and c or a end

function onUpdate(elapsed)
    --cam zooms depending on which character

    if mouseClicked('left') then
		for i = 1,windowCount do
			local popupX = getProperty('popup'..i..'.x'); 
            local popupY = getProperty('popup'..i..'.y');
            local popupWidth = getProperty('popup'..i..'.width');
            local popupHeight = getProperty('popup'..i..'.height');
			local mouseX = getMouseX('ui');
            local mouseY = getMouseY('ui');

			if (mouseX - popupX) >= 0 and (mouseX - popupX) <= popupWidth and (mouseY - popupY) >= 0 and (mouseY - popupY) <= popupHeight and windowChecks[i] == true then
                doTweenX("popupCloseX"..i, 'popup'..i..'.scale', 0.95, 0.1, 'linear')
                doTweenY("popupCloseY"..i, 'popup'..i..'.scale', 0.95, 0.1, 'linear')
                doTweenAlpha("popupCloseAlpha"..i, 'popup'..i, 0, 0.1, 'linear')
                windowChecks[i] = false
                setProperty('lossMultiplier', getProperty("lossMultiplier") - windowHealth[i]);
			end
		end

        for i = 1,xpCount do
			local xpX = getProperty('popupXP'..i..'.x'); 
            local xpY = getProperty('popupXP'..i..'.y');
            local xpWidth = getProperty('popupXP'..i..'.width');
            local xpHeight = getProperty('popupXP'..i..'.height');
			local mouseX = getMouseX('ui');
            local mouseY = getMouseY('ui');

			if (mouseX - xpX) >= 0 and (mouseX - xpX) <= xpWidth and (mouseY - xpY) >= 0 and (mouseY - xpY) <= xpHeight and xpChecks[i] == true then
                xpChecks[i] = false
                removeLuaSprite('popupXP'..i, false)
                setProperty('lossMultiplier', getProperty("lossMultiplier") - xpHealth[i]);
			end
		end
	end
end


local scrambleCount = 1
local thing = {'DEATH', 'DOG', 'SARAH', 'SMILE', 'SPREADTHEWORD'};
local scrambleProperties = {
    {4,300,-300,250,-550},
    {2,-60,0,-460,0},
    {1,-50,350,-350,370},
    {3,700,300,1000,350},
    {5,200,450,150,700},
    {1,700,-100,960,-300},
    {4,800,250,1000,325},
    {3,200,-300,0,-500},
    {2,300,530,400,750}
}
--local thingString = '';

function onEvent(eventName, value1, value2)
    if eventName == '' then
        if value1 == 'polaroid' then
            doTweenAlpha("polaroid1", "polaroid", 1, 22.3, 'linear')
            doTweenX("polaroidX", "polaroid.scale", 1, 22.6, 'linear')
            doTweenY("polaroidY", "polaroid.scale", 1, 22.6, 'linear')
        end
        if value1 == 'catchthisfade' then
            for i = 4,7 do
                noteTweenAlpha('notes'..i, i, 1, 11.25, 'linear')
            end
            doTweenAlpha("huds", "uiGroup", 1, 11.20, 'linear')
            doTweenAlpha("p1fade", "_customP1Bar", 1, 11.05, 'linear')
            doTweenAlpha("p2fade", "_customP2Bar", 1, 11.05, 'linear')
            doTweenAlpha("framefade", "windowFrame", 1, 11.05, 'linear')
            doTweenAlpha("p1icon", "iconP1", 1, 11.05, 'linear')
            doTweenAlpha("p2icon", "iconP2", 1, 11.05, 'linear')
        end
        if value1 == 'demon' then
            setProperty('polaroid.alpha',0.00001)
            setProperty('uiGroup.alpha',0)
            setProperty('_customP1Bar.alpha',0)
            setProperty('_customP2Bar.alpha',0)
            setProperty('windowFrame.alpha',0)
            setProperty('iconP1.alpha',0)
            setProperty('iconP2.alpha',0)
            for i = 0,3 do
                setPropertyFromGroup('playerStrums', i, 'visible', false)
            end
        end
        if value1 == 'transition' then
            removeLuaSprite('polaroid',true)
            setProperty('black.visible',false)
            setProperty('uiGroup.alpha',1)
            setProperty('_customP1Bar.alpha',1)
            setProperty('_customP2Bar.alpha',1)
            setProperty('windowFrame.alpha',1)
            setProperty('iconP1.alpha',1)
            setProperty('iconP2.alpha',1)
            for i = 0,3 do
                setPropertyFromGroup('playerStrums', i, 'visible', true)
            end
            cameraFlash("camUI", '000000', 1, true)
        end

        if value1 == '0' then
            --c_y = 1080
            setProperty('uiGroup.alpha',0)
            for i = 0,3 do
                setPropertyFromGroup('playerStrums', i, 'alpha', 0)
            end
            setProperty('black.visible',true)
        end

        if value1 == '1' then
            doTweenAlpha("blackin", "black", 0, 0.5, 'cubeInOut')  
            setProperty("camUI.zoom", 0.667)
            setProperty("camFilter.zoom", 0.667)
        end

        if value1 == 'suspensefirst' then
            doTweenZoom('suspense', 'camUI', 0.73, 1, 'cubeInOut')
        end

        if value1 == 'slamfirst' then
            doTweenZoom('SLAM', 'camUI', 0.667, 0.5, 'elasticOut')
            removeLuaSprite("black", true)
            setObjectCamera('dadGroup', 'camUI')
            setCharacterX('dad', 0)
            setCharacterY('dad',0)
            doTweenAlpha("hudli", "uiGroup", 1, 0.5, 'cubeInOut')
            for i = 4,7 do
                noteTweenAlpha('notesli'..i, i, 1, 0.5, 'linear')
            end
        end

        if value1 == '2' then
            for i = 1,windowCount do
                if windowChecks[i] == true then
                    windowChecks[i] = false
                    removeLuaSprite('popup'..i, false)
                    setProperty('lossMultiplier', getProperty("lossMultiplier") - windowHealth[i]);
                end
            end
            --setProperty("camUI.zoom", 0.467)
            setObjectCamera('boyfriendGroup', 'camUI')
            setCharacterX('dad', 0)
            setCharacterY('dad', 0)
            setCharacterX('boyfriend', 800)
            setCharacterY('boyfriend', 0)
        end
        
        if value1 == 'suspensefinal' then
            doTweenZoom('suspense', 'camUI', 0.73, 1, 'cubeInOut')
            setCharacterX('dad', 0)
            setCharacterY('dad',0)
        end

        if value1 == '5' then
            doTweenZoom('SLAM', 'camUI', 0.667, 0.5, 'elasticOut')
            --setProperty("camUI.zoom", 0.467)
            setObjectCamera('boyfriendGroup', 'camGame')
    
            for i = 1,windowCount do
                if windowChecks[i] == true then
                    windowChecks[i] = false
                    removeLuaSprite('popup'..i, false)
                    setProperty('lossMultiplier', getProperty("lossMultiplier") - windowHealth[i]);
                end
            end
    
            for i = 1,xpCount do
                if xpChecks[i] == true then
                    xpChecks[i] = false
                    removeLuaSprite('popupXP'..i, false)
                    setProperty('lossMultiplier', getProperty("lossMultiplier") - xpHealth[i]);
                end
            end
        end
    end
	if eventName == 'Popup' then    
        if value1 == 'scramble' then
            scrambleCount = 1
            runTimer('scrambling', value2,scrambleProperties[#scrambleProperties]);
        elseif value1 == 'fatdog' then
            expandPopups();
        elseif value1 == 'xp' then
            xppopup(value2)
        else
            popup(value2)
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'scrambling' then
        --thingString = thing[getRandomInt(1, 5)];
        makeLuaSprite('scramblePopup'..scrambleCount, 'stages/smile/windows/'..thing[scrambleProperties[scrambleCount][1]], scrambleProperties[scrambleCount][2], scrambleProperties[scrambleCount][3])
        setProperty('scramblePopup'..scrambleCount..'.alpha', 0);
        setObjectCamera('scramblePopup'..scrambleCount, 'camUI'); 
        addLuaSprite('scramblePopup'..scrambleCount, true)
        scaleObject('scramblePopup'..scrambleCount, 0.95, 0.95,false)
    
        doTweenX("scrambleScaleX"..scrambleCount, 'scramblePopup'..scrambleCount..'.scale', 1, 0.1, 'linear')
        doTweenY("scrambleScaleY"..scrambleCount, 'scramblePopup'..scrambleCount..'.scale', 1, 0.1, 'linear')
        doTweenAlpha("scrambleAlpha"..scrambleCount, 'scramblePopup'..scrambleCount, 1, 0.1, 'linear')
        
        scrambleCount = scrambleCount + 1
    end
    
    if tag == 'flicker' then
        for i = 1,scrambleCount do
            if getProperty('scramblePopup'..i..'.visible') == true then
                setProperty('scramblePopup'..i..'.visible', false);
            else
                setProperty('scramblePopup'..i..'.visible', true);
            end

            if loopsLeft == 0 then
                for i = 1,scrambleCount do
                    removeLuaSprite('scramblePopup'..i, false)
                end
            end
        end
    end
end

--Remind me to translate this to source - Breezy

function onTweenCompleted(tag)
    if tag == 'scrambleX1' then
        runTimer('flicker', 0.05, 7)
    end

    for i = 1,windowCount do
        if tag == 'popupCloseAlpha'..i then
            removeLuaSprite('popup'..i, false)
        end
    end
end

function expandPopups()
    for i = 1,scrambleCount do
        doTweenX("scrambleX"..i, 'scramblePopup'..i, scrambleProperties[i][4], 0.25, 'backOut')
        doTweenY("scrambleY"..i, 'scramblePopup'..i, scrambleProperties[i][5], 0.25, 'backOut')
    end
end

function popup(value)
    windowString = windows[getRandomInt(1, 5)];
	makeLuaSprite('popup'..windowCount, 'stages/smile/windows/'..windowString, getRandomInt(0, 1350), getRandomInt(-120, 620))
    setProperty('popup'..windowCount..'.alpha', 0);
    setSpriteOffset('popup'..windowCount,getProperty('popup'..windowCount..'.frameWidth') - 45,0)
    setObjectCamera('popup'..windowCount, 'camUI'); 
    addLuaSprite('popup'..windowCount, true)
    setSpriteSize('popup'..windowCount,45,29);
    scaleObject('popup'..windowCount, 0.95, 0.95,false)

    doTweenX("popupScaleX"..windowCount, 'popup'..windowCount..'.scale', 1, 0.1, 'linear')
    doTweenY("popupScaleY"..windowCount, 'popup'..windowCount..'.scale', 1, 0.1, 'linear')
    doTweenAlpha("popupAlpha"..windowCount, 'popup'..windowCount, 1, 0.1, 'linear')

    windowChecks[windowCount] = true
    windowHealth[windowCount] = value;
    setProperty('lossMultiplier', getProperty("lossMultiplier") + windowHealth[windowCount]);
    windowCount = windowCount + 1
end

function xppopup(value)
    xpString = xpWins[getRandomInt(1, 6)];
	makeLuaSprite('popupXP'..xpCount, 'stages/smile/windows/'..xpString, getRandomInt(0, 1350), getRandomInt(-120, 620))
    setProperty('popupXP'..xpCount..'.alpha', 0);
    setSpriteOffset('popupXP'..xpCount,getProperty('popupXP'..xpCount..'.frameWidth') - 5,5)
    setObjectCamera('popupXP'..xpCount, 'camUI'); 
    addLuaSprite('popupXP'..xpCount, true)
    setSpriteSize('popupXP'..xpCount,21,21);

    doTweenAlpha("xpAlpha"..xpCount, 'popupXP'..xpCount, 1, 0.1, 'linear')

    xpChecks[xpCount] = true
    xpHealth[xpCount] = value;
    setProperty('lossMultiplier', getProperty("lossMultiplier") + xpHealth[xpCount]);
    xpCount = xpCount + 1
end