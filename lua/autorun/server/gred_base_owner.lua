local function wrapInitHull()
    local gredBase = scripted_ents.GetStored("gred_emp_base")
    local init = gredBase.t.InitHull
    
    gredBase.t.InitHull = function(self, ...) 
        init(self, ...) 
        parent = self:GetParent()
        parent:CPPISetOwner(self.Owner)
    end
end

local function waitingFor()
    local gredBase = scripted_ents.GetStored("gred_emp_base")
    return gredBase and gredBase.t.InitHull ~= nil
end

local function onTimeout()
    print("[gredwitch_enhancements] InitHull wrapper timed out")
end

if Waiter then
    Waiter.waitFor(waitingFor, wrapInitHull, onTimout )
else
    WaiterQueue = WaiterQueue or {}

    local struct = {
        waitingFor = waitingFor,
        onSuccess = wrapInitHull,
        onTimeout = onTimout
    }

    table.insert( WaiterQueue, struct )
end
