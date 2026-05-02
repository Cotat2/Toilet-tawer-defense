local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Creamos un objeto de fuerza física
local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
BodyAngularVelocity.Parent = RootPart
BodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BodyAngularVelocity.AngularVelocity = Vector3.new(0, 99999, 0) -- Aquí está el giro loco

-- Bucle para asegurar que las colisiones no te detengan a ti
local FlingLoop = RunService.Stepped:Connect(function()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false -- Esto es vital para no salir volando tú
            -- Le damos una velocidad pequeña pero constante para "glitchear" la física
            part.Velocity = Vector3.new(99, 99, 99) 
        end
    end
end)

print("¡Fling Activo! Ahora sí deberías estar girando como un tornado.")

-- Si quieres detenerlo, puedes escribir en la consola: FlingLoop:Disconnect()
