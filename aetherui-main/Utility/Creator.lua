local Creator = {}

function Creator.New(className, properties, children)
    local inst = Instance.new(className)
    
    if properties then
        for propName, propValue in pairs(properties) do
            inst[propName] = propValue
        end
    end
    
    if children then
        for _, child in ipairs(children) do
            child.Parent = inst
        end
    end
    
    return inst
end

return Creator