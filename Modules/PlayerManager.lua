-- PlayerManager.lua
-- Управление телепортацией к игрокам и списком игроков

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local PlayerManager = {}

PlayerManager.SelectedPlayer = nil

function PlayerManager:GetPlayersList(filter)
	local list = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and (not filter or string.find(plr.Name:lower(), filter:lower())) then
			table.insert(list, plr)
		end
	end
	return list
end

function PlayerManager:SetSelected(player)
	self.SelectedPlayer = player
end

function PlayerManager:TeleportToSelected()
	if not self.SelectedPlayer then return end

	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local target = self.SelectedPlayer.Character and self.SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root and target then
		root.CFrame = target.CFrame + Vector3.new(0, 3, 0)
	end
end

function PlayerManager:Init(guiManager)
	local tab = guiManager:CreateTab("Игроки")

	local searchBox = Instance.new("TextBox", tab)
	searchBox.PlaceholderText = "🔍 Поиск игрока..."
	searchBox.Size = UDim2.new(1, -20, 0, 30)
	searchBox.Position = UDim2.new(0, 10, 0, 10)
	searchBox.Font = Enum.Font.Code
	searchBox.TextSize = 14
	searchBox.TextColor3 = Color3.new(1, 1, 1)
	searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

	local scroll = Instance.new("ScrollingFrame", tab)
	scroll.Position = UDim2.new(0, 10, 0, 50)
	scroll.Size = UDim2.new(1, -20, 1, -60)
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.ScrollBarThickness = 6
	scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	local function updateList(filter)
		scroll:ClearAllChildren()
		local y = 0
		for _, plr in ipairs(self:GetPlayersList(filter)) do
			local btn = Instance.new("TextButton", scroll)
			btn.Size = UDim2.new(1, -10, 0, 30)
			btn.Position = UDim2.new(0, 5, 0, y)
			btn.Text = plr.Name
			btn.Font = Enum.Font.Code
			btn.TextSize = 14
			btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.MouseButton1Click:Connect(function()
				self:SetSelected(plr)
				self:TeleportToSelected()
			end)
			y += 35
		end
		scroll.CanvasSize = UDim2.new(0, 0, 0, y + 10)
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		updateList(searchBox.Text)
	end)

	updateList()
end


return PlayerManager
