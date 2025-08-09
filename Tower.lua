-- Script para "Carnival Chaos: Toilet Tower Defense" (ID: 13775256536)
-- Con modo discreto para evitar detección de UI

-- Configuración del juego
local GAME_ID = 13775256536

-- Variables principales
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local menuFrame = nil -- La referencia al menú

-- Estado de las funciones
local autoWinEnabled = false
local autoWinConnection = nil

-- Función principal para el Auto-win
local function toggleAutoWin(state)
    autoWinEnabled = state
    if state then
        autoWinConnection = RunService.Stepped:Connect(function()
            if autoWinEnabled and game.PlaceId == GAME_ID then
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, enemy in ipairs(enemies:GetChildren()) do
                        if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") then
                            enemy:Destroy()
                        end
                    end
                end
            end
        end)
    else
        if autoWinConnection then
            autoWinConnection:Disconnect()
            autoWinConnection = nil
        end
    end
end

-- Función que se encarga de crear el menú y su lógica
local function createMenu()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HubMenu"

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local navFrame = Instance.new("Frame")
    navFrame.Size = UDim2.new(0, 150, 1, 0)
    navFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    navFrame.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Text = "Chilli Hub"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    titleLabel.Parent = navFrame

    local function createTabButton(text, yOffset)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Position = UDim2.new(0, 0, 0, yOffset)
        button.Text = text
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.TextColor3 = Color3.new(0.6, 0.6, 0.6)
        button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Parent = navFrame
        return button
    end

    local mainButton = createTabButton("  Main", 40)
    local playerButton = createTabButton("  Player", 80)

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -150, 1, -40)
    contentFrame.Position = UDim2.new(0, 150, 0, 40)
    contentFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    contentFrame.Parent = mainFrame

    local mainTab = Instance.new("Frame")
    mainTab.Size = UDim2.new(1, 0, 1, 0)
    mainTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    mainTab.Parent = contentFrame
    mainTab.Visible = true

    local playerTab = Instance.new("Frame")
    playerTab.Size = UDim2.new(1, 0, 1, 0)
    playerTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    playerTab.Parent = contentFrame
    playerTab.Visible = false

    local currentTab = mainTab
    mainButton.MouseButton1Click:Connect(function() 
        currentTab.Visible = false
        mainTab.Visible = true
        currentTab = mainTab
    end)
    playerButton.MouseButton1Click:Connect(function() 
        currentTab.Visible = false
        playerTab.Visible = true
        currentTab = playerTab
    end)

    -- MAIN TAB
    local autoWinButton = Instance.new("TextButton")
    autoWinButton.Size = UDim2.new(0, 180, 0, 40)
    autoWinButton.Position = UDim2.new(0, 20, 0, 20)
    autoWinButton.Text = "Auto-win: OFF"
    autoWinButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    autoWinButton.Parent = mainTab
    autoWinButton.MouseButton1Click:Connect(function()
        toggleAutoWin(not autoWinEnabled)
        autoWinButton.Text = "Auto-win: " .. (autoWinEnabled and "ON" or "OFF")
    end)

    return screenGui
end

-- Función para mostrar/ocultar el menú
local function toggleMenu()
    if menuFrame then
        menuFrame:Destroy()
        menuFrame = nil
    else
        menuFrame = createMenu()
        menuFrame.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

-- Esperar 5 segundos para que el juego cargue completamente
wait(5)

-- Comprobación del ID del juego
if game.PlaceId == GAME_ID then
    -- Escuchar la tecla G para mostrar/ocultar el menú
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.G and not gameProcessedEvent then
            toggleMenu()
        end
    end)
end
