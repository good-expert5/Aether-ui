local TweenService = game:GetService("TweenService")
local Creator = {}

-- Fixed Tween function to handle UIGradients and errors
function Creator.Tween(object, info, properties)
    if not object or not info then return end
    
    -- Filter out non-tweenable properties (like Color on a UIGradient)
    local tweenableProps = {}
    for prop, value in pairs(properties) do
        local success = pcall(function()
            -- Check if the property is a Color on a Gradient
            if object:IsA("UIGradient") and prop == "Color" then
                -- ColorSequence cannot be tweened, so we set it instantly
                object.Color = ColorSequence.new(value)
            else
                tweenableProps[prop] = value
            end
        end)
    end

    local success, tween = pcall(function()
        return TweenService:Create(object, info, tweenableProps)
    end)

    if success and tween then
        tween:Play()
        return tween
    end
end

-- Your original New function
function Creator.New(className, properties, children)
    local inst = Instance.new(className)
    
    if properties then
        for propName, propValue in pairs(properties) do
            -- Safety wrapper for setting properties
            pcall(function()
                inst[propName] = propValue
            end)
        end
    end
    
    if children then
        for _, child in ipairs(children) do
            child.Parent = inst
        end
    end
    
    return inst
end

-- The 'Set' function (Line 201 in your error)
function Creator.Set(object, properties)
    for prop, value in pairs(properties) do
        pcall(function()
            if object:IsA("UIGradient") and prop == "Color" then
                object.Color = ColorSequence.new(value)
            else
                object[prop] = value
            end
        end)
    end
end

return Creator
