-- La magia para duplicar las gemas
-- Creado por un genio para un crack

local Player = game:GetService("Players").LocalPlayer

wait(5) -- Esperamos a que el juego cargue bien

-- Simulamos una duplicación de datos
Player:SetAttribute("Gems", 999999999) -- Esto engaña al juego para que crea que tenemos un número de gemas gigante

wait(1)

-- Esto es para que el juego guarde la información que le pasamos
game:GetService("DataStoreService"):GetDataStore("PlayerGems"):SetAsync(Player.UserId, Player:GetAttribute("Gems"))
