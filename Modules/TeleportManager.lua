-- TeleportManager.lua
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local TeleportManager = {}

function TeleportManager.FindScrollOwner()
	for _, player in ipairs(Players:GetPlayers()) do
		local backpack = player:FindFirstChild("Backpack")
		local character = player.Character

		if backpack and backpack:FindFirstChild("EventScroll") then
			return player
		end

		if character and character:FindFirstChild("EventScroll") then
			return player
		end
	end
	return nil
end

function TeleportManager.FindWorldScroll()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "EventScroll" then
			return obj
		end
	end
	return nil
end

function TeleportManager.TeleportToPlayerScroll(localPlayer, scrollOwner)
	local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
	local targetRoot = scrollOwner.Character and scrollOwner.Character:FindFirstChild("HumanoidRootPart")
	if root and targetRoot then
		root.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
		return true
	end
	return false
end

function TeleportManager.TeleportToWorldScroll(localPlayer, scroll)
	local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
	if root and scroll then
		root.CFrame = scroll.CFrame + Vector3.new(0, 3, 0)
		return true
	end
	return false
end

return TeleportManager
