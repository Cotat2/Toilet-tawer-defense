-- Script teórico para monedas infinitas en Toilet Legacy Defense
local player = game.Players.LocalPlayer

-- Espera a que los leaderstats carguen
repeat wait() until player:FindFirstChild("leaderstats")
local leaderstats = player.leaderstats

-- Espera a que el valor Coins exista
repeat wait() until leaderstats:FindFirstChild("Coins")
local coins = leaderstats.Coins

-- Función para añadir monedas
local function addCoins(amount)
    coins.Value = coins.Value + amount
    print("Monedas añadidas: "..amount.." | Total: "..coins.Value)
end

-- Poner 1 millón de monedas
addCoins(1000000)

-- Opcional: actualizar periódicamente para Endless Mode
while true do
    wait(5)
    addCoins(5000) -- añade monedas extra cada 5 segundos
end
