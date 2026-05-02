local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. Limpieza total de fuerzas anteriores (¡Importante!)
for _, v in pairs(Root:GetChildren()) do
    if v:IsA("BodyAngularVelocity") or v:IsA("BodyVelocity") then
        v:Destroy()
    end
end

-- 2. Fuerza de Giro (Fling) - Un poco más controlada
local BV = Instance.new("BodyAngularVelocity")
BV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BV.AngularVelocity = Vector3.new(0, 8000, 0) -- Girar, pero no a velocidad luz
BV.Parent = Root

-- 3. Estabilizador Vertical (¡ESTA ES LA MEJORA!)
local VelocityFix = Instance.new("BodyVelocity")
VelocityFix.MaxForce = Vector3.new(0, math.huge, 0) -- SOLO actúa en el eje Y (arriba/abajo)
VelocityFix.Velocity = Vector3.new(0, 0.1, 0) -- Fuerza mínima hacia arriba para no hundirte, pero no subes
VelocityFix.Parent = Root

-- 4. Bucle de colisiones para atravesar jugadores
local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false -- Evita que te mates tú
        end
    end
end)

print("Fling Corregido Activado. Deberías girar y no subir sin parar.")
