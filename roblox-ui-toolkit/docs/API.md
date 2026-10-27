# API reference

The library runs in Roblox and has no external dependencies. All three component builders require a `Parent` Roblox Instance. Call them from a `LocalScript` for user interfaces.

## `Kit.Theme.new(overrides?)`

Returns an immutable table of colors, numeric spacing, and typography tokens. Unknown keys and mismatched value types are rejected.

Available tokens:

| Colors (`Color3`) | Numbers (pixels) |
| --- | --- |
| `Surface`, `SurfaceRaised`, `Text`, `MutedText`, `Primary`, `PrimaryHover`, `Disabled`, `Border` | `Radius`, `Padding`, `Gap`, `FontSize`, `HeadingSize` |

Use `Kit.Theme.defaults` for the built-in theme.

## `Kit.button(props)`

Required: `Parent`. Optional: `Text`, `Size`, `Position`, `LayoutOrder`, `Theme`, `OnActivated`, `Disabled`.

Returns a handle:

- `.Instance`: the created `TextButton`.
- `.SetText(text)`: changes its text.
- `.SetDisabled(boolean)`: changes whether it accepts interaction.
- `.Destroy()`: disconnects its event listeners and destroys the button (safe to call twice).

The `OnActivated` callback works for mouse, touch, and gamepad activation. Disabled buttons do not invoke the callback.

## `Kit.panel(props)`

Required: `Parent`. Optional: `Size`, `Position`, `LayoutOrder`, `Theme`, `Padding`, `Stack`.

Returns `.Instance` (`Frame`) and `.Destroy()`.

If `Stack` is true, a vertical `UIListLayout` is added. Set child `LayoutOrder` to specify order; give each child an explicit height. Parent panels do not automatically destroy separately held child handles; normal Roblox Instance parenting does destroy descendants.

## `Kit.label(props)`

Required: `Parent`. Optional: `Text`, `Size`, `Position`, `LayoutOrder`, `Theme`, `Muted`, `Heading`.

Returns `.Instance` (`TextLabel`), `.SetText(text)`, and `.Destroy()`.

## Notes

- The library does not insert itself into your place. Add it to `ReplicatedStorage` yourself, or sync using Rojo.
- This is a small starting point for common UI patterns, not a full component or accessibility framework.
- Components use pixels for default sizes; override `Size` with scale-based `UDim2` values for responsive layouts.
- Keep your screen-level cleanup in your owning `LocalScript`.
