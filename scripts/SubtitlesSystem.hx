// made by meloomazy

import flixel.text.FlxText;
import flixel.text.FlxTextFormat;
import flixel.text.FlxTextFormatMarkerPair;
import tjson.TJSON;

using StringTools;

var subtit:FlxText;

var subSteps:Array<Array<Int>> = []; 
var subStrings:Array<String> = []; 
var currentSubtitleIndex:Int = 0;

function onCreate() {
    var path = Paths.getPath('data/' + Paths.formatToSongPath(game.songName.toLowerCase()) + '/subtitles.json', 'TEXT', null, true);
    if(FileSystem.exists(path)) {
        //debugPrint('subtitles exists bro!!'); // explodes
        var subData = TJSON.parse(File.getContent(path));
        for (s in subData.subtitles) {
            subSteps.push(s.steps);
            subStrings.push(s.curString);
        }
    }

    subtit = new FlxText(0, FlxG.height / 1.4, 1280, '', 15);
    subtit.setFormat(Paths.font('StepRightUp.ttf'), 22, FlxColor.WHITE, 'center');
    subtit.camera = camHUD;
    add(subtit);
    return;
}

// i might be stupid...
function onStepHit() {
    if (currentSubtitleIndex < subSteps.length) {
        var steps:Array<Int> = subSteps[currentSubtitleIndex];
        var curString:String = subStrings[currentSubtitleIndex];

        var stepIndex:Int = steps.indexOf(curStep);

        if (stepIndex != -1) {
            var words:Array<String> = curString.split('/');

            var markedUpText:String = '';
            for (i in 0...words.length) {
                if (i == stepIndex)
                    markedUpText += '#' + words[i] + '# ';
                else
                    markedUpText += words[i] + ' ';
            }
            subtit.applyMarkup(markedUpText.trim(), [new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.RED), '#')]);
        }

        if (curStep >= steps[steps.length - 1]) {
            if ((curString.contains('/') || steps.length == 2) && steps.length != curString.split('/').length) {
                subtit.text = '';
            }
            currentSubtitleIndex++;
        }
    }
    return;
}
