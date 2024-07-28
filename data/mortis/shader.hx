// easy as helll

function onCreate() {
    game.initLuaShader('vcr');
    var vcrShader = game.createRuntimeShader('vcr');
    camGame.filters = camHUD.filters = [new ShaderFilter(vcrShader)];
}