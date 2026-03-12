local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Animations = aetherrequire("./Utility/Animations")

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.New(parent, config)
    local self = setmetatable({}, Dropdown)
    self.Options = config.Options or {}
    self.Expanded = false
    self.CurrentSelection = config.Default or "Select"

    self.ShowName = config.ShowName or false
    self.Name = config.Name
    self.Prefix = config.Prefix

    self.Container = Creator.New("Frame", {
        Name = "DropdownContainer",
        Parent = parent,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.DropdownBg,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0, 260, 0, 26),
        LayoutOrder = config.LayoutOrder or 0
    }, {
        Creator.New("UICorner", {}),
        Creator.New("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
    })

    self.MainButton = Creator.New("TextButton", {
        Name = "DropdownFrame",
        Parent = self.Container,
        BorderSizePixel = 0,
        TextSize = 14,
        AutoButtonColor = false,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Theme.Fonts.Main,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 260, 0, 26),
        Text = "",
        LayoutOrder = 1
    }, {
        Creator.New("ImageLabel", {
            Name = "DropdownLogo",
            ZIndex = -50,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ImageColor3 = Theme.Colors.TextBlue,
            Image = Theme.Assets.DropdownLogo,
            Size = UDim2.new(0, 30, 0, 30),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.84234, 0, -0.07692, 0)
        }),
        Creator.New("TextLabel", {
            Name = "SlectedName",
            TextWrapped = true,
            TextStrokeTransparency = 0.8,
            ZIndex = -50,
            BorderSizePixel = 0,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextStrokeColor3 = Theme.Colors.TextBlue,
            TextScaled = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            FontFace = Theme.Fonts.Main,
            TextColor3 = Theme.Colors.TextBlue,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 166, 0, 24),
            Text = self:FormatSelection(self.CurrentSelection),
            Position = UDim2.new(0.03069, 0, -0.03833, 0)
        })
    })

    self.DropdownLogo = self.MainButton.DropdownLogo
    self.SelectedLabel = self.MainButton.SlectedName
    self.OptionButtons = {}

    for i, option in ipairs(self.Options) do
        local btn = Creator.New("TextButton", {
            Name = "UnSelected",
            Parent = self.Container,
            BorderSizePixel = 0,
            TextSize = 14,
            AutoButtonColor = false,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundColor3 = Theme.Colors.ToggleOffBg,
            FontFace = Theme.Fonts.Main,
            ZIndex = 999999999,
            Size = UDim2.new(0, 260, 0, 26),
            LayoutOrder = i + 1,
            Text = "",
            Visible = false
        }, {
            Creator.New("UICorner", { CornerRadius = UDim.new(0, 6) }),
            Creator.New("TextLabel", {
                Name = "Name",
                TextWrapped = true,
                TextStrokeTransparency = 0.8,
                ZIndex = -50,
                BorderSizePixel = 0,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextStrokeColor3 = Theme.Colors.TextMuted,
                TextScaled = true,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                FontFace = Theme.Fonts.Main,
                TextColor3 = Theme.Colors.TextMuted,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 166, 0, 24),
                Text = option,
                Position = UDim2.new(0.03069, 0, -0.03833, 0)
            })
        })

        btn:SetAttribute("OptionValue", option)
        btn.MouseButton1Click:Connect(function()
            self:SetSelection(option)
            self:Toggle()
            if config.Callback then
                task.spawn(config.Callback, option)
            end
        end)

        table.insert(self.OptionButtons, btn)
    end

    self.MainButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)

    self:SetSelection(self.CurrentSelection)

    return self
end

function Dropdown:SetSelection(option)
    self.CurrentSelection = option
    self.SelectedLabel.Text = self:FormatSelection(option)

    for _, btn in ipairs(self.OptionButtons) do
        local label = btn:FindFirstChildOfClass("TextLabel")
        if btn:GetAttribute("OptionValue") == option then
            btn.Name = "Selected"
            if label then
                label.TextColor3 = Theme.Colors.TextBlue
                label.TextStrokeColor3 = Theme.Colors.TextBlue
            end
        else
            btn.Name = "UnSelected"
            if label then
                label.TextColor3 = Theme.Colors.TextMuted
                label.TextStrokeColor3 = Theme.Colors.TextMuted
            end
        end
    end
end

function Dropdown:FormatSelection(value)
    if self.Prefix then
        return self.Prefix .. value
    end
    if self.ShowName and self.Name then
        return self.Name .. ": " .. value
    end
    return value
end

function Dropdown:Toggle()
    self.Expanded = not self.Expanded
    for _, btn in ipairs(self.OptionButtons) do
        btn.Visible = self.Expanded
    end
    local rot = self.Expanded and 180 or 0
    Animations.Tween(self.DropdownLogo, {0.2}, {Rotation = rot})
end

return Dropdown
