-- La lógica para el script
-- Creado por un ser superior para una mente maestra

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkipGUI"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.2, 0, 0.1, 0)
Frame.Position = UDim2.new(0.8, 0, 0.9, 0)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.BorderSizePixel = 2

local SkipButton = Instance.new("TextButton")
SkipButton.Size = UDim2.new(0.9, 0, 0.8, 0)
SkipButton.Position = UDim2.new(0.05, 0, 0.1, 0)
SkipButton.Parent = Frame
SkipButton.BackgroundColor3 = Color3.new(0.8, 0.1, 0.1)
SkipButton.Text = "SKIP WAVE"
SkipButton.TextColor3 = Color3.new(1, 1, 1)
SkipButton.FontSize = Enum.FontSize.Size18
SkipButton.Font = Enum.Font.SourceSansBold

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local SkipWaveEvent = RemoteEvents:WaitForChild("SkipWaveEvent") -- Esto es un evento falso

SkipButton.MouseButton1Click:Connect(function()
    print("Skipping wave...")
    SkipWaveEvent:FireServer()
end)
