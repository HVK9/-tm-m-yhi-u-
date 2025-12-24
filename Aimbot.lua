local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Cài đặt mặc định
local Settings = {
	Enabled = true,           -- Bật/Tắt Aim
	AimKey = Enum.UserInputType.MouseButton2, -- Mặc định là chuột phải
	FOV = 150,                -- Bán kính vòng tròn nhắm
	Smoothness = 0.1,         -- Độ mượt (càng thấp càng dính, 1 là chậm)
	TargetPart = "Head"       -- Phần cơ thể để nhắm vào
}

local isAiming = false
local currentTarget = nil

--------------------------------------------------------------------------------
-- 1. TẠO GIAO DIỆN NGƯỜI DÙNG (GUI) BẰNG SCRIPT
--------------------------------------------------------------------------------
local ScreenGui = script.Parent

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "AimControlPanel"
MainFrame.Size = UDim2.new(0, 250, 0, 180) -- Kích thước ban đầu
MainFrame.Position = UDim2.new(0.05, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo thả bảng
MainFrame.Parent = ScreenGui

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Aim Assist Dev Tool"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Nút Thu nhỏ / Phóng to (Minimize/Maximize)
local MinMaxBtn = Instance.new("TextButton")
MinMaxBtn.Size = UDim2.new(0, 25, 0, 25)
MinMaxBtn.Position = UDim2.new(1, -30, 0, 2)
MinMaxBtn.Text = "-"
MinMaxBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinMaxBtn.TextColor3 = Color3.white
MinMaxBtn.Parent = MainFrame

-- Nút Chuyển đổi Chuột Trái / Phải
local ToggleKeyBtn = Instance.new("TextButton")
ToggleKeyBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleKeyBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
ToggleKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleKeyBtn.TextColor3 = Color3.white
ToggleKeyBtn.Text = "Nút nhắm: Chuột Phải"
ToggleKeyBtn.Parent = MainFrame

-- Nút Bật / Tắt Aim
local ToggleAimBtn = Instance.new("TextButton")
ToggleAimBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleAimBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Màu xanh lá
ToggleAimBtn.TextColor3 = Color3.white
ToggleAimBtn.Text = "Trạng thái: ĐANG BẬT"
ToggleAimBtn.Parent = MainFrame

--------------------------------------------------------------------------------
-- 2. XỬ LÝ CHỨC NĂNG GUI (Thu nhỏ, Đổi nút)
--------------------------------------------------------------------------------

local isMinimized = false
local originalSize = MainFrame.Size

MinMaxBtn.MouseButton1Click:Connect(function()
	if isMinimized then
		-- Phóng to (Trở về bình thường)
		MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3)
		MinMaxBtn.Text = "-"
		ToggleKeyBtn.Visible = true
		ToggleAimBtn.Visible = true
		isMinimized = false
	else
		-- Thu nhỏ
		originalSize = MainFrame.Size -- Lưu kích thước hiện tại trước khi thu nhỏ
		MainFrame:TweenSize(UDim2.new(0, 150, 0, 30), "Out", "Quad", 0.3)
		MinMaxBtn.Text = "+"
		ToggleKeyBtn.Visible = false
		ToggleAimBtn.Visible = false
		isMinimized = true
	end
end)

ToggleKeyBtn.MouseButton1Click:Connect(function()
	if Settings.AimKey == Enum.UserInputType.MouseButton2 then
		Settings.AimKey = Enum.UserInputType.MouseButton1
		ToggleKeyBtn.Text = "Nút nhắm: Chuột Trái"
	else
		Settings.AimKey = Enum.UserInputType.MouseButton2
		ToggleKeyBtn.Text = "Nút nhắm: Chuột Phải"
	end
end)

ToggleAimBtn.MouseButton1Click:Connect(function()
	Settings.Enabled = not Settings.Enabled
	if Settings.Enabled then
		ToggleAimBtn.Text = "Trạng thái: ĐANG BẬT"
		ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	else
		ToggleAimBtn.Text = "Trạng thái: ĐANG TẮT"
		ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
		isAiming = false
	end
end)

--------------------------------------------------------------------------------
-- 3. LOGIC AIM ASSIST
--------------------------------------------------------------------------------

-- Hàm tìm kẻ địch gần nhất trong vòng tròn (FOV)
local function GetClosestPlayer()
	local closestPlayer = nil
	local shortestDistance = Settings.FOV

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
			local targetPart = player.Character:FindFirstChild(Settings.TargetPart)
			if targetPart then
				-- Chuyển vị trí 3D thành 2D trên màn hình
				local vector, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
				
				if onScreen then
					local mousePos = Vector2.new(Mouse.X, Mouse.Y)
					local distance = (Vector2.new(vector.X, vector.Y) - mousePos).Magnitude

					if distance < shortestDistance then
						closestPlayer = targetPart
						shortestDistance = distance
					end
				end
			end
		end
	end
	return closestPlayer
end

-- Xử lý khi ấn chuột
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	-- Kiểm tra xem nút ấn có trùng với cài đặt không (Chuột trái hay phải)
	if input.UserInputType == Settings.AimKey then
		isAiming = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Settings.AimKey then
		isAiming = false
		currentTarget = nil
	end
end)

-- Vòng lặp chạy mỗi khung hình để di chuyển camera
RunService.RenderStepped:Connect(function()
	if Settings.Enabled and isAiming then
		currentTarget = GetClosestPlayer()
		if currentTarget then
			-- Logic di chuyển Camera (Aim)
			local currentCFrame = Camera.CFrame
			local targetCFrame = CFrame.new(currentCFrame.Position, currentTarget.Position)
			
			-- Lerp giúp camera di chuyển mượt mà thay vì giật cục
			Camera.CFrame = currentCFrame:Lerp(targetCFrame, Settings.Smoothness)
		end
	end
end)
