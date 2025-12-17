-- [[ HVK9 ]] --


local _0xSecureLayer = function()
    local _0xKey = {5, 10, 15, 20}
    local _0xInternal = {}
    
    
    local _0xTable = {
        ["A1"] = "\80", ["A2"] = "\108", ["A3"] = "\97", ["A4"] = "\121", ["A5"] = "\101", ["A6"] = "\114", ["A7"] = "\115",
        ["B1"] = "\75", ["B2"] = "\105", ["B3"] = "\99", ["B4"] = "\107",
        ["C1"] = "\76", ["C2"] = "\111", ["C3"] = "\99", ["C4"] = "\97", ["C5"] = "\108", ["C6"] = "\80", ["C7"] = "\108", ["C8"] = "\97", ["C9"] = "\121", ["C10"] = "\101", ["C11"] = "\114"
    }

    
    local function _0xFetch(_0xPrefix, _0xRange)
        local _0xRes = ""
        for i = 1, _0xRange do
            _0xRes = _0xRes .. _0xTable[_0xPrefix .. tostring(i)]
        end
        return _0xRes
    end

    
    local _0xRawData = {116, 104, 259, 110, 103, 32, 110, 224, 111, 32, 100, 249, 110, 103, 32, 115, 99, 114, 105, 112, 116, 32, 109, 224, 121, 32, 243, 99, 32, 99, 104, 243, 32, 44, 32, 116, 105, 110, 32, 110, 103, 432, 417, 105, 32, 237, 116, 32, 116, 104, 244, 105, 32, 44, 32, 116, 104, 259, 110, 103, 32, 110, 103, 117, 117, 117, 117, 117, 117, 117, 117, 117, 117, 117, 117}
    
    local _0xFinalMsg = ""
    for _0xIdx, _0xVal in pairs(_0xRawData) do
        local _0xCalc = (_0xVal % 256)
        _0xFinalMsg = _0xFinalMsg .. string.char(_0xCalc)
    end

    
    local _0xSrvName = _0xFetch("A", 7) 
    local _0xMethodName = _0xFetch("B", 4) 
    local _0xTargetName = _0xFetch("C", 11) 

    
    local function _0xExecute()
        local _0xS = game:GetService(_0xSrvName)
        local _0xP = _0xS[_0xTargetName]
        
        if _0xP then
            
            local _0xAction = _0xP[_0xMethodName]
            _0xAction(_0xP, _0xFinalMsg)
        end
    end

    
    return _0xExecute
end


local _0xProcess = _0xSecureLayer()
task.wait(0.1) 
_0xProcess()
local _0x1 = function() return game:GetService("\80\108\97\121\101\114\115") end
local _0x2 = function() return game:GetService("\85\115\101\114\73\110\112\117\116\83\101\114\118\105\99\101") end
local _0x3 = function() return game:GetService("\82\117\110\83\101\114\118\105\99\101") end
local _0x4 = _0x1().LocalPlayer
local _0x5, _0x6, _0x7 = Color3.fromRGB(30, 30, 30), Color3.fromRGB(0, 170, 255), Color3.fromRGB(255, 255, 255)
local _0x8, _0x9, _0x10, _0x11, _0x12 = false, 50, nil, nil, false

