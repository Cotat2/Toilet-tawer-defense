-- Script with a Hub-style menu for Delta (Final Version 2.8 - Teleport to Base)

-- Main variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lastMenuInstance = nil

-- Function states
local multipleJumpEnabled = false
local wallhackEnabled = false
local fakeInvisibilityEnabled = false
local speedHackEnabled = false
local advancedNoclipEnabled = false
local teleportToBaseEnabled = false
local noclipLoop = nil
local baseLocation = nil
local gemsDupeEnabled = false
local fastAttackEnabled = false
local glitchEnemiesEnabled = false
local glitchEnemiesConnection = nil
local fastAttackConnection = nil
local enemyPositions = {} -- Table to store enemy positions

-- Variables for Fake Invisibility
local ghostClone = nil

-- Function to handle Multiple Jump
local function handleJump(humanoid)
    if multipleJumpEnabled then
        if humanoid and humanoid.Health > 0 then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

-- Function to toggle Multiple Jump
local function toggleMultipleJump(state, humanoid)
    multipleJumpEnabled = state
    if state then
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if input.KeyCode == Enum.KeyCode.Space and not gameProcessedEvent then
                handleJump(humanoid)
            end
        end)
    end
end

-- Function to toggle Wallhack (ESP)
local function toggleWallhack(state)
    wallhackEnabled = state
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                local head = player.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("PlayerESP") == nil then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Name = "PlayerESP"
                    billboardGui.Size = UDim2.new(0, 100, 0, 50)
                    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    billboardGui.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Text = player.Name
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Enum.Font.SourceSans
                    textLabel.TextSize = 14
                    textLabel.TextColor3 = Color3.new(1, 0, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Parent = billboardGui

                    billboardGui.Parent = head
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local esp = player.Character.Head:FindFirstChild("PlayerESP")
                if esp then
                    esp:Destroy()
                end
            end
        end
    end
end

-- Function for Fake Invisibility
local function toggleFakeInvisibility(state)
    fakeInvisibilityEnabled = state
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    if state then
        -- Create a visual clone of the avatar
        ghostClone = character:Clone()
        ghostClone.Name = "GhostClone"
        ghostClone.Parent = workspace
        
        -- Make the clone unmovable
        for _, part in pairs(ghostClone:GetChildren()) do
            if part:IsA("BasePart") then
                part.Anchored = true
                part.CanCollide = false
            end
        end
        
        -- Make the real avatar invisible locally
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 1
            end
        end
    else
        -- Delete the clone and restore the visibility of the real avatar
        if ghostClone then
            ghostClone:Destroy()
            ghostClone = nil
        end
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

-- Function to toggle Speed Hack
local function toggleSpeedHack(state)
    speedHackEnabled = state
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if state then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = 16
    end
end

-- ADVANCED NOCLIP FUNCTION
local function toggleAdvancedNoclip(state)
    advancedNoclipEnabled = state

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local camera = workspace.CurrentCamera
    local speed = 1.5 

    if state then
        -- Disable collision locally
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        humanoid.WalkSpeed = 0 

        noclipLoop = RunService.Heartbeat:Connect(function()
            if advancedNoclipEnabled then
                local moveVector = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - camera.CFrame.RightVector
                end

                if moveVector.Magnitude > 0 then
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveVector.Unit * speed
                end
            end
        end)
    else
        -- Restore collision, speed, and disconnect the loop
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        humanoid.WalkSpeed = 16
        if noclipLoop then
            noclipLoop:Disconnect()
            noclipLoop = nil
        end
    end
end

-- NEW FUNCTION: Teleport to Base
local function toggleTeleportToBase(state)
    teleportToBaseEnabled = state

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    if state then
        -- Save the current position
        baseLocation = humanoidRootPart.CFrame
        return "Base saved."
    else
        -- Teleport to the saved position
        if baseLocation then
            humanoidRootPart.CFrame = baseLocation
            return "Teleport to base completed."
        else
            return "No base saved."
        end
    end
end

-- NEW FUNCTION: Gem Dupe
local function toggleGemsDupe()
    local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("GemsEvent")
    remoteEvent:FireServer("AddGems", 100) -- Duplicate 100 gems
    return "100 gems duplicated. Adding gems!"
end

-- NEW FUNCTION: Instant Attack Speed
local function toggleFastAttack(state)
    fastAttackEnabled = state
    if state then
        fastAttackConnection = RunService.Heartbeat:Connect(function()
            for _, unit in pairs(workspace:GetDescendants()) do
                if unit.Name == "Dark Speakerman Guy" and unit:IsA("Model") then
                    local attackRemote = unit:FindFirstChild("AttackRemote")
                    if attackRemote and attackRemote:IsA("RemoteEvent") then
                        attackRemote:FireServer("Attack")
                    end
                end
            end
        end)
    else
        if fastAttackConnection then
            fastAttackConnection:Disconnect()
            fastAttackConnection = nil
        end
    end
end

-- NEW FUNCTION: Glitch Enemies (more subtle slow effect)
local function toggleGlitchEnemies(state)
    glitchEnemiesEnabled = state
    if state then
        glitchEnemiesConnection = RunService.Heartbeat:Connect(function()
            for _, obj in pairs(game.Workspace:GetDescendants()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                local humanoidRootPart = obj:FindFirstChild("HumanoidRootPart")
                -- Check if it's an enemy
                if humanoid and humanoidRootPart and obj.Name ~= LocalPlayer.Name then
                    if not enemyPositions[obj] then
                        -- Store the initial position
                        enemyPositions[obj] = humanoidRootPart.CFrame
                    else
                        -- Teleport the enemy back to its previous position
                        humanoidRootPart.CFrame = enemyPositions[obj]
                        -- Update the position for the next frame
                        enemyPositions[obj] = humanoidRootPart.CFrame
                    end
                end
            end
        end)
    else
        if glitchEnemiesConnection then
            glitchEnemiesConnection:Disconnect()
            glitchEnemiesConnection = nil
            enemyPositions = {} -- Clear the table when disabled
        end
    end
end

-- NEW FUNCTION: Add unlimited cash
local function addMoney()
    local playerStats = LocalPlayer:FindFirstChild("leaderstats")
    if playerStats then
        local cash = playerStats:FindFirstChild("Cash")
        if cash then
            cash.Value = math.huge -- Give an inexhaustible amount
            return "Unlimited cash added. Build non-stop!"
        end
    end
    return "Could not find cash value. Try again."
end


-- Function that creates the menu and its logic
local function createMenu()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("HubMenu") then
        playerGui:FindFirstChild("HubMenu"):Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HubMenu"
    screenGui.Parent = playerGui
    
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
        button.TextScaled = true
        button.Parent = navFrame
        return button
    end

    local mainButton = createTabButton("  Main", 40)
    local stealerButton = createTabButton("  Stealer", 80)
    local helperButton = createTabButton("  Helper", 120)
    local playerButton = createTabButton("  Player", 160)
    local finderButton = createTabButton("  Finder", 200)
    local serverButton = createTabButton("  Server", 240)
    local discordButton = createTabButton("  Discord!", 280)

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -150, 1, -40)
    contentFrame.Position = UDim2.new(0, 150, 0, 40)
    contentFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    contentFrame.Parent = mainFrame

    local currentTab
    local function changeTab(tabFrame)
        if currentTab then
            currentTab.Visible = false
        end
        currentTab = tabFrame
        currentTab.Visible = true
    end

    local mainTab = Instance.new("Frame")
    mainTab.Size = UDim2.new(1, 0, 1, 0)
    mainTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    mainTab.Parent = contentFrame
    mainTab.Visible = false

    local playerTab = Instance.new("Frame")
    playerTab.Size = UDim2.new(1, 0, 1, 0)
    playerTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    playerTab.Parent = contentFrame
    playerTab.Visible = false

    local stealerTab = Instance.new("Frame")
    stealerTab.Size = UDim2.new(1, 0, 1, 0)
    stealerTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    stealerTab.Parent = contentFrame
    stealerTab.Visible = false

    local helperTab = Instance.new("Frame")
    helperTab.Size = UDim2.new(1, 0, 1, 0)
    helperTab.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    helperTab.Parent = contentFrame
    helperTab.Visible = false

    mainButton.MouseButton1Click:Connect(function() changeTab(mainTab) end)
    playerButton.MouseButton1Click:Connect(function() changeTab(playerTab) end)
    stealerButton.MouseButton1Click:Connect(function() changeTab(stealerTab) end)
    helperButton.MouseButton1Click:Connect(function() changeTab(helperTab) end)

    changeTab(mainTab)

    -- Player Tab (Empty)
    
    -- Stealer Tab (Empty)
    
    -- Helper Tab
    local moneyButton = Instance.new("TextButton")
    moneyButton.Size = UDim2.new(0, 180, 0, 40)
    moneyButton.Position = UDim2.new(0, 20, 0, 20)
    moneyButton.Text = "Unlimited Cash"
    moneyButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    moneyButton.Parent = helperTab
    moneyButton.MouseButton1Click:Connect(function()
        local message = addMoney()
        print(message)
    end)
    
    local gemsDupeButton = Instance.new("TextButton")
    gemsDupeButton.Size = UDim2.new(0, 180, 0, 40)
    gemsDupeButton.Position = UDim2.new(0, 20, 0, 70)
    gemsDupeButton.Text = "Gem Dupe"
    gemsDupeButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    gemsDupeButton.Parent = helperTab
    gemsDupeButton.MouseButton1Click:Connect(function()
        local message = toggleGemsDupe()
        print(message)
    end)

    local fastAttackButton = Instance.new("TextButton")
    fastAttackButton.Size = UDim2.new(0, 180, 0, 40)
    fastAttackButton.Position = UDim2.new(0, 20, 0, 120)
    fastAttackButton.Text = "Instant Attack Speed: OFF"
    fastAttackButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    fastAttackButton.Parent = helperTab
    fastAttackButton.MouseButton1Click:Connect(function()
        toggleFastAttack(not fastAttackEnabled)
        fastAttackButton.Text = "Instant Attack Speed: " .. (fastAttackEnabled and "ON" or "OFF")
    end)
    
    local glitchEnemiesButton = Instance.new("TextButton")
    glitchEnemiesButton.Size = UDim2.new(0, 180, 0, 40)
    glitchEnemiesButton.Position = UDim2.new(0, 20, 0, 170)
    glitchEnemiesButton.Text = "Glitch Enemies: OFF"
    glitchEnemiesButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    glitchEnemiesButton.Parent = helperTab
    glitchEnemiesButton.MouseButton1Click:Connect(function()
        toggleGlitchEnemies(not glitchEnemiesEnabled)
        glitchEnemiesButton.Text = "Glitch Enemies: " .. (glitchEnemiesEnabled and "ON" or "OFF")
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

    local showButton = Instance.new("TextButton")
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
        mainFrame.Visible = false
        showButton.Visible = true
    end)

    showButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        showButton.Visible = false
    end)

    local mouse = LocalPlayer:GetMouse()
    mouse.Icon = ""
    
    return screenGui
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    if lastMenuInstance then
        lastMenuInstance.Parent = LocalPlayer.PlayerGui
    else
        lastMenuInstance = createMenu()
        lastMenuInstance.Parent = LocalPlayer.PlayerGui
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
