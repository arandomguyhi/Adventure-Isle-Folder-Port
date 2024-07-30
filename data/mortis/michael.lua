function onCreate()
    createInstance('michael', 'objects.Character', {-60.5, 18, 'michael-kr'})
    setProperty('michael.alpha', 0.001)
    addInstance('michael')
end

function onSpawnNote(i,d,t,s)
    if t == 'Second Opponent Sing' then
        setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
    end
end

function opponentNoteHit(i,d,t,s)
    if t == 'Second Opponent Sing' then
        playAnim('michael', getProperty('singAnimations')[d+1], true)
        setProperty('michael.holdTimer', 0)
    end
end

function onUpdate()
    runHaxeCode([[
        var michael = game.getLuaObject('michael');
        if (!michael.stunned && michael.holdTimer > Conductor.stepCrochet * 0.0011 * michael.singDuration && StringTools.startsWith(michael.animation.curAnim.name, 'sing')){
            michael.dance();
        }
    ]])
end