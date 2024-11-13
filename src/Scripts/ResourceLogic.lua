modutil.mod.Path.Wrap("CloseInventoryScreen", function(base, screen, button)
	screen.Args = screen.Args or {}
	if screen.Args.ModsGardenOptimizationSkipCloseInventory then
		return
	end

	base(screen, button)
end)