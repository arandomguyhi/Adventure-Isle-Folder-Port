addHaxeLibrary('FlxRect', 'flixel.math')

luaDebugMode = true
function onCreate()
    makeLuaSprite('base', 'healthbars/duck/base', 0, 609.5)
    setObjectCamera('base', 'hud')
    scaleObject('base', 0.5, 0.5)
    screenCenter('base', 'X')
    addLuaSprite('base')

    makeLuaSprite('duckBarP2', 'healthbars/duck/duck-p2', 0, 630)
    setObjectCamera('duckBarP2', 'hud')
    scaleObject('duckBarP2', 0.51, 0.51)
    screenCenter('duckBarP2', 'X')
    addLuaSprite('duckBarP2')

    makeLuaSprite('duckBarP1', 'healthbars/duck/duck-p1', 0, 630)
    setObjectCamera('duckBarP1', 'hud')
    scaleObject('duckBarP1', 0.51, 0.51)
    screenCenter('duckBarP1', 'X')
    addLuaSprite('duckBarP1')

    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('uiGroup.visible', false)

    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'visible', false)
    end
end

local isHurt = false
local isDogHurt = false
function onUpdatePost()
    runHaxeCode([[
        var scaleValue = 1.9608;
        var duckBar = game.getLuaObject('duckBarP1');
        var barWidth:Int = Std.int((game.health / 2) * duckBar.width*scaleValue);

        duckBar.clipRect = new FlxRect(duckBar.width*scaleValue - barWidth, 0, barWidth, duckBar.height*scaleValue);
    ]])
end

function goodNoteHit(i,d,t,s)
    if not s then addHealth(.02)end
end

function onSpawnNote()
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'visible', false)
    end
end