local function wrap(func)
    return function(self, ...) 
        func(self, ...) 
        if not IsValid(self.Owner) then return end
        
        local hull = self:GetParent()
        if not IsValid(hull) then return end
        hull:CPPISetOwner(self.Owner)
        
        local yaw = hull:GetParent()
        if not IsValid(yaw) then return end
        yaw:CPPISetOwner(self.Owner)
    end
end

local function wrapInitFunctions()
    local gredBase = scripted_ents.GetStored("gred_emp_base")
    gredBase.t.InitYaw = wrap(gredBase.t.InitYaw)
    gredBase.t.InitHull = wrap(gredBase.t.InitHull)
end

local function waitingFor()
    local gredBase = scripted_ents.GetStored("gred_emp_base")
    return gredBase and gredBase.t.InitHull ~= nil
end

local function onTimeout()
    print("[gredwitch_enhancements] InitHull wrapper timed out")
end

if Waiter then
    Waiter.waitFor(waitingFor, wrapInitFunctions, onTimeout )
else
    WaiterQueue = WaiterQueue or {}

    local struct = {
        waitingFor = waitingFor,
        onSuccess = wrapInitFunctions,
        onTimeout = onTimeout
    }

    table.insert( WaiterQueue, struct )
end