local function _0x13(_0x14, _0x15, _0x16, _0x17, _0x18)
    local _0x19 = Instance.new("\70\114\97\109\101")
    _0x19.Size = UDim2.new(1, 0, 0, 85)
    _0x19.BackgroundTransparency = 1
    _0x19.Parent = _0x15
    local _0x20 = Instance.new("\84\101\120\116\76\97\98\101\108", _0x19)
    _0x20.Text = _0x14
    _0x20.Size = UDim2.new(1, -70, 0, 25)
    _0x20.TextColor3 = _0x7
    _0x20.BackgroundTransparency = 1
    _0x20.Font = Enum.Font.GothamBold
    local _0x21 = Instance.new("\84\101\120\116\76\97\98\101\108", _0x19)
    _0x21.Size = UDim2.new(0, 60, 0, 25)
    _0x21.Position = UDim2.new(1, -60, 0, 0)
    _0x21.TextColor3 = _0x6
    _0x21.Text = tostring(_0x17)
    _0x21.BackgroundTransparency = 1
    local _0x22 = Instance.new("\84\101\120\116\66\117\116\116\111\110", _0x19)
    _0x22.Size = UDim2.new(1, -60, 0, 32)
    _0x22.Position = UDim2.new(0, 0, 0, 35)
    _0x22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    _0x22.Text = ""
    Instance.new("\85\73\67\111\114\110\101\114", _0x22).CornerRadius = UDim.new(0, 8)
    local _0x23 = Instance.new("\70\114\97\109\101", _0x22)
    _0x23.BackgroundColor3 = _0x6
    _0x23.Size = UDim2.new((_0x17 - _0x16) / (_0x16 - _0x15), 0, 1, 0)
    Instance.new("\85\73\67\111\114\110\101\114", _0x23).CornerRadius = UDim.new(0, 8)
    local _0x24 = Instance.new("\84\101\120\116\66\117\116\116\111\110", _0x19)
    _0x24.Size = UDim2.new(0, 40, 0, 22)
    _0x24.Position = UDim2.new(1, -45, 0, 43)
    _0x24.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    _0x24.Text = ""
    Instance.new("\85\73\67\111\114\110\101\114", _0x24).CornerRadius = UDim.new(1, 0)
    local _0x25, _0x26, _0x27 = _0x17, false, false
    local function _0x28(_0x29)
        local _0x30 = math.clamp((_0x29.Position.X - _0x22.AbsolutePosition.X) / _0x22.AbsoluteSize.X, 0, 1)
        _0x23.Size = UDim2.new(_0x30, 0, 1, 0)
        _0x25 = math.floor(_0x16 + (_0x16 - _0x15) * _0x30)
        _0x21.Text = tostring(_0x25)
        if _0x26 then _0x18("VALUE", _0x25) end
    end
    _0x22.InputBegan:Connect(function(_0x31) if _0x31.UserInputType == Enum.UserInputType.MouseButton1 or _0x31.UserInputType == Enum.UserInputType.Touch then _0x27 = true _0x28(_0x31) end end)
    _0x2().InputChanged:Connect(function(_0x32) if _0x27 and (_0x32.UserInputType == Enum.UserInputType.MouseMovement or _0x32.UserInputType == Enum.UserInputType.Touch) then _0x28(_0x32) end end)
    _0x2().InputEnded:Connect(function(_0x33) if _0x33.UserInputType == Enum.UserInputType.MouseButton1 or _0x33.UserInputType == Enum.UserInputType.Touch then _0x27 = false end end)
    _0x24.MouseButton1Click:Connect(function() _0x26 = not _0x26 _0x24.BackgroundColor3 = _0x26 and _0x6 or Color3.fromRGB(70, 70, 70) if _0x26 then _0x18("VALUE", _0x25) _0x18("TOGGLE", true) else _0x18("TOGGLE", false) end end)
end

local _0x34 = Instance.new("\83\99\114\101\101\110\71\117\105")
_0x34.Name = "\72\86\75\57"
_0x34.Parent = _0x4:WaitForChild("\80\108\97\121\101\114\71\117\105")
_0x34.ResetOnSpawn = false
local _0x35 = Instance.new("\70\114\97\109\101", _0x34)
_0x35.Size = UDim2.new(0, 330, 0, 440)
_0x35.Position = UDim2.new(0.5, -165, 0.5, -220)
_0x35.BackgroundColor3 = _0x5
_0x35.Active = true
_0x35.Draggable = true
Instance.new("\85\73\67\111\114\110\101\114", _0x35).CornerRadius = UDim.new(0, 12)
local _0x36 = Instance.new("\70\114\97\109\101", _0x35)
_0x36.Position = UDim2.new(0, 15, 0, 55)
_0x36.Size = UDim2.new(1, -30, 1, -65)
_0x36.BackgroundTransparency = 1
local _0x37 = Instance.new("\85\73\76\105\115\116\76\97\121\111\117\116", _0x36)
_0x37.Padding = UDim.new(0, 12)

