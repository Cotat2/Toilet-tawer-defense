local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- Eliminamos fuerzas de fling anteriores para que no se acumulen
for _, v in pairs(Root:GetChildren()) do
    if v:IsA("BodyAngularVelocity") or v:IsA("BodyVelocity") then
        v:Destroy()
    end
end

-- 1. Giro ultra rápido pero ESTABLE
local BV = Instance.new("BodyAngularVelocity")
BV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BV.AngularVelocity = Vector3.new(0, 99999, 0) 
BV.Parent = Root

-- 2. Estabilizador de Velocidad (Evita que salgas disparado)
local VelocityFix = Instance.new("BodyVelocity")
VelocityFix.MaxForce = Vector3.new(math.huge, 0, math.huge) -- Solo bloquea ejes X y Z
VelocityFix.Velocity = Vector3.new(0, 0, 0) 
VelocityFix.Parent = Root

-- 3. Loop de colisiones y altura
local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            -- Mantenemos una velocidad controlada para que el server no te eche
            part.Velocity = Vector3.new(0, 0.05, 0) 
        end
    end
end)

print("Fling Estable activado. Ahora deberías poder controlar tu personaje.")
