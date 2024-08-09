function onCreate() 
    setProperty('skipCountdown',true)
    setProperty('camHUD.alpha', 0);
end

function onSongStart()
    doTweenAlpha("readdHUD", "camHUD", 1, 5, 'sineInOut')
	doTweenZoom('zoomTween3', 'camGame', 1.5, 5, 'sineInOut')
    for i = 0,3 do
		setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
		setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)
		setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)
		setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)
		setPropertyFromGroup('opponentStrums', 0, 'alpha', 0)
		setPropertyFromGroup('opponentStrums', 1, 'alpha', 0)
		setPropertyFromGroup('opponentStrums', 2, 'alpha', 0)
		setPropertyFromGroup('opponentStrums', 3, 'alpha', 0)
	end
	runTimer('BZL', 3)
end

function onStepHit()
	if curStep == 1648 then
		for i = 0,3 do
			setPropertyFromGroup('playerStrums', i, 'alpha', 0)
		end
	end
	if curStep == 1704 then
		noteTweenX("moveback1", 4,defaultPlayerStrumX0, 1.0, "sineInOut")
		noteTweenX("moveback2", 5,defaultPlayerStrumX1, 1.0, "sineInOut")
		noteTweenX("moveback3", 6,defaultPlayerStrumX2, 1.0, "sineInOut")
		noteTweenX("moveback4", 7,defaultPlayerStrumX3, 1.0, "sineInOut")
		for i = 4,7 do
			noteTweenAlpha("reappear"..i, i,1, 4.0, "sineInOut")
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'BZL' then
		for i, cu in pairs({'ipc', 'topphoto', 'ibg'}) do
			doTweenColor('coltwn'..i, cu, '000000', 3)
		end
	end
end