local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sypse/UILibraries/main/uwuware.lua'))();
local Main = library:CreateWindow("Factory Simulator\nSypse#6005");
local plr = game.Players.LocalPlayer;

local worlds = {};
for i,v in pairs(game:GetService("Workspace").Harvestable:GetChildren()) do
    table.insert(worlds, v.Name);
end;

local selectedworld = game:GetService("Workspace").Harvestable.World;
Main:AddList({text = "Select World", value = "World", values = worlds, callback = function(a)
    selectedworld = game:GetService("Workspace").Harvestable..v;
end});


Main:AddButton({text = "Destroy Nearby Tree's", callback = function()
    for i,v in pairs(selectedworld:GetChildren()) do
        if (plr.Character.HumanoidRootPart.Position - v:FindFirstChildOfClass("Part").Position).Magnitude <= 200 then
            game:GetService("ReplicatedStorage").Events.Harvest.Harvest:FireServer(v);
        end;
    end;
end});


local pickup;
Main:AddToggle({text = "Auto Pickup", state = false, callback = function(a)
    pickup = a;
    if a then
        repeat wait(.2)
            for i,v in pairs(game:GetService("Workspace").Plots:GetChildren()) do
                if v:FindFirstChild("Owner") then
                    if tostring(v.Owner.Value) == tostring(game.Players.LocalPlayer.Name) then
                        for i,v in pairs(v.Entities:GetChildren()) do
                            wait(.2)
                            game:GetService("ReplicatedStorage").Events.Inventory.PickUp:FireServer(v);
                        end;
                    end;
                end;
            end;
        until not pickup;
    end;
end});

library:Init();
