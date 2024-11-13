-- Usee is the current plot
modutil.mod.Path.Wrap("PlantAdmirePresentation", function(base, usee, args)
	-- If the current plot is ready to harvest or not - admire or harvest all
	if usee.GrowTimeRemaining > 0 then
		-- Admire
		base(usee, args)
		return
	end

	if usee.SeedName == nil then
		print("Plot is empty, planting all")
		-- Allow planting multiple seeds at once
		game.SessionState.GlobalCooldowns["UsedGardenPlot"] = -999
		-- GardenPlantSeed(screen, button)
		-- screen.Args.PlantTarget -> Set this in the for loop when calling GardenPlantSeed

		-- TODO: We only need the seedcount of the seed that was selected in the popup
		local seedCounts = {}
		for seedName, _ in pairs(game.GardenData.Seeds) do
			local seedCount = game.GameState.Resources[seedName] or 0
			seedCounts[seedName] = seedCount
		end
	else
		-- Don't allow any other inputs while harvesting
		AddInputBlock({ Name = "PlantHarvestAllAnimation" })
		-- TODO: Make sure the button field (E: Harvest etc.) are hidden during the entire animation
		-- The plot is ready to harvest - harvest all
		-- Harvest the current plot first for presentation purposes
		game.UseGardenPlot(usee, nil, game.CurrentRun.Hero)
		game.wait(0.25)

		-- Harvest all remaining ready plots, skip the others
		for _, plot in pairs(game.GameState.GardenPlots) do
			if plot.SeedName ~= nil and plot.GrowTimeRemaining == 0 then
				-- Reset the cooldown for the function call, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = -999
				game.UseGardenPlot(plot, nil, game.CurrentRun.Hero)
				game.wait(0.25)
			end
		end
		RemoveInputBlock({ Name = "PlantHarvestAllAnimation" })
	end
end)
