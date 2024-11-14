modutil.mod.Path.Wrap("CloseInventoryScreen", function(base, screen, button)
	screen.Args = screen.Args or {}
	-- If we are planting all, there is no open inventory screen to close for all but the first seed, so we are skipping the call
	if screen.Args.ModsGardenOptimizationSkipCloseInventory then
		return
	end

	base(screen, button)
end)