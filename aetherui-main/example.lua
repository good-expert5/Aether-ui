local AetherUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/good-expert5/Aether-ui/aetherui-main/init.lua"))()

local Window = AetherUI.New("Aether Script Hub")

local GeneralTab = Window:CreateTab("General", "rbxassetid://133011264532201", 1)
local FarmTab = Window:CreateTab("Farm", "rbxassetid://102666744617662", 2)
local PlayerTab = Window:CreateTab("Player", "rbxassetid://71227459607301", 3)

-- create two sections; the first argument is the column (1 = left, 2 = right).
-- layout order is handled internally so you don't need to supply it manually.
-- you can also provide a title (and optional icon) if you want a header.
local CombatSection = GeneralTab:CreateSection(1, "Combat")
local VisualsSection = GeneralTab:CreateSection(2, "Visuals")

CombatSection:CreateToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(state)
        print("Aimbot state:", state)
    end
})

CombatSection:CreateToggle({
    Name = "Kill Aura",
    Default = true,
    Callback = function(state)
        print("Kill Aura state:", state)
    end
})

CombatSection:CreateDropdown({
    Name = "Target",
    Options = {"Gojo Saturo", "Sukuna", "Yuji Itadori", "Megumi Fushiguro"},
    Default = "Select",
    ShowName = true,
    Callback = function(selected)
        print("Selected Target:", selected)
    end
})

VisualsSection:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(state)
        print("ESP state:", state)
    end
})

VisualsSection:CreateSlider({
    Name = "FOV Circle",
    Min = 10,
    Max = 120,
    Default = 60,
    ShowValue = true,
    Callback = function(value)
        print("FOV Set to:", value)
    end
})

-- farm tab example: a single section in the first column
local FarmSection = FarmTab:CreateSection(1, "Farm Options")

FarmSection:CreateLabel({
    Text = "Select Npc to Farm"
})

FarmSection:CreateButton({
    Name = "Infinite Energy",
    Icon = "rbxassetid://133011264532201",
    Callback = function()
        print("Infinite Energy Activated!")
    end
})

FarmSection:CreateParagraph({
    Text = "Status: Cooking UI\nDetail Explanation of the Config."
})
