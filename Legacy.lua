local p = game.Players.LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local root = c:WaitForChild("HumanoidRootPart")
local hum = c:WaitForChild("Humanoid")

-- 1. Limpiar todo lo anterior para que no haya conflictos
for _, v in pairs(root:GetChildren()) do
    if v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") then v:Destroy() end
end

-- 2. El Giro (Fling)
local bgv = Instance.new("BodyAngularVelocity")
bgv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
bgv.AngularVelocity = Vector3.new(0, 9500, 0)
bgv.Parent = root

-- 3. Estabilizador (Para no subir como cohete ni hundirte)
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0, math.huge, 0)
bv.Velocity = Vector3.new(0, 0, 0) -- Velocidad 0 para quedarte pegado al suelo
bv.Parent = root

-- 4. Anti-Tumbado y Colisiones
game:GetService("RunService").Stepped:Connect(function()
    hum.PlatformStand = false
    for _, part in pairs(c:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
end)

print("Script reiniciado y estabilizado.")
