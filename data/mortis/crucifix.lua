-- like the way i did in gorefield
-- John's crucifix color made by meloomazy again!!!1!11
local crucifixColor = 'bar'

luaDebugMode = true
function onCreate()
    initLuaShader('colorReplace')
    addHaxeLibrary('FlxRect', 'flixel.math')

    for i = 1,2 do
        makeLuaSprite('crucifix'..i, 'healthbars/trinity/'..crucifixColor..'-p'..i, screenWidth-100, 150)
	    setObjectCamera('crucifix'..i, 'hud')
        scaleObject('crucifix'..i, 3, 3)
        updateHitbox('crucifix'..i)
        addLuaSprite('crucifix'..i)
    end
    setObjectOrder('crucifix1', getObjectOrder('crucifix2'))

    setSpriteShader('boyfriend', 'colorReplace')
    setShaderFloatArray('boyfriend', 'u_colorToReplace', {255 / 255, 216 / 255, 0 / 255})
end

function onEvent(n,v1,v2)
    if n == 'Change Character' then
        if v2:find('john') then
            removeSpriteShader('boyfriend', 'colorReplace')
            setSpriteShader('boyfriend', 'colorReplace')
        end
    end
end

function onUpdate()
    local health = getHealth() / 2

    local johnCrucifixCol
    if health > 0.89 then -- eu tenho a leve impressão de que é aqui
        crucifixColor = 'bar'
        johnCrucifixCol = {255 / 255, 216 / 255, 0 / 255}
    elseif health > 0.6 then
        crucifixColor = 'silver'
        johnCrucifixCol = {255 / 255, 255 / 255, 255 / 255}
    else
        crucifixColor = 'bronze'
        johnCrucifixCol = {179 / 255, 90 / 255, 1 / 255}
    end
    setShaderFloatArray('boyfriend', 'u_replacementColor', johnCrucifixCol)

    for i = 1,2 do
        loadGraphic('crucifix'..i, 'healthbars/trinity/'..crucifixColor..'-p'..i, false)
    end

    runHaxeCode([[
        var crucifix = game.getLuaObject('crucifix1');
        var barHeight:Int = Std.int((game.health / 2) * crucifix.height);

        crucifix.clipRect = new FlxRect(0, crucifix.height - barHeight, crucifix.width, barHeight);
    ]])
end