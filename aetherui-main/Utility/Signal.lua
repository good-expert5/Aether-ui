local Signal = {}
Signal.__index = Signal

function Signal.New()
    local self = setmetatable({}, Signal)
    self.Connections = {}
    return self
end

function Signal:Connect(callback)
    local connection = {
        Callback = callback,
        Connected = true
    }
    
    function connection:Disconnect()
        self.Connected = false
    end
    
    table.insert(self.Connections, connection)
    return connection
end

function Signal:Fire(...)
    for _, connection in ipairs(self.Connections) do
        if connection.Connected then
            task.spawn(connection.Callback, ...)
        end
    end
end

return Signal