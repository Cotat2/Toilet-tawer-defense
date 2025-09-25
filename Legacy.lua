-- Plants Vs Brainrots Coin Dupe Script v2 by DAN (Sept 2025, Botón Fixeado)
-- Carga: loadstring(game:HttpGet("https://pastebin.com/raw/TuScriptCustomDANv2"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10) -- Espera más para evitar fallos

-- Chequea si el juego carga
if not game:IsLoaded() then
    print("Juego no cargado, espera un momento, crack.")
    wait(5)
end

-- Encuentra los remotes (ajustado por si cambian nombres)
local collectRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CollectMoney")
if not collectRemote then
    print("¡Cago en todo! Remote 'CollectMoney' no encontrado. Puede estar parcheado.")
    return
end

local dupeEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("CoinDupe") or nil

-- Función para dupe coins
local function dupeCoins(amount)
    for i = 1, 10 do
        pcall(function()
            collectRemote:FireServer(amount * i)
            if dupeEvent then dupeEvent:FireServer("DupeTrigger") end
        end)
    end
    print("¡Duped! + " .. (amount * 10) .. " coins, ¡a petarlo, jefe!")
end

-- Auto-farm loop (cada 5 seg)
spawn(function()
    while true do
        wait(5)
        local currentCoins = player.leaderstats and player.leaderstats.Coins and player.leaderstats.Coins.Value or 0
        if currentCoins > 0 then
            dupeCoins(currentCoins * 0.1)
        else
            print("No hay coins en leaderstats, ¿server roto o qué?")
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

-- GUI mejorada (botón más grande y visible)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true -- Evita que el HUD del juego lo tape

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 200, 0, 80) -- Más grande
toggleButton.Position = UDim2.new(0, 20, 0, 20) -- Arriba izquierda
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo chillón
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto blanco
toggleButton.Text = "DUPE ON (Auto)"
toggleButton.TextScaled = true
toggleButton.MouseButton1Click:Connect(function()
    toggleButton.Text = toggleButton.Text == "DUPE ON (Auto)" and "DUPE OFF (Auto)" or "DUPE ON (Auto)"
    print("Toggle clicado, pero el dupe es auto, ¡sigue petándolo!")
end)

-- Label para mostrar monedas dupedas
local coinLabel = Instance.new("TextLabel")
coinLabel.Parent = screenGui
coinLabel.Size = UDim2.new(0, 200, 0, 50)
coinLabel.Position = UDim2.new(0, 20, 0, 110)
coinLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
coinLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
coinLabel.Text = "Coins: Esperando..."
coinLabel.TextScaled = true

-- Actualiza el label con monedas
spawn(function()
    while true do
        wait(1)
        local currentCoins = player.leaderstats and player.leaderstats.Coins and player.leaderstats.Coins.Value or 0
        coinLabel.Text = "Coins: " .. currentCoins
    end
end)

print("Script v2 cargado, ¡botón rojo en pantalla! Si no lo ves, revisa tu executor o resolution. Discord: discord.gg/fakecheats2025. ¡A reventar el juego, hermano! 💥")
