--[[
    HVK9 ULTIMATE V14 - FULL STABLE & GATEWAY EDITION
    - Cơ chế: Anti-Shake (Chống rung), Noclip (Xuyên tường), Auto-Gateway (Qua cổng).
    - Lưu ý: Giữ nguyên danh sách quái và đảo của người dùng.
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

-- --- CẤU HÌNH HỆ THỐNG ---
local CONFIG = {
    AutoFarm = false, 
    SelectedMob = nil,
    TargetPosition = nil,
    WeaponType = "Melee",
    FlySpeed = 300,
    HoverHeight = 15,
}

-- --- DATA TỌA ĐỘ (GIỮ NGUYÊN 100% THEO YÊU CẦU) ---
local MOBS_DB = {
    -- ================= SEA 1 =================
    {Name = "Bandit", Level = 5, Pos = Vector3.new(1060, 16, 1550)}, 
    {Name = "Monkey", Level = 14, Pos = Vector3.new(-1600, 36, 150)},
    {Name = "Gorilla", Level = 20, Pos = Vector3.new(-1240, 6, -500)},
    {Name = "Gorilla King", Level = 25, Pos = Vector3.new(-1130, 6, -450)},
    {Name = "Pirate", Level = 35, Pos = Vector3.new(-1130, 4, 3850)},
    {Name = "Brute", Level = 45, Pos = Vector3.new(-1300, 4, 3850)},
    {Name = "Bobby", Level = 55, Pos = Vector3.new(-1130, 4, 3850)},
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

    -- ================= SEA 2 =================
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

    -- ================= SEA 3 =================
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

-- --- HỆ THỐNG CỔNG DỊCH CHUYỂN ---
local SPECIAL_GATES = {
    ["Fishman_S1"] = { GatePos = Vector3.new(3864, 6, -1926), TargetKeys = {"Fishman", "Lord"}, Action = "Touch" },
    ["CursedShip_S2"] = { GatePos = Vector3.new(920, 125, 32800), TargetKeys = {"Ship Deckhand", "Ship Engineer", "Ship Officer"}, Action = "Touch" },
    ["TikiSub_S3"] = { GatePos = Vector3.new(-16100, 20, 500), TargetKeys = {"Sun Kissed", "Isle Outlaw"}, Action = "NPC" }
}

-- --- HỆ THỐNG UI ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HVK-9"
pcall(function() ScreenGui.Parent = CoreGui end)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Text = "H-9"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Visible = false

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local FarmBtn = Instance.new("TextButton")
FarmBtn.Parent = MainFrame
FarmBtn.Size = UDim2.new(0.8, 0, 0, 40)
FarmBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
FarmBtn.Text = "AUTO FARM: OFF"
FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

FarmBtn.MouseButton1Click:Connect(function()
    CONFIG.AutoFarm = not CONFIG.AutoFarm
    FarmBtn.Text = CONFIG.AutoFarm and "AUTO FARM: ON" or "AUTO FARM: OFF"
    FarmBtn.BackgroundColor3 = CONFIG.AutoFarm and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

local MobList = Instance.new("ScrollingFrame")
MobList.Parent = MainFrame
MobList.Size = UDim2.new(0.9, 0, 0.65, 0)
MobList.Position = UDim2.new(0.05, 0, 0.3, 0)
MobList.CanvasSize = UDim2.new(0, 0, 0, #MOBS_DB * 35)
local UIList = Instance.new("UIListLayout")
UIList.Parent = MobList

for _, v in ipairs(MOBS_DB) do
    local b = Instance.new("TextButton")
    b.Parent = MobList
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Text = v.Name
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function()
        CONFIG.SelectedMob = v.Name
        CONFIG.TargetPosition = v.Pos
        StarterGui:SetCore("SendNotification", {Title = "Đã chọn", Text = v.Name})
    end)
end

-- --- CORE LOGIC ---

-- 1. Fast Attack & Damage
task.spawn(function()
    while task.wait(0.05) do
        if CONFIG.AutoFarm then
            pcall(function()
                ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer(0)
                for _, e in pairs(Workspace.Enemies:GetChildren()) do
                    if e:FindFirstChild("HumanoidRootPart") and (e.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 60 then
                        ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(e.HumanoidRootPart, {e})
                    end
                end
            end)
        end
    end
end)

-- 2. Noclip (Xuyên tường)
RunService.Stepped:Connect(function()
    if CONFIG.AutoFarm and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- 3. Hàm Bay Tween
local function TweenTo(pos)
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - pos).Magnitude
    if dist < 10 then return end
    
    local bv = hrp:FindFirstChild("HVK_BV") or Instance.new("BodyVelocity", hrp)
    bv.Name = "HVK_BV"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero

    TweenService:Create(hrp, TweenInfo.new(dist/CONFIG.FlySpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
end

-- 4. Vòng lặp chính xử lý Cổng và Farm ổn định
RunService.RenderStepped:Connect(function()
    if CONFIG.AutoFarm and CONFIG.TargetPosition then
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart

        -- A. Kiểm tra cổng dịch chuyển
        local distToTarget = (hrp.Position - CONFIG.TargetPosition).Magnitude
        local needsGate = nil
        if distToTarget > 4000 then
            for _, gate in pairs(SPECIAL_GATES) do
                for _, key in ipairs(gate.TargetKeys) do
                    if string.find(CONFIG.SelectedMob, key) then needsGate = gate break end
                end
            end
        end

        if needsGate then
            local distToGate = (hrp.Position - needsGate.GatePos).Magnitude
            if distToGate > 20 then
                TweenTo(needsGate.GatePos)
            else
                hrp.CFrame = CFrame.new(needsGate.GatePos)
                if needsGate.Action == "NPC" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SubmarineTicket")
                end
                task.wait(1)
            end
            return
        end

        -- B. Logic Farm ổn định (Anti-Shake)
        local targetMob = nil
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v.Name == CONFIG.SelectedMob and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                targetMob = v; break
            end
        end

        if targetMob then
            local farmPos = targetMob.HumanoidRootPart.Position + Vector3.new(0, CONFIG.HoverHeight, 0)
            
            -- Khóa tư thế ổn định: Không LookAt để tránh rung camera
            hrp.CFrame = CFrame.new(farmPos)
            
            -- Khóa vận tốc
            local bv = hrp:FindFirstChild("HVK_BV") or Instance.new("BodyVelocity", hrp)
            bv.Name = "HVK_BV"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.zero

            -- Khóa thăng bằng (Quan trọng để ko bị đảo nhân vật)
            local bg = hrp:FindFirstChild("HVK_BG") or Instance.new("BodyGyro", hrp)
            bg.Name = "HVK_BG"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.P = 5000
            bg.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(1,0,0)) -- Khóa hướng nhìn thẳng
        else
            TweenTo(CONFIG.TargetPosition)
        end
    else
        -- Dọn dẹp khi tắt farm
        pcall(function()
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if hrp:FindFirstChild("HVK_BV") then hrp.HVK_BV:Destroy() end
            if hrp:FindFirstChild("HVK_BG") then hrp.HVK_BG:Destroy() end
        end)
    end
end)
