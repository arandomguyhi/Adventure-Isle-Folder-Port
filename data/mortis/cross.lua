-- similar to the way i did in gorefield
-- John's cross color made by meloomazy again!!!1!11
local crossColor = 'bar'

luaDebugMode = true
function onCreate()
    addHaxeLibrary('FlxRect', 'flixel.math')

    for i = 1,2 do
        makeLuaSprite('cross'..i, 'healthbars/trinity/'..crossColor..'-p'..i, screenWidth-100, 150)
	    setObjectCamera('cross'..i, 'hud')
        scaleObject('cross'..i, 3, 3)
        updateHitbox('cross'..i)
        addLuaSprite('cross'..i)
    end
    setObjectOrder('cross1', getObjectOrder('cross2'))

    if shadersEnabled then
        initLuaShader('colorReplace')

        setSpriteShader('boyfriend', 'colorReplace')
        setShaderFloatArray('boyfriend', 'u_colorToReplace', {255 / 255, 216 / 255, 0 / 255})
    end
end

function onEvent(n,v1,v2)
    if n == 'Change Character' then
        if v2:find('john') and shadersEnabled then
            removeSpriteShader('boyfriend', 'colorReplace')
            setSpriteShader('boyfriend', 'colorReplace')
        end
    end
end

function onUpdate()
    local health = getHealth() / 2

    local johncrossCol
    if health > 0.89 then -- eu tenho a leve impressão de que é aqui
        crossColor = 'bar'
        johncrossCol = {255 / 255, 216 / 255, 0 / 255}
    elseif health > 0.6 then
        crossColor = 'silver'
        johncrossCol = {255 / 255, 255 / 255, 255 / 255}
    else
        crossColor = 'bronze'
        johncrossCol = {179 / 255, 90 / 255, 1 / 255}
    end
    if boyfriendName:find('john') and shadersEnabled then
        setShaderFloatArray('boyfriend', 'u_replacementColor', johncrossCol)
    end

    for i = 1,2 do
        loadGraphic('cross'..i, 'healthbars/trinity/'..crossColor..'-p'..i, false)
    end

    runHaxeCode([[
        var cross = game.getLuaObject('cross1');
        var barHeight:Int = Std.int((game.health / 2) * cross.height);

        cross.clipRect = new FlxRect(0, cross.height - barHeight, cross.width, barHeight);
    ]])
end