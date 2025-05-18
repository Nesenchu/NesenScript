-- Modules/GUIManager.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GUIManager = {}

GUIManager.ScreenGui = nil
GUIManager.MainFrame = nil
GUIManager.ContentFrame = nil
GUIManager.TabPages = {}

-- 🔷 Функция скругления
local function roundify(ui, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 6)
	corner.Parent = ui
end

function GUIManager:Init()
	-- Создание основного GUI
	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "TPMenuGUI"
	self.ScreenGui.ResetOnSpawn = false
	self.ScreenGui.Parent = LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("CoreGui")

	local mainContainer = Instance.new("Frame", self.ScreenGui)
	mainContainer.Size = UDim2.new(0, 520, 0, 445)
	mainContainer.Position = UDim2.new(0.5, -260, 0.5, -222)
	mainContainer.BackgroundTransparency = 1

	-- Заголовок для перетаскивания
	local titleBar = Instance.new("Frame", mainContainer)
	titleBar.Size = UDim2.new(1, 0, 0, 25)
	titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	titleBar.BorderSizePixel = 0
	roundify(titleBar)

	-- Главный фрейм
	self.MainFrame = Instance.new("Frame", mainContainer)
	self.MainFrame.Size = UDim2.new(0, 520, 0, 420)
	self.MainFrame.Position = UDim2.new(0, 0, 0, 25)
	self.MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	self.MainFrame.BorderSizePixel = 0
	roundify(self.MainFrame)

	-- Панель вкладок
	local tabPanel = Instance.new("Frame", self.MainFrame)
	tabPanel.Size = UDim2.new(0, 110, 1, 0)
	tabPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	tabPanel.BorderSizePixel = 0
	roundify(tabPanel)

	-- Область контента
	local contentFrame = Instance.new("Frame", self.MainFrame)
	contentFrame.Size = UDim2.new(1, -110, 1, 0)
	contentFrame.Position = UDim2.new(0, 110, 0, 0)
	contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	contentFrame.BorderSizePixel = 0
	roundify(contentFrame)

	self.ContentFrame = contentFrame
end

function GUIManager:CreateTab(name)
	local tab = Instance.new("Frame", self.ContentFrame)
	tab.Size = UDim2.new(1, 0, 1, 0)
	tab.BackgroundTransparency = 1
	tab.Visible = false
	self.TabPages[name] = tab
	return tab
end

function GUIManager:SwitchTab(name)
	for tabName, frame in pairs(self.TabPages) do
		frame.Visible = (tabName == name)
	end
end

function GUIManager:GetScreenGui()
	return self.ScreenGui
end

function GUIManager:GetTab(name)
	return self.TabPages[name]
end

function GUIManager:GetMainFrame()
	return self.MainFrame
end

return GUIManager
