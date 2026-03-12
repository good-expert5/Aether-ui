local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Column = aetherrequire("./Components/Column")

local Tab = {}
Tab.__index = Tab

function Tab.New(window, name, iconId, layoutOrder)
    local self = setmetatable({}, Tab)
    self.Window = window
    self.Name = name

    -- keep track of how many sections have been added to each column so we can
    -- assign a sensible layout order automatically.  this prevents the common
    -- issue where every section had LayoutOrder=0 and the list layout would
    -- display them in an unpredictable order.
    self.Side1SectionCount = 0
    self.Side2SectionCount = 0

    self.Button = Creator.New("TextButton", {
        Name = name,
        Parent = window.SidebarScroll,
        BorderSizePixel = 0,
        TextSize = 14,
        AutoButtonColor = false,
        BackgroundColor3 = Theme.Colors.ButtonBg,
        FontFace = Theme.Fonts.Main,
        Size = UDim2.new(0, 250, 0, 50),
        LayoutOrder = layoutOrder,
        Text = "",
        BackgroundTransparency = 1
    }, {
        Creator.New("UICorner", {}),
        Creator.New("Frame", {
            Name = "Status",
            BorderSizePixel = 0,
            BackgroundColor3 = Theme.Colors.TextBlue,
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(-0.02816, 0, 0.34, 0),
            BackgroundTransparency = 1
        }, { Creator.New("UICorner", { CornerRadius = UDim.new(0, 100) }) }),
        Creator.New("TextLabel", {
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
            Text = name,
            Position = UDim2.new(0.26, 0, 0.26, 0)
        }),
        Creator.New("ImageLabel", {
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ImageColor3 = Theme.Colors.TextBlue,
            Image = iconId,
            Size = UDim2.new(0, 30, 0, 30),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.1, 0, 0.2, 0)
        })
    })

    self.Stroke = Creator.New("UIStroke", {
        Parent = self.Button,
        Enabled = false,
        Thickness = 5,
        Color = Color3.fromRGB(255, 255, 255),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        BorderStrokePosition = Enum.BorderStrokePosition.Inner
    }, {
        Creator.New("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.153, 1),
                NumberSequenceKeypoint.new(0.999, 1),
                NumberSequenceKeypoint.new(1, 0)
            },
            Color = ColorSequence.new(Theme.Colors.TextBlue)
        })
    })

    self.Page = Creator.New("Frame", {
        Name = "PageName",
        Parent = window.PageContainer,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(86, 171, 128),
        Size = UDim2.new(0, 556, 0, 449),
        Position = UDim2.new(-0.00167, 0, -0.00123, 0),
        BackgroundTransparency = 1,
        Visible = false
    }, {
        Creator.New("Frame", {
            Name = "DesignLine",
            BorderSizePixel = 0,
            BackgroundColor3 = Theme.Colors.TextBlue,
            Size = UDim2.new(0, 446, 0, 3),
            Position = UDim2.new(0.19097, 0, -0.05925, 0)
        }),
        Creator.New("TextLabel", {
            Name = "PageName",
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
            Size = UDim2.new(0, 90, 0, 32),
            Text = name,
            Position = UDim2.new(0.00484, 0, -0.09716, 0)
        })
    })

    self.Side1 = Column.New(self.Page, "Side1", UDim2.new(0, 0, 0, 0))
    self.Side2 = Column.New(self.Page, "Side2", UDim2.new(0.52698, 0, 0, 0))

    self.Button.MouseButton1Click:Connect(function()
        self:Select()
    end)

    return self
end

function Tab:Select()
    if self.Window.CurrentTab == self then return end

    if self.Window.CurrentTab then
        self.Window.CurrentTab.Button.BackgroundTransparency = 1
        self.Window.CurrentTab.Button.Status.BackgroundTransparency = 1
        self.Window.CurrentTab.Stroke.Enabled = false
        self.Window.CurrentTab.Page.Visible = false
    end

    self.Window.CurrentTab = self
    self.Button.BackgroundTransparency = 0
    self.Button.Status.BackgroundTransparency = 0
    self.Stroke.Enabled = true
    self.Page.Visible = true
end

function Tab:CreateSection(side, title, icon)
    -- `side` should be 1 or 2; count how many sections we've already added to that
    -- column so that we can give them a unique LayoutOrder.  the caller can still
    -- pass a `title` or `icon`, but the order number will always come from the
    -- tab's internal counter.
    local targetSide = side == 1 and self.Side1 or self.Side2
    local countField = side == 1 and "Side1SectionCount" or "Side2SectionCount"
    self[countField] = (self[countField] or 0) + 1
    local layoutOrder = self[countField]

    local Section = aetherrequire("./Components/Section")
    return Section.New(targetSide.Frame, title, icon, layoutOrder)
end

return Tab
