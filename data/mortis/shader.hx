// easy as helll

if (buildTarget == 'windows'){/*oi*/}else{return;}
var bzl;
function onCreate() {
    game.initLuaShader('vcr');
    bzl = game.createRuntimeShader('vcr');
    camGame.filters = camHUD.filters = [new ShaderFilter(bzl)];
}