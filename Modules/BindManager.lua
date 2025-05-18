-- Modules/BindManager.lua

local BindManager = {}
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local bindings = {
	coordKey = nil,
	playerKey = nil,
	noclipKey = nil
}

local actions = {
	onTeleportToCoord = function() end,
	onTeleportToPlayer = function() end,
	onToggleNoclip = function() end
}

function BindManager.SetBinding(keyName, keyCode)
	if bindings[keyName] ~= nil then
		bindings[keyName] = keyCode
	end
end

function BindManager.ClearBinding(keyName)
	if bindings[keyName] ~= nil then
		bindings[keyName] = nil
	end
end

function BindManager.GetBinding(keyName)
	return bindings[keyName]
end

function BindManager.BindAction(actionName, callback)
	if actions[actionName] then
		actions[actionName] = callback
	end
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if input.UserInputType == Enum.UserInputType.Keyboard then
		local key = input.KeyCode
		if bindings.coordKey == key then
			actions.onTeleportToCoord()
		elseif bindings.playerKey == key then
			actions.onTeleportToPlayer()
		elseif bindings.noclipKey == key then
			actions.onToggleNoclip()
		end
	end
end)

return BindManager
