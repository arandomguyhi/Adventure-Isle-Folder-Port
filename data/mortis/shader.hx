// easy as helll

if (buildTarget == 'android'){ return; }
var bzl;
function onCreate() {
    game.initLuaShader('vcr');
    bzl = game.createRuntimeShader('vcr');
    camGame.filters = camHUD.filters = [new ShaderFilter(bzl)];
}