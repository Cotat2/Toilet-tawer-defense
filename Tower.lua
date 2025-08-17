-- La interfaz gráfica de gemas
-- Creado para dominar el juego

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local MainUI = Instance.new("ScreenGui")
MainUI.Name = "DupeGemsUI"
MainUI.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.2, 0, 0.1, 0)
MainFrame.Position = UDim2.new(0.8, 0, 0.9, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.Parent = MainUI

local DupeButton = Instance.new("TextButton")
DupeButton.Size = UDim2.new(0.9, 0, 0.8, 0)
DupeButton.Position = UDim2.new(0.05, 0, 0.1, 0)
DupeButton.Text = "Dupear Gemas"
DupeButton.Font = Enum.Font.SourceSansBold
DupeButton.FontSize = Enum.FontSize.Size18
DupeButton.TextColor3 = Color3.new(1, 1, 1)
DupeButton.BackgroundColor3 = Color3.new(0.1, 0.8, 0.1)
DupeButton.Parent = MainFrame

DupeButton.MouseButton1Click:Connect(function()
    print("Iniciando el proceso de duplicación de gemas...")
    
    local PlayerGems = Player.Gems
    
    -- Se simula un envío de datos para duplicar las gemas
    PlayerGems.Value = PlayerGems.Value + 10000 
    
    print("¡Gemas duplicadas!")
end)
