local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local NoclipManager = {}

local LocalPlayer = Players.LocalPlayer
local flySpeed = 2
local hrp = nil
local flying = false
local direction = Vector3.zero
local keysPressed = {}
local inputConnectionBegan = nil
local inputConnectionEnded = nil

function NoclipManager.SetSpeed(value)
	if typeof(value) == "number" and value > 0 then
		flySpeed = value
	end
end

local function updateDirection()
	direction = Vector3.zero
	if keysPressed.W then direction += Vector3.new(0, 0, -1) end
	if keysPressed.S then direction += Vector3.new(0, 0, 1) end
	if keysPressed.A then direction += Vector3.new(-1, 0, 0) end
	if keysPressed.D then direction += Vector3.new(1, 0, 0) end
	if keysPressed.Space then direction += Vector3.new(0, 1, 0) end
	if keysPressed.LeftShift then direction += Vector3.new(0, -1, 0) end
end

function NoclipManager.Toggle()
	flying = not flying
	local char = LocalPlayer.Character
	if not char then return end

	hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	hrp.Anchored = flying

	if flying then
		keysPressed = {
			W = UserInputService:IsKeyDown(Enum.KeyCode.W),
			S = UserInputService:IsKeyDown(Enum.KeyCode.S),
			A = UserInputService:IsKeyDown(Enum.KeyCode.A),
			D = UserInputService:IsKeyDown(Enum.KeyCode.D),
			Space = UserInputService:IsKeyDown(Enum.KeyCode.Space),
			LeftShift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
		}
		updateDirection()
	else
		keysPressed = {}
		updateDirection()
	end
end

function NoclipManager.BindInput()
	inputConnectionBegan = UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe or not flying then return end
		local key = input.KeyCode
		if key == Enum.KeyCode.W then keysPressed.W = true
		elseif key == Enum.KeyCode.S then keysPressed.S = true
		elseif key == Enum.KeyCode.A then keysPressed.A = true
		elseif key == Enum.KeyCode.D then keysPressed.D = true
		elseif key == Enum.KeyCode.Space then keysPressed.Space = true
		elseif key == Enum.KeyCode.LeftShift then keysPressed.LeftShift = true end
		updateDirection()
	end)

	inputConnectionEnded = UserInputService.InputEnded:Connect(function(input)
		if not flying then return end
		local key = input.KeyCode
		if key == Enum.KeyCode.W then keysPressed.W = false
		elseif key == Enum.KeyCode.S then keysPressed.S = false
		elseif key == Enum.KeyCode.A then keysPressed.A = false
		elseif key == Enum.KeyCode.D then keysPressed.D = false
		elseif key == Enum.KeyCode.Space then keysPressed.Space = false
		elseif key == Enum.KeyCode.LeftShift then keysPressed.LeftShift = false end
		updateDirection()
	end)
end

RunService.RenderStepped:Connect(function(dt)
	if flying and hrp then
		if direction.Magnitude > 0.01 then
			local cam = workspace.CurrentCamera
			local moveDir = cam.CFrame:VectorToWorldSpace(direction.Unit)
			hrp.CFrame = hrp.CFrame + moveDir * flySpeed * dt * 60
		end
	end
end)

return NoclipManager
