local Creator = aetherrequire("./Utility/Creator")
local Theme = aetherrequire("./Utility/Theme")

local Column = {}
Column.__index = Column

function Column.New(parent, name, position)
    local self = setmetatable({}, Column)
    
    self.Frame = Creator.New("ScrollingFrame", {
        Name = name,
        Parent = parent,
        Active = true,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 999, 0),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
        BackgroundColor3 = Theme.Colors.SidebarBg,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0, 263, 0, 389),
        Position = position,
        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
        ScrollBarThickness = 0,
        BackgroundTransparency = 1
    }, {
        Creator.New("UIPadding", { PaddingLeft = UDim.new(0.006, 0) }),
        Creator.New("UIListLayout", { Padding = UDim.new(0.045, 0), SortOrder = Enum.SortOrder.LayoutOrder })
    })

    return self
end

return Column
