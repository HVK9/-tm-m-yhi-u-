--[[
    HVK9 ULTIMATE V15.1 - FIX SYNTAX ERROR <EOF>
    1. Fix lỗi thiếu 'end' gây crash script.
    2. Giữ nguyên toàn bộ logic Portal, Farm, Weapon, UI.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- --- CẤU HÌNH ---
local CONFIG = {
    AutoFarm = false, 
    SelectedMob = nil,
    TargetPosition = nil,
    WeaponType = "Melee",
    
    FlySpeed = 350,
    HoverHeight = 15, 
}

-- --- DATA TỌA ĐỘ (GIỮ NGUYÊN) ---
local MOBS_DB = {
    -- SEA 1
    {Name = "Bandit", Level = 5, Pos = Vector3.new(1060, 16, 1550)}, 
    {Name = "Monkey", Level = 14, Pos = Vector3.new(-1600, 36, 150)},
    {Name = "Gorilla", Level = 20, Pos = Vector3.new(-1240, 6, -500)},
    {Name = "Gorilla King", Level = 25, Pos = Vector3.new(-1130, 6, -450)}, 
    {Name = "Pirate", Level = 35, Pos = Vector3.new(-1130, 4, 3850)},
    {Name = "Brute", Level = 45, Pos = Vector3.new(-1149, 96, 4309)},
    {Name = "Bobby", Level = 55, Pos = Vector3.new(-1152, 57, 4174)}, 
    {Name = "Desert Bandit", Level = 60, Pos = Vector3.new(900, 6, 4380)},
    {Name = "Desert Officer", Level = 70, Pos = Vector3.new(1560, 6, 4380)},
    {Name = "Snow Bandit", Level = 90, Pos = Vector3.new(1380, 87, -1300)},
    {Name = "Snowman", Level = 100, Pos = Vector3.new(1222, 138, -1489)},
    {Name = "Yeti", Level = 105, Pos = Vector3.new(1222, 138, -1489)}, 
    {Name = "Chief Petty Officer", Level = 120, Pos = Vector3.new(-4996, 84, 4154)},
    {Name = "Vice Admiral", Level = 130, Pos = Vector3.new(-5080, 154, 4428)}, 
    {Name = "Sky Bandit", Level = 150, Pos = Vector3.new(-4900, 296, -2900)},
    {Name = "Dark Master", Level = 175, Pos = Vector3.new(-5228, 429, -2279)},
    {Name = "Prisoner", Level = 190, Pos = Vector3.new(5300, 88, 472)},
    {Name = "Dangerous Prisoner", Level = 210, Pos = Vector3.new(5300, 88, 472)},
    {Name = "Warden", Level = 220, Pos = Vector3.new(5284, 94, 922)}, 
    {Name = "Chief Warden", Level = 230, Pos = Vector3.new(5284, 94, 922)}, 
    {Name = "Swan", Level = 240, Pos = Vector3.new(5284, 94, 922)}, 
    {Name = "Toga Warrior", Level = 225, Pos = Vector3.new(-1600, 7, -2800)},
    {Name = "Gladiator", Level = 275, Pos = Vector3.new(-1400, 7, -3100)},
    {Name = "Military Soldier", Level = 300, Pos = Vector3.new(-5514, 62, 8577)},
    {Name = "Military Spy", Level = 325, Pos = Vector3.new(-5779, 119, 8804)},
    {Name = "Magma Admiral", Level = 350, Pos = Vector3.new(-5600, 7, 8500)}, 
    {Name = "Fishman Warrior", Level = 375, Pos = Vector3.new(61120, 18, 1570)}, 
    {Name = "Fishman Commando", Level = 400, Pos = Vector3.new(61120, 18, 1570)},
    {Name = "Fishman Lord", Level = 425, Pos = Vector3.new(-5685, 17, 8648)},
    {Name = "God's Guard", Level = 450, Pos = Vector3.new(-4700, 560, -2000)},
    {Name = "Shanda", Level = 475, Pos = Vector3.new(-7600, 5550, -1400)},
    {Name = "Wysper", Level = 500, Pos = Vector3.new(-7900, 5550, -1600)}, 
    {Name = "Thunder God", Level = 575, Pos = Vector3.new(-7700, 5600, -2300)}, 
    {Name = "Galley Pirate", Level = 625, Pos = Vector3.new(5500, 40, 4000)},
    {Name = "Cyborg", Level = 675, Pos = Vector3.new(6000, 40, 4200)}, 

    -- SEA 2
    {Name = "Raider", Level = 700, Pos = Vector3.new(-480, 72, 1860)},
    {Name = "Mercenary", Level = 725, Pos = Vector3.new(-970, 100, 1600)},
    {Name = "Factory Staff", Level = 775, Pos = Vector3.new(-300, 75, 500)},
    {Name = "Jeremy", Level = 850, Pos = Vector3.new(2300, 450, 700)}, 
    {Name = "Marine Lieutenant", Level = 875, Pos = Vector3.new(-2000, 70, -2600)},
    {Name = "Fajita", Level = 925, Pos = Vector3.new(-2100, 70, -2800)}, 
    {Name = "Zombie", Level = 950, Pos = Vector3.new(-5500, 10, -50)},
    {Name = "Vampire", Level = 975, Pos = Vector3.new(-6000, 10, -50)},
    {Name = "Snow Trooper", Level = 1000, Pos = Vector3.new(700, 400, -1300)},
    {Name = "Lab Subordinate", Level = 1100, Pos = Vector3.new(-5800, 15, -8300)},
    {Name = "Magma Ninja", Level = 1175, Pos = Vector3.new(-5400, 15, -8300)},
    {Name = "Ship Deckhand", Level = 1250, Pos = Vector3.new(920, 125, 32800)},
    {Name = "Arctic Warrior", Level = 1350, Pos = Vector3.new(6000, 28, -6000)},
    {Name = "Awakened Ice Admiral", Level = 1400, Pos = Vector3.new(6400, 30, -6200)}, 
    {Name = "Sea Soldier", Level = 1425, Pos = Vector3.new(-3000, 240, -10000)},
    {Name = "Tide Keeper", Level = 1475, Pos = Vector3.new(-3800, 240, -10800)}, 

    -- SEA 3
    {Name = "Pirate Millionaire", Level = 1500, Pos = Vector3.new(-18, 110, 5806)},
    {Name = "Dragon Crew Warrior", Level = 1575, Pos = Vector3.new(-60, 170, 6179)},
    {Name = "Island Empress", Level = 1675, Pos = Vector3.new(-1194, 103, 6916)}, 
    {Name = "Marine Commodore", Level = 1700, Pos = Vector3.new(2450, 70, -7350)},
    {Name = "Kilo Admiral", Level = 1750, Pos = Vector3.new(2904, 509, -7368)}, 
    {Name = "Fishman Raider", Level = 1775, Pos = Vector3.new(-15350, 330, 240)},
    {Name = "Giant Islander", Level = 1650, Pos = Vector3.new(4900, 1000, 700)},
    {Name = "Forest Pirate", Level = 1825, Pos = Vector3.new(-13300, 330, -350)},
    {Name = "Jungle Pirate", Level = 1900, Pos = Vector3.new(-12100, 330, -1700)},
    {Name = "Beautiful Pirate", Level = 1975, Pos = Vector3.new(-12500, 335, -7500)},
    {Name = "Reborn Skeleton", Level = 1975, Pos = Vector3.new(-8800, 140, 5900)},
    {Name = "Demonic Soul", Level = 2025, Pos = Vector3.new(-9400, 170, 6100)},
    {Name = "Peanut Scout", Level = 2075, Pos = Vector3.new(-2000, 70, -12500)},
    {Name = "Ice Cream Chef", Level = 2125, Pos = Vector3.new(-1000, 70, -12500)},
    {Name = "Cookie Crafter", Level = 2200, Pos = Vector3.new(-2000, 70, -11500)},
    {Name = "Head Baker", Level = 2275, Pos = Vector3.new(-2000, 70, -11800)},
    {Name = "Cocoa Warrior", Level = 2300, Pos = Vector3.new(200, 50, -12200)},
    {Name = "Chocolate Bar Battlers", Level = 2325, Pos = Vector3.new(513, 24, -12394)},
    {Name = "Sweet Thiefs", Level = 2350, Pos = Vector3.new(69, 77, -12643)},
    {Name = "Candy Rebel", Level = 2375, Pos = Vector3.new(800, 50, -12500)},
    {Name = "Candy Pirate", Level = 2400, Pos = Vector3.new(-1800, 40, -14500)},
    {Name = "Isle Outlaw", Level = 2450, Pos = Vector3.new(-16250, 21, -198)},
    {Name = "Sun Kissed Warrior", Level = 2500, Pos = Vector3.new(-16223, 137, 1027)},
    {Name = "boss hiếu liếm", Level = "Lọ Đế Chí Tôn", Pos = Vector3.new(0, 0, 0)},
    {Name = "huy gay", Level = "Gay Ko Đối Thủ", Pos = Vector3.new(0, 0, 0)},
    {Name = "hải xesa", Level = "Đại cao bằng", Pos = Vector3.new(0, 0, 0)},
}

-- --- HỆ THỐNG UI ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HVK-9"
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Text = "H-9"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 18
local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 8)
UICornerBtn.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 350)
MainFrame.Active = true

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 10)
UICornerFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Text = "HVK-9 ULTIMATE"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 20
local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = TitleLabel

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
TitleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TitleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local WeaponBtn = Instance.new("TextButton")
WeaponBtn.Parent = MainFrame
WeaponBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WeaponBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
WeaponBtn.Size = UDim2.new(0.8, 0, 0, 40)
WeaponBtn.Text = "Vũ Khí: Melee"
WeaponBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WeaponBtn.Font = Enum.Font.SourceSansBold
WeaponBtn.TextSize = 18

