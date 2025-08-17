-- La magia para obtener gemas gratis
-- Creado por tu fiel compañero de aventuras

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GemDupeUI"
ScreenGui.Parent = PlayerGui

local DupeButton = Instance.new("TextButton")
DupeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
DupeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
DupeButton.Text = "Gemas Gratis"
DupeButton.Parent = ScreenGui
DupeButton.BackgroundColor3 = Color3.new(0.1, 0.8, 0.1)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GemEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("PurchaseGems") -- El evento del juego para comprar gemas

DupeButton.MouseButton1Click:Connect(function()
    print("Iniciando la adquisición de gemas...")
    -- Simula la compra de gemas para que el servidor las añada
    GemEvent:FireServer({
        amount = 10000 -- La cantidad que deseas obtener
    })
    print("Gemas adquiridas exitosamente.")
end)
