luaDebugMode = true
function onCreate()
    makeLuaSprite('topBar', nil, 0, -350)
    makeGraphic('topBar', screenWidth, 350, '000000')
    addLuaSprite('topBar')

    makeLuaSprite('bottomBar', nil, 0, 720)
    makeGraphic('bottomBar', screenWidth, 350, '000000')
    addLuaSprite('bottomBar')

    -- camera for hud elements (bars in this case)
    runHaxeCode([[
        var pedro = new FlxCamera();
        pedro.bgColor = 0x00;
        setVar('pedroCam', pedro);

        FlxG.cameras.remove(game.camHUD, false);
        FlxG.cameras.remove(game.camOther, false);

        for (cams in [pedro, game.camHUD, game.camOther])
            FlxG.cameras.add(cams, false);

        game.getLuaObject('topBar').camera = pedro;
        game.getLuaObject('bottomBar').camera = pedro;
    ]])

    topY, bottomY = getProperty('topBar.y'), getProperty('bottomBar.y')
end

function onEvent(name, value1, value2)
    if name == 'ChangeBarSize' then
        doTweenY('topTween', 'topBar', topY + value2*2, value1, 'quintIn')
        doTweenY('bottomTween', 'bottomBar', bottomY - value2*2, value1, 'quintIn')
    end
end