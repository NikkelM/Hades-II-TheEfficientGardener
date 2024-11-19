-- Usee is the current plot
modutil.mod.Path.Wrap("PlantAdmirePresentation", function(base, usee, args)
	-- If the current plot has a seed in it, we want to admire it
	-- Otherwise, we proceed with Plant All logic
	if usee.SeedName ~= nil then
		-- Admire
		base(usee, args)
		return
	else
		-- Allows planting multiple seeds at once (disables cooldown)
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

		-- Get all free plots in a random order
		local freePlots = {}
		for _, plot in pairs(game.GameState.GardenPlots) do
			if plot.SeedName == nil then
				table.insert(freePlots, plot)
			end
		end

		for i = #freePlots, 2, -1 do
			local j = math.random(1, i)
			freePlots[i], freePlots[j] = freePlots[j], freePlots[i]
		end

		-- Plant all free plots, or until there are no more of the selected seed
		for _, plot in pairs(freePlots) do
			if seedCount > 0 then
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
	end
end)
