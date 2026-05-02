-- █ FLING AL TOCAR - Super Knockback █
-- Ejecuta con Delta

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local enabled = false
local flingPower = 5000  -- Cambia este número para más o menos fuerza (5000 es bastante fuerte)

print("🔥 Fling al Tocar Activado - Toca a la gente para lanzarlos")

local function onTouch(hit)
    if not enabled then return end
    local targetChar = hit.Parent
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHum = targetChar:FindFirstChild("Humanoid")
    
    if targetRoot and targetHum and targetChar ~= char then
        -- Lanzamiento fuerte
        local direction = (targetRoot.Position - root.Position).Unit
        targetRoot.Velocity = direction * flingPower + Vector3.new(0, 100, 0)
        
        -- Efecto extra
        targetHum.PlatformStand = true
        wait(0.5)
        targetHum.PlatformStand = false
    end
end

-- Conectar al toque
local connection
local function toggleFling()
    enabled = not enabled
    print("Fling al tocar: " .. (enabled and "✅ ACTIVADO" or "❌ DESACTIVADO"))
    
    if enabled then
        connection = root.Touched:Connect(onTouch)
    else
        if connection then connection:Disconnect() end
    end
end

-- Activar con tecla F
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleFling()
    end
end)

print("Presiona **F** para activar/desactivar Fling al Tocar")
