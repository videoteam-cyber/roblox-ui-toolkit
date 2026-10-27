# Roblox UI Toolkit

A small, dependency-free **Luau** library for building consistent Roblox interfaces. It includes theme tokens, buttons with hover and disabled states, rounded panels, and text labels.

This is a new, early-stage open-source project. It has no claimed download, adoption, or contributor metrics.

## Features

- 🎨 Customizable color, spacing, and typography tokens
- 🖱️ Button activation for mouse, touch, and gamepad
- 🔌 Explicit `Destroy()` cleanup for button connections
- 🧱 Rounded cards and vertical layout support
- 📦 No third-party runtime dependencies

## Quick start

1. In **ReplicatedStorage**, create a **ModuleScript** named `RobloxUIToolkit` and paste in the contents of `src/RobloxUIToolkit/init.lua`. Add two **ModuleScript** children named `Theme` and `Cleanup` and paste in the contents of their matching `.lua` files. **Or** use Rojo with `default.project.json`, which maps the files for you.
2. Add a **LocalScript** to `StarterPlayerScripts`.
3. Try:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Kit = require(ReplicatedStorage:WaitForChild("RobloxUIToolkit"))

local gui = Instance.new("ScreenGui")
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

Kit.button({
    Parent = gui,
    Text = "Hello world",
    Position = UDim2.fromOffset(24, 24),
    OnActivated = function()
        print("Clicked")
    end,
})
```

A complete working demo lives in [`examples/ToolkitDemo.client.lua`](examples/ToolkitDemo.client.lua). The module is intended to be used from client-side Luau.

## Rojo

If you use [Rojo](https://rojo.space/), you can build a place from the included project:

```bash
rojo build default.project.json -o ToolkitDemo.rbxlx
```

Open the file in Roblox Studio and press Play. Rojo is optional; it's only a development/sync tool.

## Documentation

See [API reference](docs/API.md) for component props and available theme tokens. To test in Studio, run [`tests/SmokeTest.client.lua`](tests/SmokeTest.client.lua) as a `LocalScript` from `StarterPlayerScripts` and check Output for the success message.

## Contributing

Bug reports, API suggestions, documentation improvements, and pull requests are welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting changes.

## License

[MIT](LICENSE). You may use and adapt this library in personal and commercial Roblox experiences.

## Status

Initial public prototype. Roblox Studio runtime testing is recommended before production use.
