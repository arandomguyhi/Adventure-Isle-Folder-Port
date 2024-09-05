function onCreatePost()
    for i = 0,3 do
	setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX'..i])
	setPropertyFromGroup('opponentStrums', i, 'visible', false)
    end
end

function onSpawnNote()
    for i = 0, getProperty('notes.length')-1 do
	if not getPropertyFromGroup('notes', i, 'mustPress') then
	    setPropertyFromGroup('notes', i, 'visible', false)
	end
    end
end