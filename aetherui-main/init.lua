local loaderUrl = "https://raw.githubusercontent.com/good-expert5/Aether-ui/main/Loader.lua"
if not getgenv().aetherrequire then
    loadstring(game:HttpGet(loaderUrl))()
end

local Window = aetherrequire("./Components/Window")

local AetherUI = {}

function AetherUI.New(title)
    return Window.New(title)
end

return AetherUI
