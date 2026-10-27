--!nonstrict
-- Run from a LocalScript under StarterPlayerScripts in a Studio test place.
-- Intentionally does not touch any game-specific objects.
local Kit = require(game:GetService("ReplicatedStorage"):WaitForChild("RobloxUIToolkit"))
local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local theme = Kit.Theme.new({ Radius = 8 })
assert(theme.Radius == 8, "Expected theme override")
assert(Kit.Theme.defaults.Radius ~= 8, "Default theme should remain unchanged")
assert(not pcall(function() Kit.Theme.new({ MissingToken = 1 }) end), "Unknown tokens should be rejected")

local panel = Kit.panel({ Parent = gui, Theme = theme, Stack = true })
local label = Kit.label({ Parent = panel.Instance, Text = "Before" })
label.SetText("After")
assert(label.Instance.Text == "After", "Label text setter failed")

local button = Kit.button({ Parent = panel.Instance, Text = "Example", Disabled = true })
assert(button.Instance.Active == false, "Disabled button should not be active")
button.SetDisabled(false)
assert(button.Instance.Active == true, "Enabled button should be active")
button.SetText("Updated")
assert(button.Instance.Text == "Updated", "Button text setter failed")

button.Destroy()
button.Destroy() -- idempotent
label.Destroy()
panel.Destroy()
gui:Destroy()
print("Roblox UI Toolkit smoke test passed")
