--!nonstrict
-- Owns the UI instances and event connections created for a component.
local Cleanup = {}
Cleanup.__index = Cleanup

local function release(item)
    local kind = typeof(item)
    if kind == "RBXScriptConnection" then
        item:Disconnect()
    elseif kind == "Instance" then
        item:Destroy()
    elseif type(item) == "function" then
        item()
    else
        error(`Unsupported cleanup item: {kind}`, 2)
    end
end

function Cleanup.new()
    return setmetatable({ _items = {}, _destroyed = false }, Cleanup)
end

function Cleanup:add(item)
    assert(
        typeof(item) == "RBXScriptConnection" or typeof(item) == "Instance" or type(item) == "function",
        "Expected an RBXScriptConnection, Instance, or function"
    )

    if self._destroyed then
        release(item)
    else
        table.insert(self._items, item)
    end
    return item
end

function Cleanup:destroy()
    if self._destroyed then
        return
    end
    self._destroyed = true

    -- Disconnect handlers before destroying the UI tree.
    for i = #self._items, 1, -1 do
        release(self._items[i])
        self._items[i] = nil
    end
end

return Cleanup
