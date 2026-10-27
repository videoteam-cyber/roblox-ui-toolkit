--!nonstrict
-- Small, explicit styling tokens for Roblox user interfaces.
local Theme = {}

local defaults = table.freeze({
    Surface = Color3.fromRGB(25, 29, 38),
    SurfaceRaised = Color3.fromRGB(35, 41, 53),
    Text = Color3.fromRGB(245, 247, 250),
    MutedText = Color3.fromRGB(175, 185, 202),
    Primary = Color3.fromRGB(75, 130, 255),
    PrimaryHover = Color3.fromRGB(96, 147, 255),
    Disabled = Color3.fromRGB(90, 98, 111),
    Border = Color3.fromRGB(67, 78, 98),
    Radius = 12,
    Padding = 16,
    Gap = 10,
    FontSize = 16,
    HeadingSize = 22,
})

local colorTokens = {
    Surface = true,
    SurfaceRaised = true,
    Text = true,
    MutedText = true,
    Primary = true,
    PrimaryHover = true,
    Disabled = true,
    Border = true,
}

function Theme.new(overrides)
    local result = table.clone(defaults)

    if overrides then
        for key, value in pairs(overrides) do
            assert(defaults[key] ~= nil, `Unknown theme token: {key}`)
            if colorTokens[key] then
                assert(typeof(value) == "Color3", `{key} must be a Color3`)
            else
                assert(type(value) == "number" and value >= 0, `{key} must be a non-negative number`)
            end
            result[key] = value
        end
    end

    return table.freeze(result)
end

Theme.defaults = defaults
return table.freeze(Theme)
