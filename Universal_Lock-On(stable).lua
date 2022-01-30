--[[
    settings = {
        ["State"] = false;
        ["key"] = "B";
        ["Part"] = "Head";
        ["Mode"] = "Switch";
        ["TeamCheck"] = true;
        ["Distance"] = 500;
    };
]]

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sypse/UILibraries/main/uwuware.lua'))();
local Main = library:CreateWindow("Lock-On: Sypse#6005");
local camera, plr = Workspace.CurrentCamera, game:GetService("Players").LocalPlayer;
local mouse, rs = plr:GetMouse(), game:GetService("RunService").RenderStepped;
local step;


local closestplr;
local function getplrposition()
    local closestpos = math.huge;
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character and v ~= game.Players.LocalPlayer then
            if not ((settings.TeamCheck) and (v.Team == nil or v.Team == game.Players.LocalPlayer.Team)) then
                pcall(function()
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude < settings.Distance then
                        local mag = (mouse.Hit.p - v.Character.HumanoidRootPart.CFrame.Position).Magnitude;
                        if mag < closestpos then
                            closestplr = v;
                            closestpos = mag;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;


local function loop()
    getplrposition();
    step = rs:connect(function()
        if settings.Mode == "Switch" then getplrposition(); end;
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - closestplr.Character.HumanoidRootPart.Position).magnitude < settings.Distance then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closestplr.Character[settings.Part].CFrame.Position);
        end;
    end);
end;


Main:AddList({text = "Mode", value = settings.Mode, values = {"Single", "Switch"}, callback = function(a)
    settings.Mode = a;
end});


Main:AddList({text = "Part", value = settings.Part, values = {"Head", "HumanoidRootPart"}, callback = function(a)
    settings.Part = a;
end});

Main:AddSlider({text = "Distance Slider", value = settings.Distance, min = 0, max = 99999, callback = function(a)
    settings.Distance = a;
end})

Main:AddToggle({text = "Team Check", state = settings.TeamCheck, callback = function(a)
    settings.TeamCheck = a;
end});

Main:AddBind({text = "Keybind", key = settings.key, callback = function()
    settings.State = not settings.State;
    if settings.State then
        loop();
    else
        step:Disconnect();
    end;
end});



library:Init();
