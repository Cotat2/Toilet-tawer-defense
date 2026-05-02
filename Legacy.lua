-- █ MENU MINIMIZABLE STEALTH 2026 - Fly + Invisible Desync + Teleport █
-- Ejecuta con Delta Executor

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local plr = Players.LocalPlayer
local mouse = plr:GetMouse()

local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local desynced = false
local speed = 92

-- Variables para clon y desync
local fakeClone = nil
local desyncConn = nil

-- === GUI MINIMIZABLE ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UI_" .. math.random(100000,999999)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

-- Cuadradito minimizado (siempre visible)
local MiniButton = Instance.new("TextButton")
MiniButton.Size = UDim2.new(0, 50, 0, 50)
MiniButton.Position = UDim2.new(0, 20, 0.5, -25)
MiniButton.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
MiniButton.Text = "🔥"
MiniButton.TextScaled = true
MiniButton.Font = Enum.Font.GothamBold
MiniButton.TextColor3 = Color3.new(1,1,1)
MiniButton.Active = true
MiniButton.Draggable = true
MiniButton.Parent = ScreenGui

-- Menú principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 320)
MainFrame.Position = UDim2.new(0.5, -170, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
Title.Text = "🔥 STEALTH ADMIN MENU"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Botones del menú
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local FlyBtn = createButton("🟢 FLY STEALTH", 0.18, function()
    flying = not flying
    hum.PlatformStand = flying
    FlyBtn.Text = flying and "🔴 FLY STEALTH OFF" or "🟢 FLY STEALTH ON"
end)

local InvBtn = createButton("🟢 INVISIBLE DESYNC", 0.35, function()
    desynced = not desynced
    if desynced then
        -- Rompemos joints del real
        for _, m in pairs(char:GetDescendants()) do
            if m:IsA("Motor6D") then m:Destroy() end
        end
        -- Real invisible para otros
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 1; p.CanCollide = false end
        end
        -- Clon local
        fakeClone = char:Clone()
        for _, v in pairs(fakeClone:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 0 end
            if v:IsA("Script") or v:IsA("LocalScript") then v:Destroy() end
        end
        fakeClone.Parent = plr.PlayerGui
        desyncConn = RS.RenderStepped:Connect(function()
            if fakeClone and fakeClone:FindFirstChild("HumanoidRootPart") then
                fakeClone.HumanoidRootPart.CFrame = root.CFrame
            end
        end)
        InvBtn.Text = "🔴 INVISIBLE DESYNC OFF"
    else
        if desyncConn then desyncConn:Disconnect() end
        if fakeClone then fakeClone:Destroy() end
        InvBtn.Text = "🟢 INVISIBLE DESYNC ON"
    end
end)

local TpLabel = Instance.new("TextLabel")
TpLabel.Size = UDim2.new(0.9, 0, 0, 35)
TpLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
TpLabel.BackgroundTransparency = 1
TpLabel.Text = "Clic Derecho = Teleport (solo volando)"
TpLabel.TextColor3 = Color3.new(0.7,0.7,0.7)
TpLabel.TextScaled = true
TpLabel.Parent = MainFrame

local CloseBtn = createButton("Minimizar", 0.72, function()
    MainFrame.Visible = false
end)

-- Toggle del menú con el cuadradito
MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Fly + Teleport + Humanización
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
    
    local currentSpeed = speed + math.random(-8,8)
    local target = root.Position + move * currentSpeed * dt * 55
    root.CFrame = CFrame.new(
        root.Position:Lerp(target, 0.4)
    )
end)

mouse.Button2Down:Connect(function()
    if not flying then return end
    local ray = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
    if ray then root.CFrame = CFrame.new(ray.Position + Vector3.new(0,5,0)) end
end)

print("✅ MENÚ MINIMIZABLE CARGADO - Cuadradito en pantalla")
print("   Clic en el cuadradito 🔥 para abrir/cerrar")
print("   Dentro: Fly, Invisible Desync, Teleport")