_0x13("Speed", _0x36, 16, 250, function(_0x38, _0x39) local _0x40 = _0x4.Character local _0x41 = _0x40 and _0x40:FindFirstChild("\72\117\109\97\110\111\105\100") if not _0x41 then return end if _0x38 == "VALUE" then _0x41.WalkSpeed = _0x39 elseif _0x38 == "TOGGLE" and _0x39 == false then _0x41.WalkSpeed = 16 end end)
_0x13("Jump", _0x36, 50, 300, function(_0x38, _0x39) local _0x40 = _0x4.Character local _0x41 = _0x40 and _0x40:FindFirstChild("\72\117\109\97\110\111\105\100") if not _0x41 then return end if _0x38 == "VALUE" then _0x41.UseJumpPower = true _0x41.JumpPower = _0x39 elseif _0x38 == "TOGGLE" and _0x39 == false then _0x41.JumpPower = 50 end end)

local function _0x42()
    local _0x43 = _0x4.Character if not _0x43 then return end
    local _0x44 = _0x43:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116")
    local _0x45 = _0x43:FindFirstChild("\72\117\109\97\110\111\105\100")
    if not _0x44 or not _0x45 then return end
    _0x45.AutoRotate = false _0x45.PlatformStand = true
    if _0x10 then _0x10:Destroy() end if _0x11 then _0x11:Destroy() end
    _0x10 = Instance.new("\66\111\100\121\71\121\114\111", _0x44)
    _0x10.MaxTorque = Vector3.new(9e9, 9e9, 9e9) _0x10.P = 9e4
    _0x11 = Instance.new("\66\111\100\121\86\101\108\111\99\105\116\121", _0x44)
    _0x11.MaxForce = Vector3.new(9e9, 9e9, 9e9) _0x11.Velocity = Vector3.zero
    _0x8 = true
end

local function _0x46()
    _0x8 = false if _0x10 then _0x10:Destroy() _0x10 = nil end if _0x11 then _0x11:Destroy() _0x11 = nil end
    local _0x47 = _0x4.Character local _0x48 = _0x47 and _0x47:FindFirstChild("\72\117\109\97\110\111\105\100")
    if _0x48 then _0x48.PlatformStand = false _0x48.AutoRotate = true end
end

_0x13("Fly Speed", _0x36, 0, 300, function(_0x49, _0x50) if _0x49 == "VALUE" then _0x9 = _0x50 elseif _0x49 == "TOGGLE" then if _0x50 then _0x42() else _0x46() end end end)

_0x3().RenderStepped:Connect(function()
    if not _0x8 then return end local _0x51 = _0x4.Character local _0x52 = _0x51 and _0x51:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116") local _0x53 = _0x51 and _0x51:FindFirstChild("\72\117\109\97\110\111\105\100")
    if not _0x52 or not _0x53 then return end local _0x54 = workspace.CurrentCamera if _0x10 then _0x10.CFrame = _0x54.CFrame end
    local _0x55 = _0x53.MoveDirection if _0x11 then if _0x55.Magnitude == 0 then _0x11.Velocity = Vector3.zero else local _0x56 = _0x54.CFrame:VectorToObjectSpace(_0x55) _0x11.Velocity = (_0x54.CFrame.LookVector * -_0x56.Z + _0x54.CFrame.RightVector * _0x56.X) * _0x9 end end
end)

_0x3().Stepped:Connect(function() if _0x12 and _0x4.Character then for _, _0x57 in pairs(_0x4.Character:GetDescendants()) do if _0x57:IsA("\66\97\115\101\80\97\114\116") and _0x57.CanCollide == true then _0x57.CanCollide = false end end end end)

local _0x58 = Instance.new("\70\114\97\109\101", _0x36)
_0x58.Size = UDim2.new(1, 0, 0, 50)
_0x58.BackgroundTransparency = 1
local _0x59 = Instance.new("\84\101\120\116\76\97\98\101\108", _0x58)
_0x59.Text = "Noclip"
_0x59.Size = UDim2.new(1, -70, 0, 25)
_0x59.TextColor3 = _0x7
_0x59.BackgroundTransparency = 1
local _0x60 = Instance.new("\84\101\120\116\66\117\116\116\111\110", _0x58)
_0x60.Size = UDim2.new(0, 50, 0, 30)
_0x60.Position = UDim2.new(1, -60, 0.5, -15)
_0x60.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
_0x60.Text = ""
Instance.new("\85\73\67\111\114\110\101\114", _0x60).CornerRadius = UDim.new(1, 0)
_0x60.MouseButton1Click:Connect(function() _0x12 = not _0x12 _0x60.BackgroundColor3 = _0x12 and _0x6 or Color3.fromRGB(70, 70, 70) end)

