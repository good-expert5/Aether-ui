local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local FloatingController = aetherrequire("./Components/FloatingController")
local Tab = aetherrequire("./Components/Tab")

local Window = {}
Window.__index = Window

-- Modified to accept config (for Size selection)
function Window.New(title, config)
    local self = setmetatable({}, Window)
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Default to 919x536 if no size is provided in config
    local customSize = config and config.Size or UDim2.new(0, 919, 0, 536)
    
    self.ScreenGui = Creator.New("ScreenGui", {
        Name = "Aether.ScriptUI",
        Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
        IgnoreGuiInset = true,
        Enabled = true,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    self.UI = Creator.New("Frame", {
        Name = "UI",
        Parent = self.ScreenGui,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })

    self.Main = Creator.New("Frame", {
        Name = "Main",
        Parent = self.UI,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.MainBg,
        Size = customSize, -- Applied custom size
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5) -- Centered for better scaling
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 20) }),
        Creator.New("UIStroke", {
            Name = "Type2",
            Thickness = 2,
            Color = Theme.Colors.StrokeWhite
        }, {
            Creator.New("UIGradient", {
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.5, 1),
                    NumberSequenceKeypoint.new(0.501, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
            })
        })
    })

    self.SideFrame = Creator.New("Frame", {
        Name = "SideFrame",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.SidebarBg,
        Size = UDim2.new(0.293, 0, 1, 0), -- Scale width relative to Main
        Position = UDim2.new(0.016, 0, 0, 0),
        BackgroundTransparency = 1
    }, {
        Creator.New("ImageLabel", {
            ScaleType = Enum.ScaleType.Crop,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Image = Theme.Assets.ControllerLogo,
            Size = UDim2.new(0, 80, 0, 60),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.028, 0, 0.056, 0),
            BorderSizePixel = 0
        })
    })

    self.SidebarScroll = Creator.New("ScrollingFrame", {
        Name = "ScrollingFrame",
        Parent = self.SideFrame,
        Active = true,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
        BackgroundColor3 = Theme.Colors.SidebarBg,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0.636, 0),
        Position = UDim2.new(0, 0, 0.254, 0),
        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
        ScrollBarThickness = 0,
        BackgroundTransparency = 1
    }, {
        Creator.New("UIListLayout", { Padding = UDim.new(0.017, 0), SortOrder = Enum.SortOrder.LayoutOrder }),
        Creator.New("UIPadding", { PaddingTop = UDim.new(0.006, 0), PaddingLeft = UDim.new(0.03, 0) })
    })

    self.Seprator = Creator.New("Frame", {
        Name = "Seprator",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.SeparatorDark,
        Size = UDim2.new(0, 3, 0.925, 0),
        Position = UDim2.new(0.328, 0, 0.037, 0)
    }, {
        Creator.New("CanvasGroup", {
            Name = "Fader1",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(0, 3, 0, 100)
        }, {
            Creator.New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}, Color = ColorSequence.new(Theme.Colors.MainBg) })
        }),
        Creator.New("CanvasGroup", {
            Name = "Fader2",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(0, 3, 0, 100),
            Position = UDim2.new(0, 0, 0.798, 0)
        }, {
            Creator.New("UIGradient", { Rotation = -90, Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}, Color = ColorSequence.new(Theme.Colors.MainBg) })
        })
    })

    self.PageContainer = Creator.New("Frame", {
        Name = "Page",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.SidebarBg,
        Size = UDim2.new(0.605, 0, 0.837, 0),
        Position = UDim2.new(0.363, 0, 0.161, 0),
        BackgroundTransparency = 1
    })

    -- Faders adjusted to be child of Main and scale
    Creator.New("CanvasGroup", {
        Name = "SideFrameFader",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.347, 0, 0.343, 0),
        Position = UDim2.new(0.017, 0, 0.656, 0)
    }, {
        Creator.New("UIGradient", { Rotation = -90, Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}, Color = ColorSequence.new(Theme.Colors.MainBg) })
    })

    Creator.New("CanvasGroup", {
        Name = "PageFader",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.615, 0, 0.343, 0),
        Position = UDim2.new(0.362, 0, 0.658, 0)
    }, {
        Creator.New("UIGradient", { Rotation = -90, Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}, Color = ColorSequence.new(Theme.Colors.MainBg) })
    })

    self.FloatingController = FloatingController.New(self.ScreenGui, function()
        self.UI.Visible = not self.UI.Visible
    end)

    return self
end

function Window:CreateTab(name, iconId, layoutOrder)
    local newTab = Tab.New(self, name, iconId, layoutOrder)
    table.insert(self.Tabs, newTab)
    if #self.Tabs == 1 then
        newTab:Select()
    end
    return newTab
end

return Window
