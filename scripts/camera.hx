// BZL
import flixel.FlxCamera;

var uiCam:FlxCamera;

function onCreate(){
    FlxG.cameras.remove(game.camHUD, false);
    FlxG.cameras.remove(game.camOther, false);
    uiCam = new FlxCamera();
    uiCam.bgColor = 0x00;
    FlxG.cameras.add(uiCam, false);
    FlxG.cameras.add(game.camHUD, false);
    FlxG.cameras.add(game.camOther, false);

    setVar('uiCam', uiCam);
}

function onCreatePost(){
    game.getLuaObject('topBar').camera = uiCam;
    game.getLuaObject('bottomBar').camera = uiCam;
}