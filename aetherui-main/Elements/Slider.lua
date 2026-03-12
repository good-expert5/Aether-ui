local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Animations = aetherrequire("./Utility/Animations")
local UserInputService = game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

function Slider.New(parent, config)
    local self = setmetatable({}, Slider)
    self.Min = config.Min or 0
    self.Max = config.Max or 100
    self.Value = config.Default or self.Min

    local showToggle = config.ShowToggle or config.Toggle ~= nil or config.ToggleDefault ~= nil
    local toggleState = config.ToggleDefault or false
    local showColorPicker = config.ShowColorPicker or config.ColorPicker ~= nil or config.Color ~= nil
    local showDetail = config.ShowDetail or config.Detail ~= nil
    local colorPickerValue = typeof(config.ColorPicker) == "Color3" and config.ColorPicker or config.Color or Theme.Colors.TextBlue

    local function formatValue()
        if config.ShowValue then
            return config.Name .. " - " .. tostring(self.Value)
        end
        return config.Name
    end

    self.Container = Creator.New("Frame", {
        Name = "SliderConfigContainer",
        Parent = parent,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.ContainerDeactive,
        Size = UDim2.new(0, 260, 0, 100),
        LayoutOrder = config.LayoutOrder or 0
    }, {
        Creator.New("UICorner", {}),
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
                    NumberSequenceKeypoint.new(0.094, 1),
                    NumberSequenceKeypoint.new(0.999, 1),
                    NumberSequenceKeypoint.new(1, 0)
                },
                Color = ColorSequence.new(Theme.Colors.StrokeInactive)
            })
        }),
        Creator.New("TextLabel", {
            Name = "ConfigName",
            TextWrapped = true,
            TextStrokeTransparency = 0.8,
            BorderSizePixel = 0,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextStrokeColor3 = Theme.Colors.TextDarkBlue,
            TextScaled = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            FontFace = Theme.Fonts.Main,
            TextColor3 = Theme.Colors.TextDarkBlue,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 107, 0, 33),
            Text = formatValue(),
            Position = UDim2.new(0.06673, 0, 0.16005, 0)
        })
    })

    self.Toggle = Creator.New("TextButton", {
        Name = "Toggle",
        Parent = self.Container,
        BorderSizePixel = 0,
        TextSize = 14,
        AutoButtonColor = false,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Theme.Fonts.Main,
        ZIndex = 999999999,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 50, 0, 30),
        Position = UDim2.new(0.73323, 0, 0.18, 0),
        Text = "",
        Visible = showToggle
    })

    self.OnFrame = Creator.New("Frame", {
        Name = "ON",
        Parent = self.Toggle,
        Visible = toggleState,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.ButtonBg,
        Size = UDim2.new(0, 50, 0, 30),
        Position = UDim2.new(0, 0, 0.06667, 0)
    }, {
        Creator.New("UICorner", {}),
        Creator.New("Frame", {
            Name = "Knon",
            BorderSizePixel = 0,
            BackgroundColor3 = Theme.Colors.TextBlue,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0.47636, 0, 0.14286, 0)
        }, { Creator.New("UICorner", { CornerRadius = UDim.new(0, 6) }) })
    })

    self.OffFrame = Creator.New("Frame", {
        Name = "OFF",
        Parent = self.Toggle,
        Visible = not toggleState,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.ToggleOffBg,
        Size = UDim2.new(0, 50, 0, 30),
        Position = UDim2.new(0, 0, 0.06667, 0)
    }, {
        Creator.New("UICorner", {}),
        Creator.New("Frame", {
            Name = "Knon",
            BorderSizePixel = 0,
            BackgroundColor3 = Theme.Colors.ToggleOffKnob,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0.09636, 0, 0.16667, 0)
        }, { Creator.New("UICorner", { CornerRadius = UDim.new(0, 6) }) })
    })

    self.ColorPicker = Creator.New("TextButton", {
        Name = "ColourPickerBox",
        Parent = self.Container,
        BorderSizePixel = 0,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = colorPickerValue,
        FontFace = Theme.Fonts.Main,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0.48077, 0, 0.22, 0),
        Text = "",
        Visible = showColorPicker
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 7) })
    })

    self.DetailButton = Creator.New("TextButton", {
        Name = "Detail",
        Parent = self.Container,
        BorderSizePixel = 0,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Theme.Fonts.Main,
        ZIndex = 999999999,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(0.61538, 0, 0.26, 0),
        Text = "",
        Visible = showDetail
    }, {
        Creator.New("ImageLabel", {
            ZIndex = -50,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            ImageColor3 = Theme.Colors.ToggleOffKnob,
            Image = Theme.Assets.DetailIcon,
            Size = UDim2.new(0, 25, 0, 25),
            BackgroundTransparency = 1
        })
    })

    local range = self.Max - self.Min
    local pos = range == 0 and 0 or math.clamp((self.Value - self.Min) / range, 0, 1)

    self.Track = Creator.New("Frame", {
        Name = "Slider",
        Parent = self.Container,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.ToggleOffBg,
        Size = UDim2.new(0, 201, 0, 12),
        Position = UDim2.new(0.06673, 0, 0.71667, 0)
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 4) })
    })

    self.Fill = Creator.New("Frame", {
        Name = "PercentBar",
        Parent = self.Track,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.ToggleOffKnob,
        Size = UDim2.new(pos, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 4) })
    })

    self.Knob = Creator.New("TextButton", {
        Name = "Knob",
        Parent = self.Fill,
        BorderSizePixel = 0,
        TextSize = 14,
        AutoButtonColor = false,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundColor3 = Theme.Colors.ToggleOffKnob,
        FontFace = Theme.Fonts.Main,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0.99091, 0, -0.48333, 0),
        Text = ""
    }, {
        Creator.New("UICorner", { CornerRadius = UDim.new(0, 4) })
    })

    local dragging = false

    local function updateSlider(input)
        local newPos = math.clamp((input.Position.X - self.Track.AbsolutePosition.X) / self.Track.AbsoluteSize.X, 0, 1)
        self.Value = math.floor(self.Min + ((self.Max - self.Min) * newPos))
        self.Container.ConfigName.Text = formatValue()
        Animations.Tween(self.Fill, {0.1}, {Size = UDim2.new(newPos, 0, 1, 0)})
        if config.Callback then
            task.spawn(config.Callback, self.Value)
        end
    end

    self.Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    self.Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)

    if showToggle and config.ToggleCallback then
        self.Toggle.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            self.OnFrame.Visible = toggleState
            self.OffFrame.Visible = not toggleState
            task.spawn(config.ToggleCallback, toggleState)
        end)
    end

    if showColorPicker and (config.ColorCallback or config.ColorPickerCallback) then
        self.ColorPicker.MouseButton1Click:Connect(function()
            local callback = config.ColorCallback or config.ColorPickerCallback
            task.spawn(callback, self.ColorPicker.BackgroundColor3)
        end)
    end

    if showDetail and config.DetailCallback then
        self.DetailButton.MouseButton1Click:Connect(function()
            task.spawn(config.DetailCallback)
        end)
    end

    return self
end

return Slider
