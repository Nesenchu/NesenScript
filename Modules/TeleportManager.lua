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

function TeleportManager:Init(guiManager)
	local LocalPlayer = Players.LocalPlayer
	local tab = guiManager:CreateTab("Свиток")

	local label = Instance.new("TextLabel", tab)
	label.Position = UDim2.new(0, 10, 0, 10)
	label.Size = UDim2.new(1, -20, 0, 30)
	label.Font = Enum.Font.Code
	label.TextSize = 14
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	label.Text = "📍 Телепорт к EventScroll"

	local button = Instance.new("TextButton", tab)
	button.Position = UDim2.new(0, 10, 0, 50)
	button.Size = UDim2.new(0, 250, 0, 30)
	button.Text = "🔍 Найти и телепортироваться"
	button.Font = Enum.Font.Code
	button.TextSize = 14
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.new(1, 1, 1)

	button.MouseButton1Click:Connect(function()
		local scrollOwner = self.FindScrollOwner()
		if scrollOwner then
			local success = self.TeleportToPlayerScroll(LocalPlayer, scrollOwner)
			label.Text = success and ("✅ У игрока: " .. scrollOwner.Name) or "⚠️ Не удалось телепорт"
			return
		end

		local scroll = self.FindWorldScroll()
		if scroll then
			local success = self.TeleportToWorldScroll(LocalPlayer, scroll)
			label.Text = success and "✅ Телепорт к EventScroll" or "⚠️ Не удалось телепорт"
		else
			label.Text = "❌ EventScroll не найден"
		end
	end)
end


return TeleportManager
