local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")

local Paragraph = {}
Paragraph.__index = Paragraph

function Paragraph.New(parent, config)
    local self = setmetatable({}, Paragraph)

    local showTitle = config.ShowTitle or false

    self.Container = Creator.New("Frame", {
        Name = "DetailCOntainer",
        Parent = parent,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        LayoutOrder = config.LayoutOrder or 0,
        Visible = config.Visible ~= false
    }, {
        Creator.New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
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
            Text = config.Title or "",
            Visible = showTitle,
            AutomaticSize = Enum.AutomaticSize.XY,
            Position = UDim2.new(0.0025, 0, -0.03167, 0)
        }),
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
            Text = config.Text or "",
            BackgroundTransparency = 1
        })
    })

    return self
end

return Paragraph
