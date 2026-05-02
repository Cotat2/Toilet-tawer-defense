-- Script de Fling Universal
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Crear la fuerza de rotación (lo que empuja a los demás)
local Velocity = Instance.new("AngularVelocity")
Velocity.Name = "FlingForce"
Velocity.Parent = RootPart
Velocity.MaxTorque = math.huge
Velocity.AngularVelocity = Vector3.new(0, 99999, 0) -- Rotación extrema
Velocity.Attachment0 = RootPart:WaitForChild("RootAttachment")

-- Hacer que tu personaje sea "intocable" para no morir tú
for _, part in pairs(Character:GetDescendants()) do
    if part:IsA("BasePart") then
        part.CanCollide = false
    end
end

print("Fling activado. ¡Toca a alguien para que salga volando!")
