local UserInputService = game:GetService("UserInputService")

local Dragger = {}

function Dragger.MakeDraggable(dragTarget)
    local dragStart = nil
    local startPosition = nil
    local activeInput = nil
    local dragging = false
    local movedDuringDrag = false
    local dragThreshold = 6
    
    dragTarget.Active = true
    dragTarget:SetAttribute("DragMoved", false)
    
    local function resetDragFlag()
        task.delay(0.2, function()
            if not dragging then
                dragTarget:SetAttribute("DragMoved", false)
            end
        end)
    end
    
    local function updatePosition(input)
        local delta = input.Position - dragStart
        if delta.Magnitude >= dragThreshold then
            movedDuringDrag = true
            dragTarget:SetAttribute("DragMoved", true)
        end
        dragTarget.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
    
    dragTarget.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            movedDuringDrag = false
            dragStart = input.Position
            startPosition = dragTarget.Position
            activeInput = input
            dragTarget:SetAttribute("DragMoved", false)
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    activeInput = nil
                    if not movedDuringDrag then
                        dragTarget:SetAttribute("DragMoved", false)
                    end
                    resetDragFlag()
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == activeInput then
            updatePosition(input)
        end
    end)
end

return Dragger