--!strict
-- Run this LocalScript from StarterPlayerScripts.
-- The example creates its own ScreenGui and does not read game state.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Kit = require(ReplicatedStorage:WaitForChild("RobloxUIToolkit"))
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local screen = Instance.new("ScreenGui")
screen.Name = "ToolkitDemo"
screen.ResetOnSpawn = false
screen.Parent = playerGui

local theme = Kit.Theme.new({
    Primary = Color3.fromRGB(89, 126, 245),
    PrimaryHover = Color3.fromRGB(110, 145, 255),
})

local panel = Kit.panel({
    Parent = screen,
    Theme = theme,
    Size = UDim2.fromOffset(320, 175),
    Position = UDim2.new(0.5, -160, 0.5, -88),
    Stack = true,
})

Kit.label({
    Parent = panel.Instance,
    Theme = theme,
    Text = "Hello, Roblox!",
    Heading = true,
    LayoutOrder = 1,
})

local status = Kit.label({
    Parent = panel.Instance,
    Theme = theme,
    Text = "Click the button below",
    Muted = true,
    LayoutOrder = 2,
})

local count = 0
local button = Kit.button({
    Parent = panel.Instance,
    Theme = theme,
    Text = "Count clicks",
    LayoutOrder = 3,
    Size = UDim2.new(1, 0, 0, 44),
    OnActivated = function()
        count += 1
        status.SetText(`Clicks: {count}`)
    end,
})

-- Example cleanup: button.Destroy(); panel.Destroy(); screen:Destroy()
