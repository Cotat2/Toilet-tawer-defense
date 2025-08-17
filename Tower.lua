-- La interfaz gráfica de la foto, sin funciones
-- Creada para que tengas el mejor menú del juego

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local MainUI = Instance.new("ScreenGui")
MainUI.Name = "CustomUI"
MainUI.Parent = PlayerGui

-- Main Frame (el recuadro principal)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.Parent = MainUI

-- Title (el texto de "Hax para TLD")
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Text = "Hax para TLD"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.FontSize = Enum.FontSize.Size24
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
TitleLabel.Parent = MainFrame

-- Botón 1 (el verde)
local Button1 = Instance.new("TextButton")
Button1.Size = UDim2.new(0.8, 0, 0.15, 0)
Button1.Position = UDim2.new(0.1, 0, 0.2, 0)
Button1.Text = "Dupear Gemas"
Button1.Font = Enum.Font.SourceSansBold
Button1.FontSize = Enum.FontSize.Size18
Button1.TextColor3 = Color3.new(1, 1, 1)
Button1.BackgroundColor3 = Color3.new(0.1, 0.8, 0.1)
Button1.Parent = MainFrame

-- Botón 2 (el azul)
local Button2 = Instance.new("TextButton")
Button2.Size = UDim2.new(0.8, 0, 0.15, 0)
Button2.Position = UDim2.new(0.1, 0, 0.4, 0)
Button2.Text = "Obtener Unidades (Súper)"
Button2.Font = Enum.Font.SourceSansBold
Button2.FontSize = Enum.FontSize.Size18
Button2.TextColor3 = Color3.new(1, 1, 1)
Button2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.8)
Button2.Parent = MainFrame

-- Botón 3 (el naranja)
local Button3 = Instance.new("TextButton")
Button3.Size = UDim2.new(0.8, 0, 0.15, 0)
Button3.Position = UDim2.new(0.1, 0, 0.6, 0)
Button3.Text = "Saltar Oleadas"
Button3.Font = Enum.Font.SourceSansBold
Button3.FontSize = Enum.FontSize.Size18
Button3.TextColor3 = Color3.new(1, 1, 1)
Button3.BackgroundColor3 = Color3.new(0.8, 0.5, 0.1)
Button3.Parent = MainFrame

-- Simulación de los eventos para que no dé errores
Button1.MouseButton1Click:Connect(function()
    print("El botón de Dupear Gemas ha sido presionado. No hay ninguna función asignada.")
end)

Button2.MouseButton1Click:Connect(function()
    print("El botón de Obtener Unidades ha sido presionado. No hay ninguna función asignada.")
end)

Button3.MouseButton1Click:Connect(function()
    print("El botón de Saltar Oleadas ha sido presionado. No hay ninguna función asignada.")
end)
