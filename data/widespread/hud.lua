addHaxeLibrary('FlxRect', 'flixel.math')

luaDebugMode = true
function onCreate()
    makeLuaSprite('spreadBarP2', 'healthbars/spread/staticog-p2', 0, 630)
    setObjectCamera('spreadBarP2', 'hud')
    screenCenter('spreadBarP2', 'X')
    addLuaSprite('spreadBarP2')

    makeLuaSprite('spreadBarP1', 'healthbars/spread/staticog-p1', 0, 630)
    setObjectCamera('spreadBarP1', 'hud')
    screenCenter('spreadBarP1', 'X')
    addLuaSprite('spreadBarP1')

    makeAnimatedLuaSprite('sarahIcon', 'icons/icon-smile-player', 960, getProperty('iconP2.y'))
    addAnimationByPrefix('sarahIcon', 'healthy', 'sd player girl healthy icon0', 24, true)
    addAnimationByPrefix('sarahIcon', 'hurt', 'sd player girl hurt icon0', 24, true)
    addAnimationByPrefix('sarahIcon', 'to healthy', 'sd player girl to healthy icon0', 24, false)
    addAnimationByPrefix('sarahIcon', 'to hurt', 'sd player girl to hurt icon0', 24, false)
    playAnim('sarahIcon', 'healthy')
    setObjectCamera('sarahIcon', 'hud')
    addLuaSprite('sarahIcon')
    setProperty('sarahIcon.flipX', true)

    makeAnimatedLuaSprite('dogIcon', 'icons/icon-smile-dog', 180, getProperty('iconP1.y'))
    addAnimationByPrefix('dogIcon', 'healthy', 'smile dog healthy icon0', 24, true)
    addAnimationByPrefix('dogIcon', 'hurt', 'smile dog hurt icon0', 24, true)
    addAnimationByPrefix('dogIcon', 'to healthy', 'smile dog to healthy icon0', 24, false)
    addAnimationByPrefix('dogIcon', 'to hurt', 'smile dog to hurt icon0', 24, false)
    playAnim('dogIcon', 'healthy')
    setObjectCamera('dogIcon', 'hud')
    addLuaSprite('dogIcon')

    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('timeBar.visible', false) setProperty('timeTxt.visible', false)
    setProperty('healthBar.visible', false) setProperty('healthBar.bg.visible', false)
    setProperty('iconP1.visible', false) setProperty('iconP2.visible', false)

    setTextFont('scoreTxt', 'goodbyeDespair.ttf')
end

local isHurt = false
local isDogHurt = false
function onUpdatePost()
    if getHealth() < 0.4 and not isHurt then
        playAnim('sarahIcon', 'to hurt')
        isHurt = true
    elseif getHealth() > 0.4 and isHurt then
        playAnim('sarahIcon', 'to healthy')
        isHurt = false
    end

    if getHealth() > 1.6 and not isDogHurt then
        playAnim('dogIcon', 'to hurt')
        isDogHurt = true
    elseif getHealth() < 1.6 and isDogHurt then
        playAnim('dogIcon', 'to healthy')
        isDogHurt = false
    end

    for _, icons in pairs({'sarahIcon', 'dogIcon'}) do
        if getProperty(icons..'.animation.curAnim.name') == 'to hurt' and
        getProperty(icons..'.animation.curAnim.finished') then
            playAnim(icons, 'hurt', true)
        end
        if getProperty(icons..'.animation.curAnim.name') == 'to healthy' and
        getProperty(icons..'.animation.curAnim.finished') then
            playAnim(icons, 'healthy', true)
        end
    end

    runHaxeCode([[
        var sBP1 = game.getLuaObject('spreadBarP1');
        var barWidth:Int = Std.int((game.health / 2) * sBP1.width);

        sBP1.clipRect = new FlxRect(sBP1.width - barWidth, 0, barWidth, sBP1.height);
    ]])
end

function onBeatHit()
    local elapsed = getPropertyFromClass('flixel.FlxG', 'elapsed')

    for i, icons in pairs({'sarahIcon', 'dogIcon'}) do
        scaleObject(icons, 1, 1)
        startTween('iconsTwn'..i, icons..'.scale', {x = 0.85, y = 0.85}, crochet/1000 - elapsed, {ease = 'expoOut'})
    end
end

function goodNoteHit(i,d,t,s)
    if not s then addHealth(.02)end
end

function opponentNoteHit(i,d,t,s)
    if not s then
        addHealth((getHealth() > 0.1) and -.02 or 0)
    end
end