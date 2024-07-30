local videoPath = callMethodFromClass('backend.Paths', 'video', {'mortis'})

function onCreate()
	addHaxeLibrary('FlxVideo', 'hxcodec.flixel')

	if buildTarget == 'windows' then
		makeLuaSprite('videoSprite_video', nil)
		screenCenter('videoSprite_video', 'XY')
		setScrollFactor('videoSprite_video', 0, 0)
		addLuaSprite('videoSprite_video', true)

		runHaxeCode([[
			var video:FlxVideo = new FlxVideo();
			video.alpha = 0.001;
			video.onTextureSetup.add(function()
			{
				game.getLuaObject('videoSprite_video').loadGraphic(video.bitmapData);
			});
			video.play(Paths.video('mortis'));
			video.onEndReached.add(function()
			{
				video.dispose();
				game.getLuaObject('videoSprite').destroy();
				game.getLuaObject('videoSprite').remove();
			});
			video.pause();

			FlxG.game.addChild(video);
			setVar('video', video);
		]])
	else
		createInstance('endCutscene', 'backend.VideoSpriteManager', {0, 0, screenWidth, screenHeight})
		setScrollFactor('endCutscene', 0, 0)
		addInstance('endCutscene', true)
	end
end

function onStepHit()
	if curStep == 4288 then
		if buildTarget == 'windows' then
			runHaxeCode([[
				var video = getVar('video');
				video.resume();
				if(game.paused) video.pause();
			]])
		else
			callMethod('endCutscene.startVideo', {videoPath, false})
		end
	end
end

function onResume()
	runHaxeCode("getVar('video').resume();")
end

function onDestroy()
	runHaxeCode("getVar('video').stop();")
end