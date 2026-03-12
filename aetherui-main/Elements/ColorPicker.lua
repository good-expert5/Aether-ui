local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")

local ColorPicker = {}
ColorPicker.__index = ColorPicker

function ColorPicker.New(parent, config)
    local self = setmetatable({}, ColorPicker)

    self.Instance = Creator.New("TextButton", {
        Name = "ColourPickerBox",
        Parent = parent,
        BorderSizePixel = 0,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = config.Default or Theme.Colors.TextBlue,
        FontFace = Theme.Fonts.Main,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0.48077, 0, 0.22, 0),
        Text = "",
        Visible = config.Visible ~= false,
        LayoutOrder = config.LayoutOrder or 0
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 7) })
    })

    self.Instance.MouseButton1Click:Connect(function()
        if config.Callback then
            task.spawn(config.Callback, self.Instance.BackgroundColor3)
        end
    end)

    return self
end

return ColorPicker
