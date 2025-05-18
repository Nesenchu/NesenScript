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

return PlayerManager
