local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
local Button = aetherrequire("./Elements/Button")
local Toggle = aetherrequire("./Elements/Toggle")
local Slider = aetherrequire("./Elements/Slider")
local Dropdown = aetherrequire("./Elements/Dropdown")
local Label = aetherrequire("./Elements/Label")
local Paragraph = aetherrequire("./Elements/Paragraph")
local ColorPicker = aetherrequire("./Elements/ColorPicker")

local Section = {}
Section.__index = Section

function Section.New(parentColumn, title, icon, layoutOrder)
    local self = setmetatable({}, Section)
    
    -- This is the Main Wrapper for the whole section
    self.Main = Creator.New("Frame", {
        Name = title .. "Section",
        Parent = parentColumn,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.SidebarBg,
        AutomaticSize = Enum.AutomaticSize.Y, -- Only Y scales
        Size = UDim2.new(1, 0, 0, 0), -- Take full width of column
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder or 0
    }, {
        Creator.New("UIListLayout", { 
            Padding = UDim.new(0, 10), -- Space between Header and Elements
            SortOrder = Enum.SortOrder.LayoutOrder 
        })
    })

    -- 1. THE HEADER (The Dropdown Button)
    if title then
        self.Header = Button.New(self.Main, {
            Name = title,
            Icon = icon,
            LayoutOrder = 0,
            InstanceName = "SectionHeader"
        })

        -- Toggle Logic: When header is clicked, show/hide the content
        -- Note: This assumes your Button element has an 'Instance' or 'Frame' property
        local headerBtn = self.Header.Instance or self.Header.Frame or self.Header
        if headerBtn:IsA("GuiButton") or headerBtn:FindFirstChildWhichIsA("GuiButton", true) then
            local actualBtn = headerBtn:IsA("GuiButton") and headerBtn or headerBtn:FindFirstChildWhichIsA("GuiButton", true)
            
            actualBtn.MouseButton1Click:Connect(function()
                self.Content.Visible = not self.Content.Visible
            end)
        end
    end

    -- 2. THE CONTENT CONTAINER (Where elements actually go)
    self.Content = Creator.New("Frame", {
        Name = "SectionContent",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = 1,
        Visible = true -- Default to open
    }, {
        Creator.New("UIListLayout", { 
            Padding = UDim.new(0, 8), -- Space between individual toggles/sliders
            SortOrder = Enum.SortOrder.LayoutOrder 
        }),
        Creator.New("UIPadding", { PaddingLeft = UDim.new(0, 10) }) -- Indent elements slightly
    })

    return self
end

-- All elements now use self.Content as the parent
function Section:CreateButton(config)
    return Button.New(self.Content, config)
end

function Section:CreateToggle(config)
    return Toggle.New(self.Content, config)
end

function Section:CreateSlider(config)
    return Slider.New(self.Content, config)
end

function Section:CreateDropdown(config)
    return Dropdown.New(self.Content, config)
end

function Section:CreateLabel(config)
    return Label.New(self.Content, config)
end

function Section:CreateParagraph(config)
    return Paragraph.New(self.Content, config)
end

function Section:CreateColorPicker(config)
    return ColorPicker.New(self.Content, config)
end

return Section
