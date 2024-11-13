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
				-- TODO: Locals for screen and button, call base game GardenPlantSeed, wrap CloseInventoryScreen with a custom arg to stop it from running
				-- Reset the cooldown for the function call, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = nil
				ModdedGardenPlantSeed(plot, selectedSeed)
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

-- This is the same as the base game GardenPlantSeed function, but without references to screen and button
function ModdedGardenPlantSeed(plot, seedName)
	if game.HasSeeds(2) then
		game.StopStatusAnimation(plot)
	else
		-- No more seeds for any plot
		for id, gardenPlot in pairs(game.GameState.GardenPlots) do
			game.StopStatusAnimation(gardenPlot)
		end
	end

	plot.SeedName = seedName
	local seedData = game.GardenData.Seeds[plot.SeedName]
	plot.StartingGrowTime = game.RandomInt(seedData.GrowTimeMin, seedData.GrowTimeMax)
	plot.GrowTimeRemaining = plot.StartingGrowTime
	plot.StoredGrows = 0
	plot.StoredResources = 0
	plot.LifetimeGrows = 0

	local weightedList = {}
	for k, option in pairs(seedData.RandomOutcomes) do
		if option.GameStateRequirements == nil or game.IsGameStateEligible(option, option.GameStateRequirements) then
			weightedList[k] = option.Weight or 1
		end
	end
	plot.OutcomeKey = game.GetRandomValueFromWeightedList(weightedList)
	local outcomeData = seedData.RandomOutcomes[plot.OutcomeKey]
	local resourceName = game.GetFirstKey(outcomeData.AddResources)
	plot.ResourceIconPath = game.ResourceData[resourceName].IconPath
	plot.MaxStoredGrows = seedData.MaxStoredGrows or 1
	plot.MaxStoredResources = plot.MaxStoredGrows * game.GetFirstValue(outcomeData.AddResources)

	game.GameState.GardenLastSeedPlanted = plot.SeedName

	plot.PlantId = SpawnObstacle({ Name = "PlantBase", DestinationId = plot.ObjectId, Group = "Standing" })
	game.SpendResource(seedName, 1, "Graden")
	game.GardenPlantSeedPresentation(plot, nil, game.CurrentRun.Hero)
end
