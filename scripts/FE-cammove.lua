-- hypno/forever cam move script by Breezy
--- @version 0.1.0
local zoom = 1;
local customPlrZoom = 1.5

local extent = 5;

local camPos,camExtend;
local camZooming = true;

setVar('camZoom', 0)

-- settings is Global!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function onCreatePost()
    if songName == 'Mortis' then
        extent = 3;
    end
end

function onUpdate(elapsed)
    --cam zooms depending on which character
    if camZooming == true then
        if mustHitSection == false then
            if dadName == 'smiledog-tv' then
                zoom = 1;
            end
    
            if dadName == 'dog1' then
                zoom = 1.5;
            end

            if dadName == 'dog2' then
                zoom = 1.1;
            end

            if dadName == 'NBAdrakelikesyoungboys' then
                zoom = 0.6;       
            end

            --Yume Nikki

            if dadName == 'monoe' then
                zoom = 0.65;
            end

            if dadName == 'monoko' then
                zoom = 0.80;
            end

            if dadName == 'monoko-broom' then
                zoom = 0.55;
            end

            if dadName == 'poniko' then
                zoom = 0.52;
            end
            
            if dadName == 'poniko-bike' then
                zoom = 0.55;
            end

            if dadName == 'uboa' then
                zoom = 1.30;
            end

            --Faith

            if dadName == 'amy-1' then
                zoom = 4.6;
            end

            if dadName == 'amy-2' then
                zoom = 4.6;
            end

            if dadName == 'amy-3' then
                zoom = 3.8;
            end

            if dadName == 'michael-ban' then
                zoom = 3.4;       
            end

            if dadName == 'michael-tilted' then
                zoom = 4.6;       
            end

            if dadName == 'michael-2' then
                zoom = 3.5;       
            end

            if dadName == 'amy-kr' then
                zoom = 2.1;   
            end

            if dadName == 'amy-ban' then
                zoom = 6;    
            end

            if dadName == 'mama-front' then
                zoom = 1.1;
            end

            if dadName == 'mama-far' then
                zoom = 1.1;
            end

        else
            if boyfriendName == 'sarah_1' then
                zoom = 0.750;       
            end

            if boyfriendName == 'sarah_fp' then
                zoom = customPlrZoom;       
            end

            if boyfriendName == 'evilkaru' then
                zoom = 0.9;       
            end

            --yume nikki

            if boyfriendName == 'mado-walk' then
                zoom = 0.45;
            end

            if boyfriendName == 'mado-monoko' then
                zoom = 0.925;
            end

            if boyfriendName == 'mado-pixel' then
                zoom = 0.65;
            end

            if boyfriendName == 'mado-broom' then
                zoom = 0.55;
            end

            if boyfriendName == 'mado-poniko' then
                zoom = 0.65;
            end

            if boyfriendName == 'mado-bike' then
                zoom = 0.55;
            end

            if boyfriendName == 'mado-uboa' then
                zoom = 0.80;
            end

            if boyfriendName == 'mado-end' then
                zoom = 0.90;
            end

            --faith

            if boyfriendName == 'john-1' then
                zoom = 3.4;       
            end

            if boyfriendName == 'john-hardstyle' then
                zoom = 5;       
            end

            if boyfriendName == 'john-ban' then
                zoom = 3.4;       
            end

            if boyfriendName == 'john-tilted' then
                zoom = 4.2;       
            end

            if boyfriendName == 'garcia-1' then
                zoom = 3.5;       
            end

            if boyfriendName == 'john-kr' then
                zoom = 2.1;    
            end

            if boyfriendName == 'john-exorcist' then
                zoom = 5;    
            end

            if boyfriendName == 'ruby-front' then
                zoom = 1.1;
            end

            if boyfriendName == 'ruby-far' then
                zoom = 1.1;
            end
        end 
    end
end

function onStepHit()
    if songName == 'Face Me' then
        if curStep == 640 or curStep == 1152 or curStep == 1408 then
            camZooming = false;
            runHaxeCode([[
                game.stages[0].shootingmode = true;
            ]])
        end

        if curStep == 880 or curStep == 1200 or curStep == 1648 then
            camZooming = true;
            runHaxeCode([[
                game.stages[0].shootingmode = false;
            ]])
        end
    end

    if songName == 'Widespread' then
        if curStep == 1648 then
            camZooming = false;
        end

        if curStep == 1704 then
            camZooming = true;

            customPlrZoom = 0.8
        end
    end

    if songName == 'Deep Dream' then
        if curStep == 3968 then
            camZooming = false;
            doTweenZoom('zoomOut', 'camGame', 0.90, 3, 'quadInOut')
            
        end
    end

    if songName == 'Evilkaru' then
        if curStep == 759 then
            camZooming = false;
        end
    end

    if camZooming == true then
        setProperty('defaultCamZoom', zoom + getVar('camZoom'));            
    end
end

function onTweenCompleted(tag)
    if tag == 'zoomOut' then
        camZooming = true
    end
end

function onUpdatePost(e)
    if getProperty("isCameraOnForcedPos") then return end

    camExtend={0,0}
    for i = 0, 3 do
        if getPropertyFromGroup(mustHitSection and "playerStrums" or "opponentStrums", i, "animation.curAnim.name") == "confirm" then
            local offDir = (i == 0 or i == 2) and -1 or 1
            local dir = (i == 0 or i == 3) and 1 or 2
            if getProperty('isPixelStage') == true then
                camExtend[dir] = extent * offDir;
            else
                camExtend[dir] = extent * offDir;
            end
        end
    end
    setProperty("camFollow.x", camPos[1]+camExtend[1])
    setProperty("camFollow.y", camPos[2]+camExtend[2])
    setProperty('cameraSpeed', 2)
end

function onMoveCamera() camPos = {getProperty("camFollow.x"),getProperty("camFollow.y")} end