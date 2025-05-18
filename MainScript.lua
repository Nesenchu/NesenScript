-- MainScript.lua (Executor Loader)

local repo = "https://raw.githubusercontent.com/Nesenchu/NesenScript/master/Modules/"

-- Загружаем модули
local BindManager      = loadstring(game:HttpGet(repo .. "BindManager.lua"))()
local GUIManager       = loadstring(game:HttpGet(repo .. "GUIManager.lua"))()
local PlayerManager    = loadstring(game:HttpGet(repo .. "PlayerManager.lua"))()
local TeleportManager  = loadstring(game:HttpGet(repo .. "TeleportManager.lua"))()
local NoclipManager    = loadstring(game:HttpGet(repo .. "NoclipManager.lua"))()

-- Службы
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Инициализация GUI
GUIManager:Init()
local screenGui = GUIManager:GetScreenGui()

-- Инициализация всех подсистем
PlayerManager:Init(GUIManager)
TeleportManager:Init(GUIManager)
BindManager:Init(GUIManager)
NoclipManager:BindInput()

-- Переключение GUI (кнопка L)
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.L then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

-- Обновление движения ноуклипа
RunService.RenderStepped:Connect(function(dt)
	NoclipManager:Update(dt)
end)
