-- Script para "Carnival Chaos: Toilet Tower Defense"
-- Con el Auto-win corregido

-- Variables principales
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local screenGui = nil -- Referencia al ScreenGui principal
local mainFrame = nil -- Referencia al marco principal del menú
local showButton = nil -- Referencia al botón para mostrar

-- Estado de las funciones
local autoWinEnabled = false
local autoWinConnection = nil
local menuHidden = false

-- Función principal para el Auto-win (CORREGIDA)
local function toggleAutoWin(state)
    autoWinEnabled = state
    if state then
        autoWinConnection = RunService.Stepped:Connect(function()
            if autoWinEnabled then
                -- Bucle a través de todos los hijos del workspace para encontrar enemigos
                for _, child in ipairs(workspace:GetChildren()) do
                    if child:IsA("Model") and child:FindFirstChild("Humanoid") then
                        -- El nombre del enemigo podría ser "Cameraman", "Speaker", etc.
                        -- Esta es una forma genérica de encontrar cualquier modelo con un Humanoid
                        -- y eliminarlo.
                        child:Destroy()
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
    
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HubMenu"

    mainFrame = Instance.new("Frame")
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
        if autoWinEnabled then
            toggleAutoWin(false)
            autoWinButton.Text = "Auto-win: OFF"
        else
            toggleAutoWin(true)
            autoWinButton.Text = "Auto-win: ON"
        end
    end)

    local hideButton = Instance.new("TextButton")
    hideButton.Size = UDim2.new(0, 20, 0, 20)
    hideButton.Position = UDim2.new(1, -25, 0, 5)
    hideButton.Text = "-"
    hideButton.Font = Enum.Font.SourceSansBold
    hideButton.TextSize = 20
    hideButton.TextColor3 = Color3.new(1, 1, 1)
    hideButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    hideButton.Parent = mainFrame
    
    showButton = Instance.new("TextButton")
    showButton.Size = UDim2.new(0, 50, 0, 50)
    showButton.Position = UDim2.new(0.5, -25, 0.5, -25)
    showButton.Text = "CH"
    showButton.Font = Enum.Font.SourceSansBold
    showButton.TextSize = 20
    showButton.TextColor3 = Color3.new(1, 1, 1)
    showButton.BackgroundColor3 = Color3.new(0.5, 0.2, 0.2)
    showButton.Visible = false
    showButton.Parent = screenGui

    hideButton.MouseButton1Click:Connect(function()
        mainFrame.Position = UDim2.new(-1, 0, -1, 0)
        showButton.Visible = true
        menuHidden = true
    end)

    showButton.MouseButton1Click:Connect(function()
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
        showButton.Visible = false
        menuHidden = false
    end)

    return screenGui
end

-- Esperar 5 segundos para que el juego cargue completamente
wait(5)

-- Lógica de inicio
screenGui = createMenu()
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
