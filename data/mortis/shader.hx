// easy as helll

var bzl;
function onCreate() {
    game.initLuaShader('vcr');
    bzl = game.createRuntimeShader('vcr');
    camGame.filters = camHUD.filters = [new ShaderFilter(bzl)];
}