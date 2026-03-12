local TweenService = game:GetService("TweenService")

local Animations = {}

function Animations.Tween(target, tweenInfoArgs, properties)
    local tweenInfo = TweenInfo.new(unpack(tweenInfoArgs))
    local tween = TweenService:Create(target, tweenInfo, properties)
    tween:Play()
    return tween
end

return Animations