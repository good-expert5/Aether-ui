if getgenv().aetherrequire then
    return
end

getgenv().AetherCache = {}

getgenv().aetherrequire = function(path)
    local baseUrl = "https://raw.githubusercontent.com/vendettawashere/aetherui/main/"
    local formattedPath = string.gsub(path, "^%./", "")
    local url = baseUrl .. formattedPath .. ".lua"
    
    if getgenv().AetherCache[url] then
        return getgenv().AetherCache[url]
    end
    
    local code = game:HttpGet(url)
    local func = loadstring(code)
    local result = func()
    
    getgenv().AetherCache[url] = result
    return result
end