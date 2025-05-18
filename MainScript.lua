-- Загружаем модули с GitHub
local repo = "https://raw.githubusercontent.com/Nesenchu/NesenScript/master/Modules/"

local BindManager     = loadstring(game:HttpGet(repo .. "BindManager.lua"))()
local GUIManager      = loadstring(game:HttpGet(repo .. "GUIManager.lua"))()
local PlayerManager   = loadstring(game:HttpGet(repo .. "PlayerManager.lua"))()
local TeleportManager = loadstring(game:HttpGet(repo .. "TeleportManager.lua"))()
local NoclipManager   = loadstring(game:HttpGet(repo .. "NoclipManager.lua"))()

-- Службы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Инициализация GUI
local screenGui = GUIManager:CreateGUI()

-- Инициализация разделов
PlayerManager:Init(screenGui)
TeleportManager:Init(screenGui)
BindManager:Init(screenGui)
NoclipManager:Init(screenGui)

-- Переключение интерфейса на L
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.L then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

-- Обновление noclip в каждом кадре
RunService.RenderStepped:Connect(function(dt)
	NoclipManager:Update(dt)
end)