local weapons = {"Melee", "Blox Fruit", "Sword", "Gun"}
local weaponIndex = 1
WeaponBtn.MouseButton1Click:Connect(function()
    weaponIndex = weaponIndex + 1
    if weaponIndex > #weapons then weaponIndex = 1 end
    CONFIG.WeaponType = weapons[weaponIndex]
    WeaponBtn.Text = "Vũ Khí: " .. CONFIG.WeaponType
end)

local FarmBtn = Instance.new("TextButton")
FarmBtn.Parent = MainFrame
FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FarmBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FarmBtn.Size = UDim2.new(0.8, 0, 0, 50)
FarmBtn.Text = "AUTO FARM: OFF"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Font = Enum.Font.SourceSansBold
FarmBtn.TextSize = 20
FarmBtn.MouseButton1Click:Connect(function()
    CONFIG.AutoFarm = not CONFIG.AutoFarm
    if CONFIG.AutoFarm then
        FarmBtn.Text = "AUTO FARM: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        FarmBtn.Text = "AUTO FARM: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

local MobListFrame = Instance.new("ScrollingFrame")
MobListFrame.Parent = MainFrame
MobListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MobListFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
MobListFrame.Size = UDim2.new(0.8, 0, 0.45, 0)
MobListFrame.CanvasSize = UDim2.new(0, 0, 0, #MOBS_DB * 35)
MobListFrame.ScrollBarThickness = 6
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MobListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

for i, mob in ipairs(MOBS_DB) do
    local btn = Instance.new("TextButton")
    btn.Parent = MobListFrame
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = mob.Name .. " (Lv." .. mob.Level .. ")"
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.MouseButton1Click:Connect(function()
        CONFIG.SelectedMob = mob.Name
        CONFIG.TargetPosition = mob.Pos
        for _, b in pairs(MobListFrame:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end end
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    end)
end

-- --- LOGIC CHÍNH ---

local function EquipWeapon()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    local backpack = LocalPlayer.Backpack
    
    local currentTool = char:FindFirstChildOfClass("Tool")
    if currentTool then
        if CONFIG.WeaponType == "Melee" and currentTool.ToolTip == "Melee" then return end
        if currentTool.ToolTip == CONFIG.WeaponType then return end
    end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            if (CONFIG.WeaponType == "Melee" and tool.ToolTip == "Melee") or (tool.ToolTip == CONFIG.WeaponType) then
                humanoid:EquipTool(tool)
                break
            end
        end
    end
end

RunService.Stepped:Connect(function()
    if CONFIG.AutoFarm then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

local function TweenTo(targetPos)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dist = (hrp.Position - targetPos).Magnitude
    local time = dist / CONFIG.FlySpeed
    
    local bv = hrp:FindFirstChild("AntiFall") or Instance.new("BodyVelocity", hrp)
    bv.Name = "AntiFall"
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    local bg = hrp:FindFirstChild("StableGyro") or Instance.new("BodyGyro", hrp)
    bg.Name = "StableGyro"
    bg.P = 3000
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = CFrame.new(hrp.Position, targetPos) 

    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
    
    if dist < 30 then 
        tween:Cancel()
    end
end

local function CheckAndEnterPortal()
    if not CONFIG.AutoFarm or not CONFIG.SelectedMob then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if string.find(CONFIG.SelectedMob, "Fishman") then
        local entrancePos = Vector3.new(3864, 6, -1926) 
        local insidePos = Vector3.new(61163, 11, 1819)
        if (hrp.Position - insidePos).Magnitude > 4000 then
            TweenTo(entrancePos)
            return true
        end
    end
    return false
end

local function GetClosestMob()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closestMob = nil
    local shortestDist = 9e9 

    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v.Name == CONFIG.SelectedMob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closestMob = v
            end
        end
    end
    return closestMob
end

-- MAIN LOOP (ĐÃ FIX LỖI THIẾU END)
RunService.RenderStepped:Connect(function()
    if CONFIG.AutoFarm and CONFIG.TargetPosition then
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        EquipWeapon()

        local isEnteringPortal = CheckAndEnterPortal()
        if isEnteringPortal then
            -- Đang đi vào cổng, không làm gì cả
        else
            -- Tìm quái để đánh
            local targetMob = GetClosestMob()
            if targetMob then
XXX"; 
    Duration = 5
})
