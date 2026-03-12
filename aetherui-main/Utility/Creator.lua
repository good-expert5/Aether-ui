local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Creator = {}

-- Makes any frame draggable
function Creator.Drag(frame, parent)
    parent = parent or frame
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function Creator.New(className, properties, children)
    local inst = Instance.new(className)
    for prop, val in pairs(properties or {}) do
        pcall(function() inst[prop] = val end)
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

function Creator.Tween(obj, info, props)
    -- FIX: Silently ignore Color on UIGradients to prevent crash
    if obj:IsA("UIGradient") and props.Color then
        local cleanProps = {}
        for k, v in pairs(props) do if k ~= "Color" then cleanProps[k] = v end end
        props = cleanProps
    end
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    return tween
end

return Creator
