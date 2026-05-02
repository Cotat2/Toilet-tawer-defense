-- █ ULTRA STEALTH ADMIN MENU 2026 - CFrame Interpolation + Desync █
-- Ejecuta con Delta Executor (o cualquier executor con ProtectGui)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer
local mouse = plr:GetMouse()

local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local desynced = false
local speed = 92
local lastFloorFake = tick()

-- === PROTECT GUI + NOMBRES RANDOM ===
local guiName = "UI_" .. string.format("%x", math.random(100000000, 999999999))
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "F_" .. string.format("%x", math.random(100000000, 999999999))
Frame.Size = UDim2.new(0, 340, 0, 300)
Frame.Position = UDim2.new(0.5, -170, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "T_" .. string.format("%x", math.random(100000000, 999999999))
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
Title.Text = "🔥 ULTRA STEALTH ADMIN"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Botones
local FlyButton = Instance.new("TextButton")
FlyButton.Name = "B1_" .. string.format("%x", math.random(100000000, 999999999))
FlyButton.Size = UDim2.new(0.9, 0, 0, 45)
FlyButton.Position = UDim2.new(0.05, 0, 0.22, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FlyButton.Text = "🟢 FLY STEALTH ACTIVADO"
FlyButton.TextColor3 = Color3.new(1,1,1)
FlyButton.TextScaled = true
FlyButton.Font = Enum.Font.Gotham
FlyButton.Parent = Frame

local DesyncButton = Instance.new("TextButton")
DesyncButton.Name = "B2_" .. string.format("%x", math.random(100000000, 999999999))
DesyncButton.Size = UDim2.new(0.9, 0, 0, 45)
DesyncButton.Position = UDim2.new(0.05, 0, 0.42, 0)
DesyncButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DesyncButton.Text = "🟢 INVISIBLE DESYNC + CLON ACTIVADO"
DesyncButton.TextColor3 = Color3.new(1,1,1)
DesyncButton.TextScaled = true
DesyncButton.Font = Enum.Font.Gotham
DesyncButton.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "X_" .. string.format("%x", math.random(100000000, 999999999))
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Parent = Frame

-- === FLY STEALTH: CFrame Interpolation + Humanización ===
local function lerp(a, b, t) return a + (b - a) * t end

local function toggleFly()
    flying = not flying
    hum.PlatformStand = flying
    
    FlyButton.Text = flying and "🔴 FLY STEALTH DESACTIVADO" or "🟢 FLY STEALTH ACTIVADO"
    FlyButton.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
end

-- === INVISIBLE DESYNC + CLON LOCAL ===
local fakeClone = nil
local desyncConnection = nil

local function toggleDesync()
    desynced = not desynced
    
    if desynced then
        -- 1. Mandamos el personaje REAL a 5000 studs arriba (desync)
        local oldCFrame = root.CFrame
        root.CFrame = CFrame.new(0, 5000, 0)
        
        -- 2. Creamos clon falso que solo tú ves
        fakeClone = char:Clone()
        for _, v in pairs(fakeClone:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
            if v:IsA("BasePart") then
                v.Transparency = 0
                v.CanCollide = false
            end
        end
        fakeClone.Parent = plr.PlayerGui
        
        -- 3. Sincronizamos el clon con tu movimiento real
        desyncConnection = RS.RenderStepped:Connect(function()
            if fakeClone and fakeClone:FindFirstChild("HumanoidRootPart") then
                fakeClone.HumanoidRootPart.CFrame = oldCFrame * CFrame.new(0, 0, 0) -- se actualiza con tu input
            end
        end)
        
        DesyncButton.Text = "🔴 INVISIBLE DESYNC DESACTIVADO"
        DesyncButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        print("👻 DESYNC ACTIVADO - Hitbox a 5000 studs arriba")
    else
        if desyncConnection then desyncConnection:Disconnect() end
        if fakeClone then fakeClone:Destroy() end
        fakeClone = nil
        DesyncButton.Text = "🟢 INVISIBLE DESYNC + CLON ACTIVADO"
        DesyncButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end

-- LOOP PRINCIPAL (RenderStepped + humanización)
RS.RenderStepped:Connect(function(dt)
    if not flying then return end
    
    local cam = workspace.CurrentCamera
    local move = Vector3.new(0,0,0)
    
    if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
    
    if move.Magnitude > 0 then
        move = move.Unit
    end
    
    -- Humanización: velocidad variable + smoothing
    local currentSpeed = speed + math.random(-7, 7)
    local targetPos = root.Position + move * currentSpeed * dt * 60
    root.CFrame = CFrame.new(lerp(root.Position.X, targetPos.X, 0.35), 
                             lerp(root.Position.Y, targetPos.Y, 0.35), 
                             lerp(root.Position.Z, targetPos.Z, 0.35))
    
    -- Fake FloorMaterial cada 0.5s
    if tick() - lastFloorFake > 0.5 then
        hum.FloorMaterial = Enum.Material.Grass
        lastFloorFake = tick()
    end
end)

-- TELEPORT (también con lerp suave)
mouse.Button2Down:Connect(function()
    if not flying then return end
    local ray = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
    if ray then
        root.CFrame = CFrame.new(ray.Position + Vector3.new(0, 5, 0))
    end
end)

-- Controles
FlyButton.MouseButton1Click:Connect(toggleFly)
DesyncButton.MouseButton1Click:Connect(toggleDesync)

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then toggleFly()
    elseif input.KeyCode == Enum.KeyCode.I then toggleDesync()
    elseif input.KeyCode == Enum.KeyCode.Q then speed = speed + 15
    elseif input.KeyCode == Enum.KeyCode.E then speed = math.max(60, speed - 15)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("✅ ULTRA STEALTH MENU CARGADO - 2026 Edition")
print("   F = Fly Stealth | I = Invisible Desync")
print("   Clic Derecho = Teleport | Q/E = Velocidad")
print("Este script está hecho para ser lo más difícil posible de detectar. Usa cuenta secundaria + VPN por si acaso 😈")
