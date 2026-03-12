local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")
-- ... (Your Element Requires)

local Section = {}
Section.__index = Section

function Section.New(parentColumn, title, icon, layoutOrder)
    local self = setmetatable({}, Section)
    
    self.Main = Creator.New("Frame", {
        Name = title .. "Section",
        Parent = parentColumn,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder or 0
    }, {
        Creator.New("UIListLayout", { 
            Padding = UDim.new(0, 5), 
            SortOrder = Enum.SortOrder.LayoutOrder 
        })
    })

    if title then
        self.Header = Button.New(self.Main, {
            Name = title,
            Icon = icon,
            LayoutOrder = 0,
            InstanceName = "SectionHeader"
        })

        -- Get the actual button for the click event
        local headerBtn = self.Header.Instance or self.Header.Frame or self.Header
        local clickTarget = headerBtn:IsA("GuiButton") and headerBtn or headerBtn:FindFirstChildWhichIsA("GuiButton", true)
        
        if clickTarget then
            clickTarget.MouseButton1Click:Connect(function()
                self.Content.Visible = not self.Content.Visible
                
                -- Optional: If you have an arrow icon, you can tween it here:
                -- Creator.Tween(self.Header.Arrow, TweenInfo.new(0.3), {Rotation = self.Content.Visible and 0 or -90})
            end)
        end
    end

    self.Content = Creator.New("Frame", {
        Name = "SectionContent",
        Parent = self.Main,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = 1,
        Visible = true
    }, {
        Creator.New("UIListLayout", { 
            Padding = UDim.new(0, 8), 
            SortOrder = Enum.SortOrder.LayoutOrder 
        }),
        Creator.New("UIPadding", { PaddingLeft = UDim.new(0, 15) }) -- Slightly more indent for clear sectioning
    })

    return self
end

-- Ensure all elements are parented to self.Content
function Section:CreateButton(config) return Button.New(self.Content, config) end
function Section:CreateToggle(config) return Toggle.New(self.Content, config) end
function Section:CreateSlider(config) return Slider.New(self.Content, config) end
function Section:CreateDropdown(config) return Dropdown.New(self.Content, config) end
function Section:CreateLabel(config) return Label.New(self.Content, config) end
function Section:CreateParagraph(config) return Paragraph.New(self.Content, config) end
function Section:CreateColorPicker(config) return ColorPicker.New(self.Content, config) end

return Section
