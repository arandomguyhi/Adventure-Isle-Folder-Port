-- like the way i did in gorefield

local crucifixColor = 'bar'

luaDebugMode = true
function onCreate()
    addHaxeLibrary('FlxRect', 'flixel.math')

    for i = 1,2 do
        makeLuaSprite('crucifix'..i, 'healthbars/trinity/'..crucifixColor..'-p'..i, screenWidth-100, 150)
        setObjectCamera('crucifix'..i, 'hud')
        scaleObject('crucifix'..i, 3, 3)
        updateHitbox('crucifix'..i)
        addLuaSprite('crucifix'..i)
    end
    setObjectOrder('crucifix1', getObjectOrder('crucifix2'))
end

function onUpdate()
    local health = getHealth() / 2

    if health > 0.89 then -- eu tenho a leve impressão de que é aqui
        crucifixColor = 'bar'
    elseif health > 0.6 then
        crucifixColor = 'silver'
    else
        crucifixColor = 'bronze'
    end

    for i = 1,2 do
        loadGraphic('crucifix'..i, 'healthbars/trinity/'..crucifixColor..'-p'..i, false)
    end

    runHaxeCode([[
        var crucifix = game.getLuaObject('crucifix1');
        var barHeight:Int = Std.int((game.health / 2) * crucifix.height);

        crucifix.clipRect = new FlxRect(0, crucifix.height - barHeight, crucifix.width, barHeight);
    ]])
end