-- Usee is the current plot
modutil.mod.Path.Wrap("PlantAdmirePresentation", function(base, usee, args)
	-- If the current plot is ready to harvest or not - admire or continue to harvest/plant all
	if usee.GrowTimeRemaining > 0 then
		-- Admire
		base(usee, args)
		return
	end

	if usee.SeedName == nil then
		-- Allows planting multiple seeds at once (disable cooldown)
		game.SessionState.GlobalCooldowns["UsedGardenPlot"] = nil
		-- Allows interacting with this plot again (in case the operation was cancelled by closing the inventory without selecting a seed)
		game.SessionState.GlobalCooldowns[usee.Name .. usee.ObjectId] = nil

		-- Set this to add the input blocker early enough to prevent a small blip of the interact buttons before the second plant animation starts
		args = args or {}
		args.ModsGardenOptimizationBlockPlantAllAnimation = true

		game.UseGardenPlot(usee, args, game.CurrentRun.Hero)

		if usee.SeedName == nil then
			-- The plant all animation was cancelled
			return
		end

		local selectedSeed = game.GameState.GardenLastSeedPlanted
		local seedCount = game.GameState.Resources[selectedSeed] or 0

		-- Plant all free plots, or until there are no more of the selected seed
		for _, plot in pairs(game.GameState.GardenPlots) do
			if plot.SeedName == nil and seedCount > 0 then
				-- Set screen and button dummy values for the GardenPlantSeed function
				local screen = {
					Args = {
						PlantTarget = plot,
						-- Since there is no open inventory screen, we need to skip the close inventory screen function
						ModsGardenOptimizationSkipCloseInventory = true
					}
				}
				local button = {
					ResourceData = {
						Name = selectedSeed
					}
				}

				-- Reset the cooldown for the function call, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = nil
				game.GardenPlantSeed(screen, button)

				-- Decrease the seed count (count should be the same as inventory)
				seedCount = seedCount - 1
				game.wait(0.25)
			end
		end
		RemoveInputBlock({ Name = "GardenOptimizationPlantAllAnimation" })
	else
		-- Don't allow any other inputs while harvesting
		AddInputBlock({ Name = "GardenOptimizationHarvestAllAnimation" })
		-- The plot is ready to harvest - harvest all
		-- Harvest the current plot first for presentation purposes
		game.UseGardenPlot(usee, nil, game.CurrentRun.Hero)
		-- Allows using the plot again for plantAll right after, and keeps the interact buttons hidden
		game.SessionState.GlobalCooldowns[usee.Name .. usee.ObjectId] = nil
		game.wait(0.25)

		-- Harvest all remaining ready plots, skip the others
		for _, plot in pairs(game.GameState.GardenPlots) do
			if plot.SeedName ~= nil and plot.GrowTimeRemaining == 0 then
				-- Reset the cooldown for the function call, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = nil
				game.UseGardenPlot(plot, nil, game.CurrentRun.Hero)
				game.wait(0.25)
			end
		end
		RemoveInputBlock({ Name = "GardenOptimizationHarvestAllAnimation" })
	end
end)
