local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Dragger = aetherrequire("./Utility/Dragger")

local FloatingController = {}

function FloatingController.New(parent, toggleCallback)
    local controller = Creator.New("ImageButton", {
        Name = "UiControler",
        Parent = parent,
        BorderSizePixel = 0,
        ScaleType = Enum.ScaleType.Crop,
        AutoButtonColor = false,
        BackgroundColor3 = Theme.Colors.MainBg,
        Image = Theme.Assets.ControllerLogo,
        Size = UDim2.new(0.0458, 0, 0.07868, 0),
        Position = UDim2.new(0.02586, 0, 0.15949, 0),
        LayoutOrder = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0)
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 15) }),
        Creator.New("UIAspectRatioConstraint", { AspectRatio = 0.99289 }),
        Creator.New("UIStroke", {
            Name = "Type2",
            Thickness = 2,
            Color = Theme.Colors.StrokeWhite
        }, {
            Creator.New("UIGradient", {
                Enabled = false,
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.5, 1),
                    NumberSequenceKeypoint.new(0.501, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
            })
        })
    })

    Dragger.MakeDraggable(controller)

    controller.MouseButton1Click:Connect(function()
        if not controller:GetAttribute("DragMoved") then
            toggleCallback()
        end
    end)

    return controller
end

return FloatingController