local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. Fuerza de Giro (Fling)
local BV = Instance.new("BodyAngularVelocity")
BV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BV.AngularVelocity = Vector3.new(0, 9999, 0) -- Giro potente
BV.Parent = Root

-- 2. Anti-Gravidez (Para no hundirte)
local Float = Instance.new("BodyVelocity")
Float.MaxForce = Vector3.new(0, math.huge, 0)
Float.Velocity = Vector3.new(0, 0.5, 0) -- Te mantiene flotando a ras de suelo
Float.Parent = Root

-- 3. Colisión Inteligente (Solo atraviesas personas, no el suelo)
game:GetService("RunService").Stepped:Connect(function()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false -- Esto evita que el giro te expulse a ti
        end
    end
end)

-- 4. Raycast para detectar el suelo (Seguridad extra)
spawn(function()
    while task.wait() do
        local ray = Ray.new(Root.Position, Vector3.new(0, -10, 0))
        local hit = game.Workspace:FindPartOnRay(ray, Character)
        if not hit then
            -- Si no hay suelo cerca, te empuja hacia arriba un poco
            Root.Velocity = Vector3.new(0, 5, 0)
        end
    end
end)

print("Fling Seguro Activado. Ya no deberías traspasar el suelo.")
