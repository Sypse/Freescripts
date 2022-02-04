local camera = workspace.CurrentCamera;
local image = Drawing.new("Image");
local Full = workspace.CurrentCamera.ViewportSize;
image.Data = game:HttpGet("https://cdn130.picsart.com/342174523048211.png");
image.Visible = true;

game:GetService("RunService").RenderStepped:connect(function()
    image.Size = Vector2.new(Full.X, Full.Y)
    local vector, onScreen = camera:WorldToViewportPoint(game.Players.LocalPlayer.Character.Head.Position);
    if onScreen then
        image.Visible = true;
        image.Size = image.Size/Vector2.new(vector.Z, vector.Z);
        image.Position = Vector2.new(vector.X-(image.Size.X/2),vector.Y-(image.Size.Y/2));
    else
        image.Visible = false;
    end;
end);
