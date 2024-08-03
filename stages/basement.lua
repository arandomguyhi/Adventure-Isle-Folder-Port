setProperty('isCameraOnForcedPos', true)

local imgPath = 'stages/basement/'

luaDebugMode = true
function onCreate()
    runHaxeCode([[
        FlxG.mouse.visible = true;
        FlxG.mouse.load(Paths.image('mouse/mouse_hover').bitmap);
    ]])

    initLuaShader('green')
    initLuaShader('greenScreen')

    makeLuaSprite('firstRoom', imgPath..'0/litup', 0, 0)
    addLuaSprite('firstRoom')

    makeLuaSprite('firstRoomDark', imgPath..'0/unlitup', 0, 0)
    addLuaSprite('firstRoomDark')
    setSpriteShader('firstRoomDark', 'green')
end

function onCreatePost()
    setProperty('boyfriend.alpha', 0.001)
    setProperty('camFollow.x', getProperty('camFollow.x')+35)

    makeLuaSprite('flashlightRadius', imgPath..'flashlight_radius', 0, 0)
    setObjectOrder('flashlightRadius', getObjectOrder('dadGroup')+1)
    addLuaSprite('flashlightRadius')
    --setProperty('flashlightRadius.alpha', 0.001)
    setSpriteShader('flashlightRadius', 'greenScreen')

    setObjectOrder('gfGroup', getObjectOrder('flashlightRadius'))
end

function onSongStart()
    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'visible', false)
    end
end

function onSpawnNote()
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'visible', false)
    end
end

function onUpdate()
    setProperty('flashlightRadius.x', getMouseX('camGame')-getProperty('flashlightRadius.width')/2)
    setProperty('flashlightRadius.y', getMouseY('camGame')-getProperty('flashlightRadius.height')/2)
    --[[setProperty('flashlightHitbox.x', getMouseX('camGame')-getProperty('flashlightHitbox.width')/2)
    setProperty('flashlightHitbox.y', getMouseY('camGame')-getProperty('flashlightHitbox.height')/2)

    setProperty('flashlight.x', getProperty('flashlightRadius.x'))
    setProperty('flashlight.y', getProperty('flashlightRadius.y'))]]
end