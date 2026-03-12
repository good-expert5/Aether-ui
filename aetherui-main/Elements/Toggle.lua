local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Animations = aetherrequire("./Utility/Animations")

local Toggle = {}
Toggle.__index = Toggle

function Toggle.New(parent, config)
    local self = setmetatable({}, Toggle)
    self.State = config.Default or false

    local currentBg = self.State and Theme.Colors.ContainerActive or Theme.Colors.ContainerDeactive
    local currentStroke = self.State and Theme.Colors.StrokeActive or Theme.Colors.StrokeInactive
    local currentText = self.State and Theme.Colors.TextActive or Theme.Colors.TextDarkBlue
    local detailColor = self.State and Theme.Colors.TextBlue or Theme.Colors.ToggleOffKnob

    local showColorPicker = config.ShowColorPicker or config.ColorPicker ~= nil or config.Color ~= nil
    local showDetail = config.ShowDetail or config.Detail ~= nil
    local colorPickerValue = typeof(config.ColorPicker) == "Color3" and config.ColorPicker or config.Color or Theme.Colors.TextBlue

    self.Container = Creator.New("Frame", {
        Name = self.State and "ActiveConfigContainer" or "DeactiveConfigContainer",
        Parent = parent,
        BorderSizePixel = 0,
        BackgroundColor3 = currentBg,
        Size = UDim2.new(0, 260, 0, 50),
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
                Name = "Gradient",
                Rotation = 90,
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.161, 1),
                    NumberSequenceKeypoint.new(0.999, 1),
                    NumberSequenceKeypoint.new(1, 0)
                },
                Color = ColorSequence.new(currentStroke)
            })
        }),
        Creator.New("TextLabel", {
            Name = "ConfigName",
            TextWrapped = true,
            TextStrokeTransparency = 0.8,
            BorderSizePixel = 0,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextStrokeColor3 = currentText,
            TextScaled = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            FontFace = Theme.Fonts.Main,
            TextColor3 = currentText,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 102, 0, 33),
            Text = config.Name,
            Position = UDim2.new(0.06673, 0, 0.16005, 0)
        })
    })

    self.Button = Creator.New("TextButton", {
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
        Text = ""
    })

    self.OnFrame = Creator.New("Frame", {
        Name = "ON",
        Parent = self.Button,
        Visible = self.State,
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
        Parent = self.Button,
        Visible = not self.State,
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
            ImageColor3 = detailColor,
            Image = Theme.Assets.DetailIcon,
            Size = UDim2.new(0, 25, 0, 25),
            BackgroundTransparency = 1
        })
    })

    self.Button.MouseButton1Click:Connect(function()
        self:Set(not self.State)
        if config.Callback then
            task.spawn(config.Callback, self.State)
        end
    end)

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

    self.DetailIcon = self.DetailButton:FindFirstChildOfClass("ImageLabel")
    self.ConfigName = self.Container:FindFirstChild("ConfigName")

    return self
end

function Toggle:Set(value)
    self.State = value
    self.Container.Name = self.State and "ActiveConfigContainer" or "DeactiveConfigContainer"
    self.OnFrame.Visible = self.State
    self.OffFrame.Visible = not self.State

    local targetBg = self.State and Theme.Colors.ContainerActive or Theme.Colors.ContainerDeactive
    local targetStroke = self.State and Theme.Colors.StrokeActive or Theme.Colors.StrokeInactive
    local targetText = self.State and Theme.Colors.TextActive or Theme.Colors.TextDarkBlue
    local targetDetail = self.State and Theme.Colors.TextBlue or Theme.Colors.ToggleOffKnob

    Animations.Tween(self.Container, {0.3}, {BackgroundColor3 = targetBg})
    Animations.Tween(self.Container.UIStroke.Gradient, {0.3}, {Color = ColorSequence.new(targetStroke)})
    Animations.Tween(self.ConfigName, {0.3}, {TextColor3 = targetText, TextStrokeColor3 = targetText})

    if self.DetailIcon then
        Animations.Tween(self.DetailIcon, {0.3}, {ImageColor3 = targetDetail})
    end
end

return Toggle
