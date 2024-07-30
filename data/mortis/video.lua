local videoPath = callMethodFromClass('backend.Paths', 'video', {'mortis'})

function onCreate()
	addHaxeLibrary('FlxVideo', 'hxcodec.flixel')

	if buildTarget == 'windows' then
		-- nada
	else
		createInstance('endCutscene', 'backend.VideoSpriteManager', {0, 0, screenWidth, screenHeight})
		setObjectCamera('endCutscene', getVar('pedroCam'))
		addInstance('endCutscene', true)
	end
end

function onStepHit()
	if curStep == 4288 then
		if buildTarget == 'windows' then
			makeVideoSprite('mortisEnd', 'mortis', 0, 0, getVar('pedroCam'), false)
		else
			callMethod('endCutscene.startVideo', {videoPath, false})
		end
	end
end