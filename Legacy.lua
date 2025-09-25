local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)

-- Chequea si el juego carga
if not game:IsLoaded() then
    print("Juego no cargado, espera un momento, crack.")
    wait(5)
end

-- Encuentra los remotes
local collectRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CollectMoney")
if not collectRemote then
    print("¡Cago en todo! Remote 'CollectMoney' no encontrado. Puede estar parcheado.")
    return
end
local dupeEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("CoinDupe") or nil

-- Estado del dupe
local isDuping = true

-- Función para dupe coins
local function dupeCoins(amount)
    if not isDuping then return end
    local dupeAmount = 0
    for i = 1, 10 do
        pcall(function()
            collectRemote:FireServer(amount * i)
            if dupeEvent then dupeEvent:FireServer("DupeTrigger") end
            dupeAmount = dupeAmount + (amount * i)
        end)
    end
    print("¡Duped! + " .. dupeAmount .. " coins, ¡a petarlo, jefe!")
    return dupeAmount
end

-- Auto-farm loop (cada 5 seg)
spawn(function()
    while true do
        wait(5)
        if isDuping then
            local currentCoins = player.leaderstats and player.leaderstats.Coins and player.leaderstats.Coins.Value or 0
            if currentCoins > 0 then
                local duped = dupeCoins(currentCoins * 0.1)
                if duped > 0 then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Dupe Activo",
                        Text = "+" .. duped .. " coins dupedas!",
                        Duration = 3
                    })
                end
            else
                print("No hay coins en leaderstats, ¿server roto o qué?")
            end
        end
    end
end)

-- Speed hack
local function speedHack(speed)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid", 5)
    humanoid.WalkSpeed = speed
end
speedHack(50)

-- Auto-buy seeds
spawn(function()
    while true do
        wait(10)
        local marketRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("BuySeed")
        if marketRemote then
            marketRemote:FireServer("PeaShooter", 1)
            print("Seeds auto-comprados, ¡tu jardín es un puto Amazonas!")
        end
    end
end)

-- GUI mejorada
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true
screenGui.Name = "DupeGUI"

-- Frame principal del menú
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0

-- Botón de dupe
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(0, 200, 0, 60)
toggleButton.Position = UDim2.new(0, 25, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "DUPE ON"
toggleButton.TextScaled = true
toggleButton.MouseButton1Click:Connect(function()
    isDuping = not isDuping
    toggleButton.Text = isDuping and "DUPE ON" or "DUPE OFF"
    toggleButton.BackgroundColor3 = isDuping and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(100, 100, 100)
    print("Dupe " .. (isDuping and "activado" or "desactivado") .. ", ¡tú mandas, crack!")
end)

-- Label de monedas
local coinLabel = Instance.new("TextLabel")
coinLabel.Parent = mainFrame
coinLabel.Size = UDim2.new(0, 200, 0, 40)
coinLabel.Position = UDim2.new(0, 25, 0, 90)
coinLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
coinLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
coinLabel.Text = "Coins: Esperando..."
coinLabel.TextScaled = true

-- Botón de ocultar
local hideButton = Instance.new("TextButton")
hideButton.Parent = mainFrame
hideButton.Size = UDim2.new(0, 200, 0, 40)
hideButton.Position = UDim2.new(0, 25, 0, 140)
hideButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Text = "Hide Menu"
hideButton.TextScaled = true

-- Logo redondo (visible cuando menú oculto)
local logoButton = Instance.new("TextButton")
logoButton.Parent = screenGui
logoButton.Size = UDim2.new(0, 50, 0, 50)
logoButton.Position = UDim2.new(1, -70, 0, 20)
logoButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
logoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
logoButton.Text = "H"
logoButton.TextScaled = true
logoButton.Visible = false
logoButton.BackgroundTransparency = 0.2
-- Hacerlo redondo
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.5, 0)
corner.Parent = logoButton

-- Toggle menú
hideButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    logoButton.Visible = not mainFrame.Visible
    hideButton.Text = mainFrame.Visible and "Hide Menu" or "Show Menu"
    print("Menú " .. (mainFrame.Visible and "mostrado" or "oculto") .. ", ¡estilo hacker!")
end)
logoButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    logoButton.Visible = false
    hideButton.Text = "Hide Menu"
    print("Menú restaurado, ¡vamos a petarlo!")
end)

-- Actualiza label de monedas
spawn(function()
    while true do
        wait(1)
        local currentCoins = player.leaderstats and player.leaderstats.Coins and player.leaderstats.Coins.Value or 0
        coinLabel.Text = "Coins: " .. currentCoins
    end
end)

print("Script v3 cargado, ¡GUI con botón ON/OFF y logo redondo listo! Si no ves nada, revisa tu executor. Discord: discord.gg/fakecheats2025. ¡A reventar el juego, hermano! 💥")
