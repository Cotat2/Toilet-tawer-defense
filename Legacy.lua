local player = game.Players.LocalPlayer

-- Esperar leaderstats
repeat wait() until player:FindFirstChild("leaderstats")
local leaderstats = player.leaderstats

-- Esperar Coins
repeat wait() until leaderstats:FindFirstChild("Coins")
local coins = leaderstats.Coins

-- Crear GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,100)
frame.Position = UDim2.new(0.5,-100,0.5,-50)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

local toggleButton = Instance.new("TextButton", frame)
toggleButton.Size = UDim2.new(0,180,0,50)
toggleButton.Position = UDim2.new(0,10,0,10)
toggleButton.Text = "OFF"

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(0,180,0,30)
statusLabel.Position = UDim2.new(0,10,0,65)
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(0,255,0)
statusLabel.TextScaled = true

local active = false
local loop

toggleButton.MouseButton1Click:Connect(function()
    active = not active
    if active then
        toggleButton.Text = "ON"
        coins.Value = coins.Value + 1000000
        statusLabel.Text = "Successfully"
        wait(2)
        statusLabel.Text = ""
        loop = coroutine.wrap(function()
            while active do
                wait(5)
                coins.Value = coins.Value + 5000
            end
        end)
        loop()
    else
        toggleButton.Text = "OFF"
    end
end)
