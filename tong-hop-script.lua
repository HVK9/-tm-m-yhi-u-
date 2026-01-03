--[[
    HVK9 ULTIMATE V17 - FAST ATTACK RESTORED
    1. Đã tích hợp module Fast Attack từ file bạn cung cấp (Sử dụng Net/RegisterAttack).
    2. FIX LỖI TREO: Khi tắt Auto Farm, nhân vật sẽ rơi xuống đất và di chuyển bình thường ngay lập tức.
    3. Giữ nguyên tính năng nhận diện Sea và Smart Move.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- --- CẤU HÌNH ---
local CONFIG = {
    AutoFarm = false, 
    SelectedMob = nil,
    TargetPosition = nil,
    WeaponType = "Melee",
    
    FlySpeed = 350,
    HoverHeight = 15, 
    AttackDistance = 60, -- Tăng tầm đánh cho Fast Attack
    FastAttackDelay = 0.1 -- Tốc độ đánh siêu nhanh
}

-- --- HỆ THỐNG NHẬN DIỆN SEA ---
local PlaceId = game.PlaceId
local CurrentSea = 1 

if PlaceId == 2753915549 then CurrentSea = 1
elseif PlaceId == 4442272183 then CurrentSea = 2
elseif PlaceId == 7449423635 then CurrentSea = 3
else 
    CurrentSea = 1 
end

-- --- MODULE FAST ATTACK (TỪ FILE CỦA BẠN) ---
-- [Dựa trên file fast attack.txt]
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")

local function IsAlive(character)
    return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
end

local function DoFastAttack()
    -- Logic đánh siêu tốc
    local char = LocalPlayer.Character
    if not char or not IsAlive(char) then return end
    
    -- Chỉ đánh khi đang cầm vũ khí (trừ súng)
    local equipped = char:FindFirstChildOfClass("Tool")
    if not equipped or equipped.ToolTip == "Gun" then return end

    local enemiesFolder = Workspace:WaitForChild("Enemies")
    local othersEnemies = {}
    local basePart = nil

    -- Quét quái xung quanh
    for _, enemy in pairs(enemiesFolder:GetChildren()) do
        local head = enemy:FindFirstChild("Head")
        if head and IsAlive(enemy) then
            local dist = (head.Position - char.HumanoidRootPart.Position).Magnitude
            if dist < CONFIG.AttackDistance then -- Tầm đánh của Fast Attack
                table.insert(othersEnemies, {enemy, head})
                basePart = head
            end
        end
    end

    -- Gửi gói tin đánh (Bypass cooldown)
    if basePart and #othersEnemies > 0 then
        RegisterAttack:FireServer(0)
        RegisterHit:FireServer(basePart, othersEnemies)
    end
end

-- Chạy Fast Attack trong luồng riêng
task.spawn(function()
    while true do
        if CONFIG.AutoFarm then
            pcall(function()
                DoFastAttack()
            end)
        end
        task.wait(CONFIG.FastAttackDelay) -- Tốc độ cực nhanh
    end
end)

-- --- DATA TỌA ĐỘ ---
local MOBS_DB = {
    -- SEA 1
    {Name = "Bandit", Level = 5, Pos = Vector3.new(1060, 16, 1550), Sea = 1}, 
    {Name = "Monkey", Level = 14, Pos = Vector3.new(-1600, 36, 150), Sea = 1},
    {Name = "Gorilla", Level = 20, Pos = Vector3.new(-1240, 6, -500), Sea = 1},
    {Name = "Gorilla King", Level = 25, Pos = Vector3.new(-1130, 6, -450), Sea = 1}, 
    {Name = "Pirate", Level = 35, Pos = Vector3.new(-1130, 4, 3850), Sea = 1},
    {Name = "Brute", Level = 45, Pos = Vector3.new(-1149, 96, 4309), Sea = 1},
    {Name = "Chef", Level = 55, Pos = Vector3.new(-1152, 57, 4174), Sea = 1}, 
    {Name = "Desert Bandit", Level = 60, Pos = Vector3.new(900, 6, 4380), Sea = 1},
    {Name = "Desert Officer", Level = 70, Pos = Vector3.new(1560, 6, 4380), Sea = 1},
    {Name = "Snow Bandit", Level = 90, Pos = Vector3.new(1380, 87, -1300), Sea = 1},
    {Name = "Snowman", Level = 100, Pos = Vector3.new(1222, 138, -1489), Sea = 1},
    {Name = "Yeti", Level = 105, Pos = Vector3.new(1222, 138, -1489), Sea = 1}, 
    {Name = "Chief Petty Officer", Level = 120, Pos = Vector3.new(-4996, 84, 4154), Sea = 1},
    {Name = "Vice Admiral", Level = 130, Pos = Vector3.new(-5080, 154, 4428), Sea = 1}, 
    {Name = "Sky Bandit", Level = 150, Pos = Vector3.new(-4900, 296, -2900), Sea = 1},
    {Name = "Dark Master", Level = 175, Pos = Vector3.new(-5228, 429, -2279), Sea = 1},
    {Name = "Prisoner", Level = 190, Pos = Vector3.new(5300, 88, 472), Sea = 1},
    {Name = "Dangerous Prisoner", Level = 210, Pos = Vector3.new(5300, 88, 472), Sea = 1},
    {Name = "Warden", Level = 220, Pos = Vector3.new(5284, 94, 922), Sea = 1}, 
    {Name = "Chief Warden", Level = 230, Pos = Vector3.new(5284, 94, 922), Sea = 1}, 
    {Name = "Swan", Level = 240, Pos = Vector3.new(5284, 94, 922), Sea = 1}, 
    {Name = "Toga Warrior", Level = 225, Pos = Vector3.new(-1600, 7, -2800), Sea = 1},
    {Name = "Gladiator", Level = 275, Pos = Vector3.new(-1400, 7, -3100), Sea = 1},
    {Name = "Military Soldier", Level = 300, Pos = Vector3.new(-5514, 62, 8577), Sea = 1},
    {Name = "Military Spy", Level = 325, Pos = Vector3.new(-5779, 119, 8804), Sea = 1},
    {Name = "Magma Admiral", Level = 350, Pos = Vector3.new(-5600, 7, 8500), Sea = 1}, 
    {Name = "Fishman Warrior", Level = 375, Pos = Vector3.new(248, 248, 248), Sea = 1}, 
    {Name = "Fishman Commando", Level = 400, Pos = Vector3.new(248, 248, 248), Sea = 1},
    {Name = "Fishman Lord", Level = 425, Pos = Vector3.new(248, 248, 248), Sea = 1},
    {Name = "God's Guard", Level = 450, Pos = Vector3.new(-4700, 560, -2000), Sea = 1},
    {Name = "Shanda", Level = 475, Pos = Vector3.new(-7600, 5550, -1400), Sea = 1},
    {Name = "Wysper", Level = 500, Pos = Vector3.new(-7900, 5550, -1600), Sea = 1}, 
    {Name = "Thunder God", Level = 575, Pos = Vector3.new(-7700, 5600, -2300), Sea = 1}, 
    {Name = "Galley Pirate", Level = 625, Pos = Vector3.new(5500, 40, 4000), Sea = 1},
    {Name = "Cyborg", Level = 675, Pos = Vector3.new(6000, 40, 4200), Sea = 1}, 

    -- SEA 2
    {Name = "Raider", Level = 700, Pos = Vector3.new(-480, 72, 1860), Sea = 2},
    {Name = "Mercenary", Level = 725, Pos = Vector3.new(-970, 100, 1600), Sea = 2},
    {Name = "Factory Staff", Level = 775, Pos = Vector3.new(-300, 75, 500), Sea = 2},
    {Name = "Jeremy", Level = 850, Pos = Vector3.new(2300, 450, 700), Sea = 2}, 
    {Name = "Marine Lieutenant", Level = 875, Pos = Vector3.new(-2000, 70, -2600), Sea = 2},
    {Name = "Fajita", Level = 925, Pos = Vector3.new(-2100, 70, -2800), Sea = 2}, 
    {Name = "Zombie", Level = 950, Pos = Vector3.new(-5500, 10, -50), Sea = 2},
    {Name = "Vampire", Level = 975, Pos = Vector3.new(-6000, 10, -50), Sea = 2},
    {Name = "Snow Trooper", Level = 1000, Pos = Vector3.new(700, 400, -1300), Sea = 2},
    {Name = "Lab Subordinate", Level = 1100, Pos = Vector3.new(-5800, 15, -8300), Sea = 2},
    {Name = "Magma Ninja", Level = 1175, Pos = Vector3.new(-5400, 15, -8300), Sea = 2},
    {Name = "Ship Deckhand", Level = 1250, Pos = Vector3.new(920, 125, 32800), Sea = 2},
    {Name = "Arctic Warrior", Level = 1350, Pos = Vector3.new(6000, 28, -6000), Sea = 2},
    {Name = "Awakened Ice Admiral", Level = 1400, Pos = Vector3.new(6400, 30, -6200), Sea = 2}, 
    {Name = "Sea Soldier", Level = 1425, Pos = Vector3.new(-3000, 240, -10000), Sea = 2},
    {Name = "Tide Keeper", Level = 1475, Pos = Vector3.new(-3800, 240, -10800), Sea = 2}, 

    -- SEA 3
    {Name = "Pirate Millionaire", Level = 1500, Pos = Vector3.new(-18, 110, 5806), Sea = 3},
    {Name = "Dragon Crew Warrior", Level = 1575, Pos = Vector3.new(-60, 170, 6179), Sea = 3},
    {Name = "Island Empress", Level = 1675, Pos = Vector3.new(-1194, 103, 6916), Sea = 3}, 
    {Name = "Marine Commodore", Level = 1700, Pos = Vector3.new(2450, 70, -7350), Sea = 3},
    {Name = "Kilo Admiral", Level = 1750, Pos = Vector3.new(2904, 509, -7368), Sea = 3}, 
    {Name = "Fishman Raider", Level = 1775, Pos = Vector3.new(-15350, 330, 240), Sea = 3},
    {Name = "Giant Islander", Level = 1650, Pos = Vector3.new(4900, 1000, 700), Sea = 3},
    {Name = "Forest Pirate", Level = 1825, Pos = Vector3.new(-13300, 330, -350), Sea = 3},
    {Name = "Jungle Pirate", Level = 1900, Pos = Vector3.new(-12100, 330, -1700), Sea = 3},
    {Name = "Beautiful Pirate", Level = 1975, Pos = Vector3.new(-12500, 335, -7500), Sea = 3},
    {Name = "Reborn Skeleton", Level = 1975, Pos = Vector3.new(-8800, 140, 5900), Sea = 3},
    {Name = "Demonic Soul", Level = 2025, Pos = Vector3.new(-9400, 170, 6100), Sea = 3},
    {Name = "Peanut Scout", Level = 2075, Pos = Vector3.new(-2000, 70, -12500), Sea = 3},
    {Name = "Ice Cream Chef", Level = 2125, Pos = Vector3.new(-1000, 70, -12500), Sea = 3},
    {Name = "Cookie Crafter", Level = 2200, Pos = Vector3.new(-2000, 70, -11500), Sea = 3},
    {Name = "Head Baker", Level = 2275, Pos = Vector3.new(-2000, 70, -11800), Sea = 3},
    {Name = "Cocoa Warrior", Level = 2300, Pos = Vector3.new(200, 50, -12200), Sea = 3},
    {Name = "Chocolate Bar Battlers", Level = 2325, Pos = Vector3.new(513, 24, -12394), Sea = 3},
    {Name = "Sweet Thiefs", Level = 2350, Pos = Vector3.new(69, 77, -12643), Sea = 3},
    {Name = "Candy Rebel", Level = 2375, Pos = Vector3.new(800, 50, -12500), Sea = 3},
    {Name = "Candy Pirate", Level = 2400, Pos = Vector3.new(-1800, 40, -14500), Sea = 3},
    {Name = "Isle Outlaw", Level = 2450, Pos = Vector3.new(-16250, 21, -198), Sea = 3},
    {Name = "Sun Kissed Warrior", Level = 2500, Pos = Vector3.new(-16223, 137, 1027), Sea = 3},
}

-- --- UI SETUP ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HVK-9"
if pcall(function() ScreenGui.Parent = CoreGui end) then else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

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
TitleLabel.Text = "HVK-9 V17 (Sea " .. CurrentSea .. ")"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 16
local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = TitleLabel

-- Toggle Button (Nút bật tắt UI)
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
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Kéo thả UI
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

-- Nút Chọn Vũ Khí
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

-- --- NÚT BẬT TẮT AUTO FARM (ĐÃ SỬA LỖI TREO) ---
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
        -- [QUAN TRỌNG] FIX LỖI TREO: Dọn dẹp ngay khi tắt
        FarmBtn.Text = "AUTO FARM: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Xóa lực nâng
            local bv = char.HumanoidRootPart:FindFirstChild("AntiFall")
            if bv then bv:Destroy() end
            -- Reset vận tốc để rơi xuống
            char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- Danh sách quái
local MobListFrame = Instance.new("ScrollingFrame")
MobListFrame.Parent = MainFrame
MobListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MobListFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
MobListFrame.Size = UDim2.new(0.8, 0, 0.45, 0)
MobListFrame.ScrollBarThickness = 6
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MobListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local mobsCount = 0
for i, mob in ipairs(MOBS_DB) do
    if mob.Sea == CurrentSea then
        mobsCount = mobsCount + 1
        local btn = Instance.new("TextButton")
        btn.Parent = MobListFrame
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.Text = mob.Name .. " (Lv." .. mob.Level .. ")"
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        btn.MouseButton1Click:Connect(function()
            CONFIG.SelectedMob = mob.Name
            CONFIG.TargetPosition = mob.Pos
            for _, b in pairs(MobListFrame:GetChildren()) do 
                if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end 
            end
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        end)
    end
end
MobListFrame.CanvasSize = UDim2.new(0, 0, 0, mobsCount * 35)

-- --- LOGIC DI CHUYỂN ---
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

local function SmartMove(targetPos)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dist = (hrp.Position - targetPos).Magnitude
    
    -- Nếu gần thì CFrame để đánh cho dính
    if dist < 30 then
        hrp.CFrame = CFrame.new(targetPos)
        
        -- Giữ lơ lửng để không bị rơi khi đánh
        local bv = hrp:FindFirstChild("AntiFall") or Instance.new("BodyVelocity", hrp)
        bv.Name = "AntiFall"
        bv.Velocity = Vector3.zero
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        return
    end

    -- Nếu xa thì bay Tween
    local time = dist / CONFIG.FlySpeed
    
    -- Tạo lực nâng để bay
    local bv = hrp:FindFirstChild("AntiFall") or Instance.new("BodyVelocity", hrp)
    bv.Name = "AntiFall"
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
end

local function GetClosestMob()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closestMob = nil
    local shortestDist = 9e9 

    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            -- Tìm gần đúng tên (VD: Bandit tìm thấy Bandit Lv.5)
            if (v.Name == CONFIG.SelectedMob) or string.find(v.Name, CONFIG.SelectedMob) then 
                local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestMob = v
                end
            end
        end
    end
    return closestMob
end

-- VÒNG LẶP CHÍNH
RunService.RenderStepped:Connect(function()
    if CONFIG.AutoFarm and CONFIG.SelectedMob then
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Tắt va chạm để bay mượt
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end

        EquipWeapon()

        local targetMob = GetClosestMob()
        if targetMob then
            local mobHrp = targetMob:FindFirstChild("HumanoidRootPart")
            if mobHrp then
                local attackPos = mobHrp.Position + Vector3.new(0, CONFIG.HoverHeight, 0)
                SmartMove(attackPos)
                -- Fast Attack đang chạy ở luồng riêng (task.spawn ở trên)
            end
        else
            -- Không có quái -> Bay về điểm chờ
            if CONFIG.TargetPosition then
                SmartMove(CONFIG.TargetPosition + Vector3.new(0, 50, 0))
            end
        end
    end
end)
