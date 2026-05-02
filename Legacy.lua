-- █ MENU COMPLETO 2026 - FLY + INVISIBLE + FLING + NOCLIP + TELEPORT █
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
local invisible = false
local noclip = false
local autoFling = false
local speed = 92

-- Variables clon y fling
local fakeClone = nil
local desyncConn = nil

-- === GUI MINIMIZABLE ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UI_" .. math.random(100000,999999)
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = plr:WaitForChild("PlayerGui")

local MiniButton = Instance.new("TextButton")
MiniButton.Size = UDim2.new(0, 55, 0, 55)
MiniButton.Position = UDim2.new(0, 30, 0.4, 0)
MiniButton.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
MiniButton.Text = "🔥"
MiniButton.TextScaled = true
MiniButton.Font = Enum.Font.GothamBold
MiniButton.TextColor3 = Color3.new(1,1,1)
MiniButton.Draggable = true
MiniButton.Parent = ScreenGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 360, 0, 420)
Frame.Position = UDim2.new(0.5, -180, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
Title.Text = "🔥 ALL HACKS MENU"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Crear botones
local function createBtn(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, y, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = Frame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local FlyBtn = createBtn("🟢 FLY STEALTH", 0.13, function()
    flying = not flying
    hum.PlatformStand = flying
    FlyBtn.Text = flying and "🔴 FLY OFF" or "🟢 FLY STEALTH ON"
end)

local InvBtn = createBtn("🟢 INVISIBLE DESYNC", 0.25, function()
    invisible = not invisible
    if invisible then
        for _, m in pairs(char:GetDescendants()) do if m:IsA("Motor6D") then m:Destroy() end end
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 1; p.CanCollide = false end
        end
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
        InvBtn.Text = "🔴 INVISIBLE OFF"
    else
        if desyncConn then desyncConn:Disconnect() end
        if fakeClone then fakeClone:Destroy() end
        InvBtn.Text = "🟢 INVISIBLE DESYNC ON"
    end
end)

local NoclipBtn = createBtn("🟢 NOCLIP", 0.37, function()
    noclip = not noclip
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = not noclip end
    end
    NoclipBtn.Text = noclip and "🔴 NOCLIP OFF" or "🟢 NOCLIP ON"
end)

local FlingBtn = createBtn("🟢 AUTO FLING NEARBY", 0.49, function()
    autoFling = not autoFling
    FlingBtn.Text = autoFling and "🔴 AUTO FLING OFF" or "🟢 AUTO FLING ON"
end)

local CloseBtn = createBtn("MINIMIZAR", 0.65, function()
    Frame.Visible = false
end)

-- MiniButton toggle
MiniButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- === AUTO FLING (lanza a la gente volando) ===
RS.Heartbeat:Connect(function()
    if not autoFling then return end
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= plr and target.Character then
            local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and (tRoot.Position - root.Position).Magnitude < 12 then
                tRoot.AssemblyLinearVelocity = root.CFrame.LookVector * 600 + Vector3.new(0, 400, math.random(-100,100))
                tRoot.AssemblyAngularVelocity = Vector3.new(math.random(-500,500), math.random(-800,800), math.random(-500,500))
            end
        end
    end
end)

-- FLY LOOP
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
    
    if move.Magnitude > 0 then move = move.Unit end
    local curSpeed = speed + math.random(-8,8)
    local target = root.Position + move * curSpeed * dt * 60
    root.CFrame = CFrame.new(root.Position:Lerp(target, 0.45))
end)

-- TELEPORT
mouse.Button2Down:Connect(function()
    if not flying then return end
    local ray = workspace:Raycast(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
    if ray then root.CFrame = CFrame.new(ray.Position + Vector3.new(0,5,0)) end
end)

-- Atajos
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then FlyBtn.MouseButton1Click:Fire()
    elseif input.KeyCode == Enum.KeyCode.I then InvBtn.MouseButton1Click:Fire()
    elseif input.KeyCode == Enum.KeyCode.N then NoclipBtn.MouseButton1Click:Fire()
    elseif input.KeyCode == Enum.KeyCode.G then FlingBtn.MouseButton1Click:Fire()
    end
end)

print("✅ MENÚ CON TODOS LOS HACKS CARGADO")
print("   Clic en el cuadradito para abrir")
print("   F=Fly | I=Invisible | N=Noclip | G=Auto Fling")
print("   Clic Derecho = Teleport")
