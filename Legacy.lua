local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local p = game.Players.LocalPlayer
local mouse = p:GetMouse()

-- Variables de estado
local flingActivo = false
local flyActivo = false
local conexionFling
local conexionFly

-- Configuración Fly
local flySpeed = 50

-- === FUNCIÓN SUPERNOVA (Tecla B) ===
-- Añadida con cuidado extremo para no interferir con el resto
local function pedirSupernova()
    local success, err = pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        -- Intentamos los Remotes más comunes en este tipo de juegos
        local r1 = rs:FindFirstChild("SpawnItem")
        local r2 = rs:FindFirstChild("GiveItem")
        local r3 = rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("GiveItem")
        
        if r1 then r1:FireServer("Supernova") end
        if r2 then r2:FireServer("Supernova") end
        if r3 then r3:FireServer("Supernova") end
    end)
end

-- === FUNCIÓN FLING ===
local function limpiarFling()
    local c = p.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    for _, v in pairs(c.HumanoidRootPart:GetChildren()) do
        if v.Name == "FlingForce" or v.Name == "FlingAnchor" then v:Destroy() end
    end
    if conexionFling then conexionFling:Disconnect() end
end

local function activarFling()
    local c = p.Character
    if not c then return end
    local root = c:WaitForChild("HumanoidRootPart")
    local hum = c:WaitForChild("Humanoid")
    limpiarFling()

    local bgv = Instance.new("BodyAngularVelocity")
    bgv.Name = "FlingForce"
    bgv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bgv.AngularVelocity = Vector3.new(0, 9000, 0)
    bgv.Parent = root

    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlingAnchor"
    bv.MaxForce = Vector3.new(0, math.huge, 0)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = root

    conexionFling = RunService.Stepped:Connect(function()
        hum.PlatformStand = false
        for _, part in pairs(c:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
end

-- === FUNCIÓN FLY ===
local function activarFly()
    local c = p.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local root = c.HumanoidRootPart
    
    local bvFly = Instance.new("BodyVelocity")
    bvFly.Name = "AdminFly"
    bvFly.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bvFly.Velocity = Vector3.new(0, 0, 0)
    bvFly.Parent = root

    local bgFly = Instance.new("BodyGyro")
    bgFly.Name = "AdminGyro"
    bgFly.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bgFly.CFrame = root.CFrame
    bgFly.Parent = root

    conexionFly = RunService.RenderStepped:Connect(function()
        if not flyActivo then return end
        local camCFrame = workspace.CurrentCamera.CFrame
        local moveDir = Vector3.new(0,0,0)
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0,1,0) end
        
        bvFly.Velocity = moveDir * flySpeed
        bgFly.CFrame = camCFrame
    end)
end

local function limpiarFly()
    local c = p.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    for _, v in pairs(c.HumanoidRootPart:GetChildren()) do
        if v.Name == "AdminFly" or v.Name == "AdminGyro" then v:Destroy() end
    end
    if conexionFly then conexionFly:Disconnect() end
end

-- === DETECTOR DE TECLAS ===
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- Tecla L para Fling
    if input.KeyCode == Enum.KeyCode.L then
        flingActivo = not flingActivo
        if flingActivo then activarFling() else limpiarFling() end
    end
    
    -- Tecla F para Fly
    if input.KeyCode == Enum.KeyCode.F then
        flyActivo = not flyActivo
        if flyActivo then activarFly() else limpiarFly() end
    end

    -- Tecla B para Supernova
    if input.KeyCode == Enum.KeyCode.B then
        pedirSupernova()
    end
end)
