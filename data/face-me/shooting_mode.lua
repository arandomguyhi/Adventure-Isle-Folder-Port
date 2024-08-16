local dogPath = 'characters/duck_season/'

luaDebugMode = true
function onCreate()
    for i = 1,2 do -- testing with 2 sprites for now
        makeAnimatedLuaSprite('dogFront'..i, dogPath..'Dog_Shadow_Laugh')
        addAnimationByPrefix('dogFront'..i, 'idle', 'Dog Shadow Laugh instance 1', 24, true)
        addAnimationByPrefix('dogFront'..i, 'throw', 'Dog Laugh Shadow Throw instance 1', 24, false)
        setProperty('dogFront'..i..'.antialiasing', false) -- to optimize a bit
        addLuaSprite('dogFront'..i, true)

        makeAnimatedLuaSprite('dogLeft'..i, dogPath..'Dog_Shadow_Wave')
        addAnimationByPrefix('dogLeft'..i, 'idle', 'Dog shadow wave instance 1', 24, true)
        addAnimationByPrefix('dogLeft'..i, 'throw', 'Dog Shadow wave throw instance 1', 24, false)
        setProperty('dogLeft'..i..'.antialiasing', false)
        addLuaSprite('dogLeft'..i, true)

        makeAnimatedLuaSprite('dogRight'..i, dogPath..'Dog_Shadow')
        addAnimationByPrefix('dogRight'..i, 'idle', 'Dog shadow Idle instance 1', 24, true)
        addAnimationByPrefix('dogRight'..i, 'throw', 'Dog Shadow Throw instance 1', 24, false)
        setProperty('dogRight'..i..'.antialiasing', false)
        addLuaSprite('dogRight'..i, true)
    end
end

function onEvent(name, value1, value2)
    if name == 'DogSpawn' then

    end
end