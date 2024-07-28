luaDebugMode = true
function onCreate()
    makeLuaSprite('topBar', nil, 0, -350)
    makeGraphic('topBar', screenWidth, 350, '000000')
    setObjectCamera('topBar', 'camHUD')
    addLuaSprite('topBar')

    makeLuaSprite('bottomBar', nil, 0, 720)
    makeGraphic('bottomBar', screenWidth, 350, '000000')
    setObjectCamera('bottomBar', 'camHUD')
    addLuaSprite('bottomBar')

    topY, bottomY = getProperty('topBar.y'), getProperty('bottomBar.y')
end

function onEvent(name, value1, value2)
    if name == 'ChangeBarSize' then
        doTweenY('topTween', 'topBar', topY + value2*2, value1, 'quintIn')
        doTweenY('bottomTween', 'bottomBar', bottomY - value2*2, value1, 'quintIn')
    end
end