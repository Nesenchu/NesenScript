local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Подключение модулей
local GUIManager = loadstring(game:HttpGet("https://yourdomain.com/Modules/GUIManager.lua"))()
local PlayerManager = loadstring(game:HttpGet("https://yourdomain.com/Modules/PlayerManager.lua"))()
local TeleportManager = loadstring(game:HttpGet("https://yourdomain.com/Modules/TeleportManager.lua"))()
local NoclipManager = loadstring(game:HttpGet("https://yourdomain.com/Modules/NoclipManager.lua"))()
local BindManager = loadstring(game:HttpGet("https://yourdomain.com/Modules/BindManager.lua"))()

-- Инициализация интерфейса и логики
GUIManager:Init()
PlayerManager:Init(GUIManager)
TeleportManager:Init(GUIManager)
NoclipManager:Init(GUIManager)
BindManager:Init(GUIManager, TeleportManager, NoclipManager)
