local videoPath = callMethodFromClass('backend.Paths', 'video', {'mortis'})

function onCreate()
	addHaxeLibrary('FlxVideo', 'hxcodec.flixel')

	if buildTarget == 'windows' then
		-- nada
	else
		createInstance('endCutscene', 'backend.VideoSpriteManager', {'0', '0', '1280', '720'})
		setObjectCamera('endCutscene', 'camHUD')
		scaleObject('endCutscene', 1.3, 1.3)
		addInstance('endCutscene', true)
	end
end

function onStepHit()
	if curStep == 4288 then
		if buildTarget == 'windows' then
			makeVideoSprite('mortisEnd', 'mortis', 0, 0, 'camHUD', false)
		else
			callMethod('endCutscene.startVideo', {videoPath, false})
		end
		setProperty('blackGraphic.alpha', 1)
	end
end
