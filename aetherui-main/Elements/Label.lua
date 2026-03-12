local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")

local Label = {}
Label.__index = Label

function Label.New(parent, config)
    local self = setmetatable({}, Label)

    local hasValue = config.Value ~= nil or config.Title ~= nil or config.ShowValue

    if hasValue then
        self.Container = Creator.New("Frame", {
            Name = config.InstanceName or "StatusCOntainer",
            Parent = parent,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = config.LayoutOrder or 0,
            BackgroundTransparency = 1,
            Visible = config.Visible ~= false
        }, {
            Creator.New("TextLabel", {
                Name = "StatusLable",
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
                Size = UDim2.new(0, 259, 0, 24),
                Text = config.Title or "Status:",
                Position = UDim2.new(0.0025, 0, -0.03167, 0)
            }),
            Creator.New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
            Creator.New("TextBox", {
                Interactable = false,
                TextStrokeTransparency = 0.8,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextStrokeColor3 = Theme.Colors.TextBlue,
                TextSize = 26,
                TextColor3 = Theme.Colors.TextBlue,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                FontFace = Theme.Fonts.Main,
                AutomaticSize = Enum.AutomaticSize.Y,
                ClearTextOnFocus = false,
                Size = UDim2.new(0, 260, 0, 24),
                Text = config.Value or config.Text or "",
                BackgroundTransparency = 1
            })
        })
    else
        self.Instance = Creator.New("TextLabel", {
            Name = config.InstanceName or "SelectNpcLabel",
            Parent = parent,
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
            Size = UDim2.new(0, 259, 0, 24),
            Text = config.Text or "Label",
            LayoutOrder = config.LayoutOrder or 0,
            Visible = config.Visible ~= false
        })
    end

    return self
end

return Label
