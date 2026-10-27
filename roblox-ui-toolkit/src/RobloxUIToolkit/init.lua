--!nonstrict
-- Roblox UI Toolkit: dependency-free components for client-side UI.
-- General purpose; not tied to any particular experience.

local Theme = require(script.Theme)
local Cleanup = require(script.Cleanup)

local Kit = {}
Kit.Theme = Theme

local function getTheme(props)
    local theme = props.Theme or Theme.defaults
    assert(type(theme) == "table", "Theme must be a table returned by Kit.Theme.new")
    return theme
end

local function assertParent(parent)
    assert(typeof(parent) == "Instance", "Parent must be a Roblox Instance")
end

local function setRounded(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end

local function setPadding(instance, padding)
    local component = Instance.new("UIPadding")
    component.PaddingTop = UDim.new(0, padding)
    component.PaddingBottom = UDim.new(0, padding)
    component.PaddingLeft = UDim.new(0, padding)
    component.PaddingRight = UDim.new(0, padding)
    component.Parent = instance
end

-- button({ Parent, Text?, Size?, Position?, LayoutOrder?, Theme?, OnActivated?, Disabled? })
-- Returns { Instance, SetText, SetDisabled, Destroy }.
function Kit.button(props)
    assert(type(props) == "table", "button(props) requires a props table")
    assertParent(props.Parent)
    local theme = getTheme(props)
    local cleanup = Cleanup.new()

    local button = Instance.new("TextButton")
    button.Name = "ToolkitButton"
    button.Size = props.Size or UDim2.fromOffset(180, 44)
    button.Position = props.Position or UDim2.fromOffset(0, 0)
    button.LayoutOrder = props.LayoutOrder or 0
    button.BackgroundColor3 = theme.Primary
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Font = Enum.Font.GothamMedium
    button.Text = props.Text or "Button"
    button.TextSize = theme.FontSize
    button.TextColor3 = theme.Text
    button.Parent = props.Parent
    setRounded(button, theme.Radius)
    cleanup:add(button)

    local disabled = props.Disabled == true
    local hovering = false
    local alive = true

    local function refresh()
        button.Active = not disabled
        button.Selectable = not disabled
        if disabled then
            button.BackgroundColor3 = theme.Disabled
        elseif hovering then
            button.BackgroundColor3 = theme.PrimaryHover
        else
            button.BackgroundColor3 = theme.Primary
        end
    end

    cleanup:add(button.MouseEnter:Connect(function()
        hovering = true
        if alive then refresh() end
    end))
    cleanup:add(button.MouseLeave:Connect(function()
        hovering = false
        if alive then refresh() end
    end))

    if props.OnActivated then
        assert(type(props.OnActivated) == "function", "OnActivated must be a function")
        cleanup:add(button.Activated:Connect(function()
            if alive and not disabled then
                props.OnActivated()
            end
        end))
    end

    refresh()

    return {
        Instance = button,
        SetText = function(text)
            assert(type(text) == "string", "SetText expects a string")
            if alive then button.Text = text end
        end,
        SetDisabled = function(value)
            assert(type(value) == "boolean", "SetDisabled expects a boolean")
            if alive then
                disabled = value
                refresh()
            end
        end,
        Destroy = function()
            if not alive then return end
            alive = false
            cleanup:destroy()
        end,
    }
end

-- panel({ Parent, Size?, Position?, LayoutOrder?, Theme?, Padding?, Stack? })
-- Returns { Instance, Destroy }.
function Kit.panel(props)
    assert(type(props) == "table", "panel(props) requires a props table")
    assertParent(props.Parent)
    local theme = getTheme(props)

    local frame = Instance.new("Frame")
    frame.Name = "ToolkitPanel"
    frame.Size = props.Size or UDim2.fromOffset(280, 180)
    frame.Position = props.Position or UDim2.fromOffset(0, 0)
    frame.LayoutOrder = props.LayoutOrder or 0
    frame.BackgroundColor3 = theme.SurfaceRaised
    frame.BorderSizePixel = 0
    frame.Parent = props.Parent
    setRounded(frame, theme.Radius)
    setPadding(frame, if props.Padding ~= nil then props.Padding else theme.Padding)

    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Thickness = 1
    stroke.Parent = frame

    if props.Stack then
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, theme.Gap)
        layout.Parent = frame
    end

    return {
        Instance = frame,
        Destroy = function()
            frame:Destroy()
        end,
    }
end

-- label({ Parent, Text?, Size?, Position?, LayoutOrder?, Theme?, Muted?, Heading? })
-- Returns { Instance, SetText, Destroy }.
function Kit.label(props)
    assert(type(props) == "table", "label(props) requires a props table")
    assertParent(props.Parent)
    local theme = getTheme(props)

    local label = Instance.new("TextLabel")
    label.Name = "ToolkitLabel"
    label.Size = props.Size or UDim2.new(1, 0, 0, 28)
    label.Position = props.Position or UDim2.fromOffset(0, 0)
    label.LayoutOrder = props.LayoutOrder or 0
    label.BackgroundTransparency = 1
    label.Text = props.Text or ""
    label.TextColor3 = props.Muted and theme.MutedText or theme.Text
    label.Font = props.Heading and Enum.Font.GothamBold or Enum.Font.Gotham
    label.TextSize = props.Heading and theme.HeadingSize or theme.FontSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = props.Parent

    return {
        Instance = label,
        SetText = function(text)
            assert(type(text) == "string", "SetText expects a string")
            if label.Parent ~= nil then label.Text = text end
        end,
        Destroy = function()
            label:Destroy()
        end,
    }
end

return table.freeze(Kit)
