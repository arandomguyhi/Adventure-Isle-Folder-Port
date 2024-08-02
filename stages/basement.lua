setProperty('isCameraOnForcedPos', true)

luaDebugMode = true
function onCreatePost()
    setProperty('boyfriend.alpha', 0.001)
    setProperty('camFollow.x', getProperty('camFollow.x')+110)
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