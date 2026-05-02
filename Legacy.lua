-- Obtener el Humanoid del jugador local
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Lista de estados que suelen tumbar al personaje
local statesToDisable = {
	Enum.HumanoidStateType.FallingDown,
	Enum.HumanoidStateType.PlatformStanding,
	Enum.HumanoidStateType.Physics,
	Enum.HumanoidStateType.Ragdoll -- Si el juego lo usa
}

-- Bucle para desactivar estos estados
for _, stateType in pairs(statesToDisable) do
	Humanoid:SetStateEnabled(stateType, false)
end

-- Asegurar que el estado actual no sea uno de los prohibidos
if table.find(statesToDisable, Humanoid:GetState()) then
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

-- Un bucle extra para juegos muy agresivos con ragdolls
game:GetService("RunService").Stepped:Connect(function()
    Humanoid.PlatformStand = false
    Humanoid.Sit = false -- Por si acaso
end)

print("Anti-Tumbado activado. Ya no deberías quedarte pegado al suelo.")
