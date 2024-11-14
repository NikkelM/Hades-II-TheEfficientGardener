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
		-- Does the same as the default plant seed function, but with the added input blocker argument
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

	-- Harvest all
	if (plot.StoredGrows or 0) >= 1 and not args.ModsEfficientGardenerSkipHarvestAll then
		-- Don't allow any other inputs while harvesting
		AddInputBlock({ Name = "GardenOptimizationHarvestAllAnimation" })

		-- Harvest the current plot first for presentation purposes
		base(plot, args, user)

		-- Allows using the plot again for plantAll right after, and keeps the interact buttons hidden
		game.SessionState.GlobalCooldowns[plot.Name .. plot.ObjectId] = nil
		game.wait(0.25)

		-- Harvest all remaining ready plots, skip the others
		for _, otherPlot in pairs(game.GameState.GardenPlots) do
			if otherPlot.SeedName ~= nil and otherPlot.GrowTimeRemaining == 0 then
				-- Reset the cooldown for the function call, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = nil
				game.UseGardenPlot(otherPlot, { ModsEfficientGardenerSkipHarvestAll = true }, game.CurrentRun.Hero)
				game.wait(0.25)
			end
		end
		RemoveInputBlock({ Name = "GardenOptimizationHarvestAllAnimation" })
	else
		-- Harvesting, but we have already triggered Harvest All from a different plot
		base(plot, args, user)
	end

	-- If a plant was harvested, we now need to enable special interaction ("Admire") to allow "Plant All"
	if (plot.SeedName == nil) then
		plot.SpecialInteractGameStateRequirements = nil
		plot.UseTextSpecial = "UseGardenPlotPlant"
	end
end)
