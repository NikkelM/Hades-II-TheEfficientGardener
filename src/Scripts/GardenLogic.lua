modutil.mod.Path.Wrap("SetupGardenPlot", function(base, plot, args, sourceArgs)
	base(plot, args, sourceArgs)

	-- If the plot is empty, allow the special interaction, and change the text to the plant/plant all text
	if (plot.SeedName == nil) then
		plot.SpecialInteractGameStateRequirements = nil
		plot.UseTextSpecial = "UseGardenPlotPlant"
	end
end)

-- After planting a seed, we need to restore the default values, to change the text to only Admire
modutil.mod.Path.Wrap("GardenPlantSeed", function(base, screen, button)
	if screen.Args.ModsGardenOptimizationBlockPlantAllAnimation then
		-- Don't allow any other inputs while planting all
		AddInputBlock({ Name = "GardenOptimizationPlantAllAnimation" })
	end

	base(screen, button)

	local plot = screen.Args.PlantTarget
	if (plot.SeedName ~= nil) then
		plot.SpecialInteractGameStateRequirements = {
			{
				PathFromSource = true,
				PathTrue = { "SeedName" },
			},
		}
		plot.UseTextSpecial = "GardenPlotSpecial"
	end
end)

modutil.mod.Path.Wrap("UseGardenPlot", function(base, plot, args, user)
	args = args or {}

	if plot.SeedName == nil then
		-- Plant the seed, include the input blocker argument
		game.OpenInventoryScreen({
			PlantTarget = plot,
			DefaultCategoryIndex = 2,
			CategoryLocked = true,
			InitialSelection =
					game.GameState.GardenLastSeedPlanted,
			ModsGardenOptimizationBlockPlantAllAnimation = args
					.ModsGardenOptimizationBlockPlantAllAnimation,
		})
		return
	end

	-- If we are planting, the above if branch gets triggered, and we never get here
	-- Else, we are not planting, and the above branch in the base function will never get triggered as well
	base(plot, args, user)

	-- If the plant was harvested, we now need to enable special interaction to allow plant all
	if (plot.SeedName == nil) then
		plot.SpecialInteractGameStateRequirements = nil
		plot.UseTextSpecial = "UseGardenPlotPlant"
	end
end)
