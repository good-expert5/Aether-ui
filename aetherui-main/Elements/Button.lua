local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")

local Button = {}
Button.__index = Button

function Button.New(parent, config)
    local self = setmetatable({}, Button)
    
    self.Instance = Creator.New("TextButton", {
        Name = config.InstanceName or "Button",
        Parent = parent,
        BorderSizePixel = 0,
        TextSize = 14,
        AutoButtonColor = false,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Theme.Colors.ButtonBg,
        FontFace = Theme.Fonts.Main,
        ZIndex = 999999999,
        Size = UDim2.new(0, 260, 0, 50),
        Text = "",
        LayoutOrder = config.LayoutOrder or 0
    }, {
        Creator.New("UICorner", {}),
        Creator.New("TextLabel", {
            Name = "DropdownName",
            TextWrapped = true,
            TextStrokeTransparency = 0.8,
            BorderSizePixel = 0,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextStrokeColor3 = Theme.Colors.TextBlue,
            TextScaled = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            FontFace = Theme.Fonts.Main,
            TextColor3 = Theme.Colors.TextBlue,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 160, 0, 24),
            Text = config.Name,
            Position = UDim2.new(0.22558, 0, 0.26, 0)
        }),
        Creator.New("ImageLabel", {
            Name = "Logo",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ImageColor3 = Theme.Colors.TextBlue,
            Image = config.Icon or Theme.Assets.GeneralIcon,
            Size = UDim2.new(0, 30, 0, 30),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0669, 0, 0.2, 0)
        }),
        Creator.New("UIStroke", {
            Thickness = 5,
            Color = Color3.fromRGB(255, 255, 255),
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner
        }, {
            Creator.New("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.161, 1),
                    NumberSequenceKeypoint.new(0.999, 1),
                    NumberSequenceKeypoint.new(1, 0)
                },
                Color = ColorSequence.new(Theme.Colors.TextBlue)
            })
        }),
        Creator.New("ImageLabel", {
            Name = "Arrow",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ImageColor3 = Theme.Colors.TextBlue,
            Image = Theme.Assets.ArrowIcon,
            Size = UDim2.new(0, 38, 0, 38),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.81421, 0, 0.12, 0)
        })
    })

    self.Instance.MouseButton1Click:Connect(function()
        if config.Callback then
            task.spawn(config.Callback)
        end
    end)

    return self
end

return Button
