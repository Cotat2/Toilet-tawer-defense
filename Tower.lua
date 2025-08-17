-- Script para establecer gemas
-- ¡Cambia el número de gemas a tu gusto!

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GemEvent = ReplicatedStorage:WaitForChild("GemEvent") -- Asumiendo el evento de gemas

local Player = game:GetService("Players").LocalPlayer
local GemsToSet = 10000 -- Aquí puedes poner el número que quieras

local function setGems()
    local oldGems = Player.Gems.Value
    local difference = GemsToSet - oldGems
    
    if difference > 0 then
        GemEvent:FireServer(difference)
    else
        print("Ya tienes suficientes gemas o más. No se enviará ninguna solicitud.")
    end
    print("¡Gemas establecidas a: " .. GemsToSet .. "!")
end

setGems()
