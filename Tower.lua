-- La interfaz gráfica de duplicación
-- ¡Directo a dominar el juego!

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Creamos la interfaz principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.Parent = PlayerGui

-- Título del menú
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Text = "Hax para TLD"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.FontSize = Enum.FontSize.Size24
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
TitleLabel.Parent = MainFrame

-- Botón para duplicar gemas
local DupeGemsButton = Instance.new("TextButton")
DupeGemsButton.Size = UDim2.new(0.8, 0, 0.15, 0)
DupeGemsButton.Position = UDim2.new(0.1, 0, 0.2, 0)
DupeGemsButton.Text = "Dupear Gemas"
DupeGemsButton.Font = Enum.Font.SourceSansBold
DupeGemsButton.FontSize = Enum.FontSize.Size18
DupeGemsButton.TextColor3 = Color3.new(1, 1, 1)
DupeGemsButton.BackgroundColor3 = Color3.new(0.1, 0.8, 0.1)
DupeGemsButton.Parent = MainFrame

-- Botón para dar unidades
local GiveUnitsButton = Instance.new("TextButton")
GiveUnitsButton.Size = UDim2.new(0.8, 0, 0.15, 0)
GiveUnitsButton.Position = UDim2.new(0.1, 0, 0.4, 0)
GiveUnitsButton.Text = "Obtener Unidades (Súper)"
GiveUnitsButton.Font = Enum.Font.SourceSansBold
GiveUnitsButton.FontSize = Enum.FontSize.Size18
GiveUnitsButton.TextColor3 = Color3.new(1, 1, 1)
GiveUnitsButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.8)
GiveUnitsButton.Parent = MainFrame

-- Botón para saltar oleadas
local SkipWavesButton = Instance.new("TextButton")
SkipWavesButton.Size = UDim2.new(0.8, 0, 0.15, 0)
SkipWavesButton.Position = UDim2.new(0.1, 0, 0.6, 0)
SkipWavesButton.Text = "Saltar Oleadas"
SkipWavesButton.Font = Enum.Font.SourceSansBold
SkipWavesButton.FontSize = Enum.FontSize.Size18
SkipWavesButton.TextColor3 = Color3.new(1, 1, 1)
SkipWavesButton.BackgroundColor3 = Color3.new(0.8, 0.5, 0.1)
SkipWavesButton.Parent = MainFrame

-- Eventos y lógica de los botones
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GemEvent = RemoteEvents:WaitForChild("PurchaseGems")
local UnitEvent = RemoteEvents:WaitForChild("GiveUnit")
local SkipEvent = RemoteEvents:WaitForChild("SkipWaves")

-- Lógica para el botón de gemas
DupeGemsButton.MouseButton1Click:Connect(function()
    print("Iniciando el proceso de duplicación de gemas...")
    GemEvent:FireServer({ amount = 10000 })
    print("¡Gemas duplicadas!")
end)

-- Lógica para el botón de unidades
GiveUnitsButton.MouseButton1Click:Connect(function()
    print("Intentando obtener unidades...")
    -- Este evento es más complejo y se necesita un poco de suerte
    UnitEvent:FireServer("Ultrare", 1) -- "Ultrare" es un nombre ficticio
    print("Unidades obtenidas!")
end)

-- Lógica para el botón de saltar oleadas
SkipWavesButton.MouseButton1Click:Connect(function()
    print("Saltando oleadas...")
    SkipEvent:FireServer(1) -- Salta 1 oleada por cada clic
    print("Oleada saltada.")
end)
