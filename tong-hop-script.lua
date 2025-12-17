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
