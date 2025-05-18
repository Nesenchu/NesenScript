-- MainScript.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Загружаем модули
local BindManager = require(script.Modules.BindManager)
local GUIManager = require(script.Modules.GUIManager)
local PlayerManager = require(script.Modules.PlayerManager)
local TeleportManager = require(script.Modules.TeleportManager)
local NoclipManager = require(script.Modules.NoclipManager)

-- Запуск GUI
local screenGui = GUIManager:CreateGUI()

-- Запуск разделов GUI
PlayerManager:Init(screenGui)
TeleportManager:Init(screenGui)
BindManager:Init(screenGui)
NoclipManager:Init(screenGui)

-- Управление переключением интерфейса
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.L then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

-- Обновление Noclip движения
RunService.RenderStepped:Connect(function(dt)
	NoclipManager:Update(dt)
end)
