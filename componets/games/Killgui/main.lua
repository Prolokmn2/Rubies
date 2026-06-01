
-- thou shalt not steal.

setclipboard("discord.gg/dd4XXRMz8b")
-- Instances: 21 | Scripts: 7 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.KillGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[KillGui]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;


-- StarterGui.KillGui.MainFrame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Size"] = UDim2.new(0, 359, 0, 194);
G2L["2"]["Position"] = UDim2.new(0.42844, 0, 0.13253, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[MainFrame]];


-- StarterGui.KillGui.MainFrame.TopBar2
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(192, 57, 43);
G2L["3"]["Size"] = UDim2.new(0, 360, 0, 20);
G2L["3"]["Position"] = UDim2.new(-0.00144, 0, -0.02749, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Name"] = [[TopBar2]];


-- StarterGui.KillGui.MainFrame.TopBar
G2L["4"] = Instance.new("Frame", G2L["2"]);
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(231, 76, 60);
G2L["4"]["Size"] = UDim2.new(0, 360, 0, 51);
G2L["4"]["Position"] = UDim2.new(-0.00144, 0, 0.05298, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Name"] = [[TopBar]];


-- StarterGui.KillGui.MainFrame.TopBar.Title
G2L["5"] = Instance.new("TextLabel", G2L["4"]);
G2L["5"]["TextWrapped"] = true;
G2L["5"]["ZIndex"] = 3;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 54;
G2L["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5"]["TextScaled"] = true;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(168, 235, 255);
G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Light, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Size"] = UDim2.new(0, 91, 0, 35);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[Kill GUI]];
G2L["5"]["Name"] = [[Title]];
G2L["5"]["Position"] = UDim2.new(0.40498, 0, 0.09302, 0);


-- StarterGui.KillGui.MainFrame.Pages
G2L["6"] = Instance.new("Frame", G2L["2"]);
G2L["6"]["ZIndex"] = 2;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(236, 241, 241);
G2L["6"]["ClipsDescendants"] = true;
G2L["6"]["Size"] = UDim2.new(0, 360, 0, 131);
G2L["6"]["Position"] = UDim2.new(-0.00144, 0, 0.32064, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[Pages]];


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive
G2L["7"] = Instance.new("Frame", G2L["6"]);
G2L["7"]["ZIndex"] = 2;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(236, 241, 241);
G2L["7"]["Size"] = UDim2.new(0, 360, 0, 131);
G2L["7"]["Position"] = UDim2.new(0, 0, -0.00763, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Name"] = [[PageAbusive]];


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.E
G2L["8"] = Instance.new("TextLabel", G2L["7"]);
G2L["8"]["TextWrapped"] = true;
G2L["8"]["TextSize"] = 19;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
G2L["8"]["BackgroundTransparency"] = 1;
G2L["8"]["Size"] = UDim2.new(0.50087, 0, 0.18148, 0);
G2L["8"]["Text"] = [[Hold E and click to select]];
G2L["8"]["Name"] = [[E]];
G2L["8"]["Position"] = UDim2.new(0.26332, 0, -0.0297, 0);


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3
G2L["9"] = Instance.new("Frame", G2L["7"]);
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(192, 57, 43);
G2L["9"]["Size"] = UDim2.new(0.96772, 0, 0.63249, 0);
G2L["9"]["Position"] = UDim2.new(0.01588, 0, 0.35805, 0);
G2L["9"]["Name"] = [[othersBaseBackground3]];


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.Kill
G2L["a"] = Instance.new("TextButton", G2L["9"]);
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["TextSize"] = 22;
G2L["a"]["TextColor3"] = Color3.fromRGB(236, 241, 241);
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(231, 76, 60);
G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["a"]["Size"] = UDim2.new(0, 149, 0, 25);
G2L["a"]["Text"] = [[Kill]];
G2L["a"]["Name"] = [[Kill]];
G2L["a"]["Position"] = UDim2.new(0.528, 0, 0.172, 0);


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.Kill.LocalScript
G2L["b"] = Instance.new("LocalScript", G2L["a"]);



-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.LoopKill
G2L["c"] = Instance.new("TextButton", G2L["9"]);
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextSize"] = 22;
G2L["c"]["TextColor3"] = Color3.fromRGB(236, 241, 241);
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(231, 76, 60);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["c"]["Size"] = UDim2.new(0, 149, 0, 25);
G2L["c"]["Text"] = [[LoopKill]];
G2L["c"]["Name"] = [[LoopKill]];
G2L["c"]["Position"] = UDim2.new(0.528, 0, 0.525, 0);


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.LoopKill.LocalScript
G2L["d"] = Instance.new("LocalScript", G2L["c"]);



-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchKill
G2L["e"] = Instance.new("TextButton", G2L["9"]);
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextSize"] = 22;
G2L["e"]["TextColor3"] = Color3.fromRGB(236, 241, 241);
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(232, 77, 61);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["e"]["Size"] = UDim2.new(0, 149, 0, 25);
G2L["e"]["Text"] = [[TouchKill]];
G2L["e"]["Name"] = [[TouchKill]];
G2L["e"]["Position"] = UDim2.new(0.05741, 0, 0.17241, 0);


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchKill.LocalScript
G2L["f"] = Instance.new("LocalScript", G2L["e"]);



-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchFling
G2L["10"] = Instance.new("TextButton", G2L["9"]);
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["TextSize"] = 22;
G2L["10"]["TextColor3"] = Color3.fromRGB(236, 241, 241);
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(232, 77, 61);
G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["10"]["Size"] = UDim2.new(0, 149, 0, 25);
G2L["10"]["Text"] = [[TouchFling]];
G2L["10"]["Name"] = [[TouchFling]];
G2L["10"]["Position"] = UDim2.new(0.05741, 0, 0.52517, 0);


-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchFling.LocalScript
G2L["11"] = Instance.new("LocalScript", G2L["10"]);



-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.TXTBOX_PlrName
G2L["12"] = Instance.new("TextBox", G2L["7"]);
G2L["12"]["CursorPosition"] = -1;
G2L["12"]["Name"] = [[TXTBOX_PlrName]];
G2L["12"]["ZIndex"] = 2;
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["TextWrapped"] = true;
G2L["12"]["TextSize"] = 14;
G2L["12"]["TextScaled"] = true;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(245, 248, 249);
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["12"]["Size"] = UDim2.new(0.86788, 0, 0.18262, 0);
G2L["12"]["Position"] = UDim2.new(0.09405, 0, 0.14838, 0);
G2L["12"]["BorderColor3"] = Color3.fromRGB(39, 175, 97);
G2L["12"]["Text"] = [[]];


-- StarterGui.KillGui.MainFrame.Smooth GUI Dragging
G2L["13"] = Instance.new("LocalScript", G2L["2"]);
G2L["13"]["Name"] = [[Smooth GUI Dragging]];


-- StarterGui.KillGui.txtbox
G2L["14"] = Instance.new("LocalScript", G2L["1"]);
G2L["14"]["Name"] = [[txtbox]];


-- StarterGui.KillGui.LocalScript
G2L["15"] = Instance.new("LocalScript", G2L["1"]);



-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.Kill.LocalScript
local function C_b()
local script = G2L["b"];
	script.Parent.MouseButton1Click:Connect(function()
			local targetName = script.Parent.Parent.Parent:WaitForChild("TXTBOX_PlrName").Text:lower():gsub("%s+", "")
			if targetName == "" then return end
			local target = nil
			for _, p in ipairs(game.Players:GetPlayers()) do
				if p ~= game.Players.LocalPlayer then
					if p.Name:lower():find(targetName) or (p.DisplayName or ""):lower():find(targetName) then
						target = p break
					end
				end
			end
			if not target or not target.Character then
				script.Parent.Text = "No Target!"
				task.delay(2, function() script.Parent.Text = "Kill" end)
				return
			end
			local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
			local theirroot = target.Character.HumanoidRootPart
			local origin = hrp.CFrame
			hrp.CFrame = theirroot.CFrame
			local t = 0
			local c = game:GetService("RunService").Heartbeat:Connect(function(dt)
				t = t + dt
				hrp.CFrame = theirroot.CFrame
				sethiddenproperty(game.Players.LocalPlayer.Character.Humanoid, "MoveDirectionInternal", Vector3.new(0/0, 0/0, 0/0))
				pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", theirroot) end)
			end)
			task.wait(1)
			c:Disconnect()
			pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
			hrp.CFrame = origin
		end)
end;
task.spawn(C_b);
-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.LoopKill.LocalScript
local function C_d()
local script = G2L["d"];
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local player = Players.LocalPlayer
	
	local button = script.Parent
	local defaultColor = button.BackgroundColor3
	local darkerColor = Color3.fromRGB(
		math.clamp(defaultColor.R * 255 - 20, 0, 255),
		math.clamp(defaultColor.G * 255 - 20, 0, 255),
		math.clamp(defaultColor.B * 255 - 20, 0, 255)
	)
	
	local enabled = false
	local target = nil
	local isFLinging = false
	
	local function GetTarget()
		local targetName = script.Parent.Parent.Parent:WaitForChild("TXTBOX_PlrName").Text:lower():gsub("%s+", "")
		if targetName == "" then return nil end
		for _, p in ipairs(Players:GetPlayers()) do
			if p == player then continue end
			if p.Name:lower():find(targetName) or (p.DisplayName or ""):lower():find(targetName) then
				return p
			end
		end
		return nil
	end
	
	local function freezeCamera()
		local cam = workspace.CurrentCamera
		local frozenCFrame = cam.CFrame
		cam.CameraType = Enum.CameraType.Scriptable
		cam.CFrame = frozenCFrame
	end
	
	local function unfreezeCamera()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		workspace.CurrentCamera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
	end
	
	local function doFling()
		if not enabled or isFLinging then return end
		local character = target and target.Character
		local theirroot = character and character:FindFirstChild("HumanoidRootPart")
		local mychar = player.Character
		local hrp = mychar and mychar:FindFirstChild("HumanoidRootPart")
		if not hrp or not theirroot then return end
	
		isFLinging = true
	
		local origin = hrp.CFrame
	
		freezeCamera()
	
		hrp.CFrame = theirroot.CFrame
	
		local t = 0
		local c = RunService.Heartbeat:Connect(function(dt)
			t = t + dt
			if not hrp or not hrp.Parent or not theirroot or not theirroot.Parent then return end
			hrp.CFrame = theirroot.CFrame
			sethiddenproperty(mychar.Humanoid, "MoveDirectionInternal", Vector3.new(0/0, 0/0, 0/0))
			pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", theirroot) end)
		end)
	
		task.wait(1)
	
		c:Disconnect()
		pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
	
		-- teleport back
		if hrp and hrp.Parent then
			hrp.CFrame = origin
			hrp.Velocity = Vector3.new()
			hrp.AssemblyLinearVelocity = Vector3.new()
			hrp.AssemblyAngularVelocity = Vector3.new()
			hrp.RotVelocity = Vector3.new()
		end
	
		task.wait(0.1)
	
		unfreezeCamera()
	
		isFLinging = false
	end
	
	local function hookTarget()
		if not target then return end
		target.CharacterAdded:Connect(function()
			if not enabled then return end
			task.wait(0.5)
			doFling()
		end)
	end
	
	button.MouseButton1Click:Connect(function()
		enabled = not enabled
	
		if enabled then
			target = GetTarget()
			if not target then
				button.Text = "No Target!"
				enabled = false
				task.delay(2, function() if button.Text == "No Target!" then button.Text = "LoopKill" end end)
				return
			end
			button.BackgroundColor3 = darkerColor
			hookTarget()
			doFling()
		else
			button.Text = "LoopKill"
			button.BackgroundColor3 = defaultColor
			isFLinging = false
			unfreezeCamera()
			target = nil
		end
	end)
end;
task.spawn(C_d);
-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchKill.LocalScript
local function C_f()
local script = G2L["f"];
	local c
	local defaultColor = script.Parent.BackgroundColor3
	local darkerColor = Color3.fromRGB(
		math.clamp(defaultColor.R * 255 - 30, 0, 255),
		math.clamp(defaultColor.G * 255 - 30, 0, 255),
		math.clamp(defaultColor.B * 255 - 30, 0, 255)
	)
	script.Parent.MouseButton1Click:Connect(function()
		if c then c:Disconnect() c = nil
			script.Parent.BackgroundColor3 = defaultColor
		else c = game:GetService("RunService").Heartbeat:Connect(function()
				sethiddenproperty(game.Players.LocalPlayer.Character.Humanoid, "MoveDirectionInternal", Vector3.new(0/0, 0/0, 0/0))
			end) script.Parent.BackgroundColor3 = darkerColor end
	end)
end;
task.spawn(C_f);
-- StarterGui.KillGui.MainFrame.Pages.PageAbusive.othersBaseBackground3.TouchFling.LocalScript
local function C_11()
local script = G2L["11"];
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local enabled = false
	local movel = 0.1
	
	local defaultColor = script.Parent.BackgroundColor3
	local darkerColor = Color3.fromRGB(
		math.clamp(defaultColor.R * 255 - 30, 0, 255),
		math.clamp(defaultColor.G * 255 - 30, 0, 255),
		math.clamp(defaultColor.B * 255 - 30, 0, 255)
	)
	
	script.Parent.MouseButton1Click:Connect(function()
		enabled = not enabled
		script.Parent.BackgroundColor3 = enabled and darkerColor or defaultColor
		if enabled then
			coroutine.wrap(function()
				while enabled do
					RunService.Heartbeat:Wait()
					local c = Players.LocalPlayer.Character
					local hrp = c and c:FindFirstChild("HumanoidRootPart")
					if hrp then
						local vel = hrp.Velocity
						hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
						RunService.RenderStepped:Wait()
						hrp.Velocity = vel
						RunService.Stepped:Wait()
						hrp.Velocity = vel + Vector3.new(0, movel, 0)
						movel = -movel
					end
				end
			end)()
		end
	end)
end;
task.spawn(C_11);
-- StarterGui.KillGui.MainFrame.Smooth GUI Dragging
local function C_13()
local script = G2L["13"];
	local UserInputService = game:GetService("UserInputService")
	local runService = (game:GetService("RunService"));
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	function Lerp(a, b, m)
		return a + (b - a) * m
	end;
	
	local lastMousePos
	local lastGoalPos
	local DRAG_SPEED = (15); -- // The speed of the UI darg.
	function Update(dt)
		if not (startPos) then return end;
		if not (dragging) and (lastGoalPos) then
			gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
			return 
		end;
	
		local delta = (lastMousePos - UserInputService:GetMouseLocation())
		local xGoal = (startPos.X.Offset - delta.X);
		local yGoal = (startPos.Y.Offset - delta.Y);
		lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
	end;
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			lastMousePos = UserInputService:GetMouseLocation()
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	runService.Heartbeat:Connect(Update)
	
end;
task.spawn(C_13);
-- StarterGui.KillGui.txtbox
local function C_14()
local script = G2L["14"];
	local E_SELECT = true
	
	local UIS = game:GetService("UserInputService")
	local Players = game:GetService("Players")
	
	local EHeld = false
	
	for _, v in ipairs(script.Parent:GetDescendants()) do
		if v:IsA("TextBox") and v.Name ~= "TXTBOX_Chat" and v.Name ~= "TXTBOX_Stats" then
			v.Text = "Player"
		end
	end
	
	
	UIS.InputBegan:Connect(function(input, gp)
		if not gp and input.KeyCode == Enum.KeyCode.E then
			EHeld = true
		end
	end)
	
	UIS.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.E then
			EHeld = false
		end
	end)
	
	
	local mouse = Players.LocalPlayer:GetMouse()
	
	mouse.Button1Down:Connect(function()
		if E_SELECT and EHeld and mouse.Target then
			local clickedPlayer = Players:GetPlayerFromCharacter(mouse.Target:FindFirstAncestorOfClass("Model"))
	
			if clickedPlayer then
				for _, v in ipairs(script.Parent:GetDescendants()) do
					if v:IsA("TextBox") and v.Name ~= "TXTBOX_Chat" and v.Name ~= "TXTBOX_Stats" then
						v.Text = clickedPlayer.Name
					end
				end
			end
		end
	end)
end;
task.spawn(C_14);
-- StarterGui.KillGui.LocalScript
local function C_15()
local script = G2L["15"];
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Discord";
			Text = "Like this script? The discord has been copied!";
			Duration = 35;
		})
	end)
	
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "OUTDATED / PATCHED";
			Text = "This script is OUTDATED AND PATCHED! Check the discord.";
			Duration = 35;
		})
	end)
	
	
	task.wait(0.5)
	
	if typeof(sethiddenproperty) ~= "function" then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "OPF:R",
			Text = "No sethiddenproperty! Will most likly not work",
			Duration = 10
		})
	end
	
end;
task.spawn(C_15);

return G2L["1"], require;