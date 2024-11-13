modutil.mod.Path.Wrap("SetupGardenPlot", function(base, plot, args, sourceArgs)
	base(plot, args, sourceArgs)
	for _, gamestatePlot in pairs(game.GameState.GardenPlots) do
		-- If the plot is empty, allow the special interaction, and change the text to the plant/plant all text
		if (gamestatePlot.SeedName == nil) then
			gamestatePlot.SpecialInteractGameStateRequirements = nil
			gamestatePlot.UseTextSpecial = "UseGardenPlotPlant"
		end
	end
end)

-- After planting a seed, we need to restore the default values, to change the text to only Admire
modutil.mod.Path.Wrap("GardenPlantSeed", function(base, screen, button)
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
	base(plot, args, user)

	-- If the plant was harvested, we now need to enable special interaction to allow plant all
	if (plot.SeedName == nil) then
		plot.SpecialInteractGameStateRequirements = nil
		plot.UseTextSpecial = "UseGardenPlotPlant"
	end
end)


--[[
558337:
[15:48:57.7445401][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UnlimitedGifts:
[15:48:57.7445407][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     PlantGrowthAccelerant: true
[15:48:57.7445412][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextTalkAndGift: GardenPlotHarvestAndGift
[15:48:57.7445418][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   InteractDistance: 200
[15:48:57.7445423][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SetupEvents:
[15:48:57.7445430][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     1:
[15:48:57.7445436][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       FunctionName: SetupGardenPlot
[15:48:57.7445441][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       Args:
[15:48:57.7445447][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseText: UseGardenPlotReady
[15:48:57.7445452][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   ResourceIconPath: Items\Resources\Plant\PlantGCattail
[15:48:57.7445466][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextTalkAndSpecial: GardenPlotHarvestAndSpecial
[15:48:57.7445471][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   GiftCategoryIndex: 3
[15:48:57.7445478][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   ObjectId: 558337
[15:48:57.7445482][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   Activate: true
[15:48:57.7445487][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   GiftGameStateRequirements:
[15:48:57.7445493][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     1:
[15:48:57.7445498][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       PathTrue:
[15:48:57.7445504][INFO/log.cpp:28] NikkelM-Optimized_Gardening:         1: SeedName
[15:48:57.7445509][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       PathFromSource: true
[15:48:57.7445514][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     2:
[15:48:57.7445519][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       PathFromSource: true
[15:48:57.7445524][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       Path:
[15:48:57.7445529][INFO/log.cpp:28] NikkelM-Optimized_Gardening:         1: GrowTimeRemaining
[15:48:57.7445534][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       Comparison: >=
[15:48:57.7445540][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       Value: 1
[15:48:57.7445545][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   GiftFunctionName: GiftGardenPlot
[15:48:57.7445552][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   MaxStoredResources: 1
[15:48:57.7445559][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   AnimOffsetZ: 50
[15:48:57.7445564][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SpecialInteractGameStateRequirements:
[15:48:57.7445572][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     1:
[15:48:57.7445578][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       PathTrue:
[15:48:57.7445586][INFO/log.cpp:28] NikkelM-Optimized_Gardening:         1: SeedName
[15:48:57.7445592][INFO/log.cpp:28] NikkelM-Optimized_Gardening:       PathFromSource: true
[15:48:57.7445599][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   StoredResources: 1
[15:48:57.7445605][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   MaxStoredGrows: 1
[15:48:57.7445611][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   TalkOnlyIfNoGiftOrSpecial: false
[15:48:57.7445616][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   CanReceiveGift: true
[15:48:57.7445624][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SpecialInteractFunctionName: PlantAdmirePresentation
[15:48:57.7445631][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   StartingGrowTime: 9
[15:48:57.7445636][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   Name: HubGardenPlot
[15:48:57.7445640][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextGift: GardenPlotGift
[15:48:57.7445645][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextTalkGiftAndSpecial: GardenPlotHarvestGiftAndSpecial
[15:48:57.7445651][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   LifetimeGrows: 1
[15:48:57.7445656][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextSpecial: GardenPlotSpecial
[15:48:57.7445663][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   PlantId: 2000035
[15:48:57.7445668][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SkipDefaultSetup: true
[15:48:57.7445673][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   GrowTimeRemaining: 0
[15:48:57.7445678][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SeedName: PlantGCattailSeed
[15:48:57.7445682][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   Template: HubGardenPlot
[15:48:57.7445687][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   UseTextGiftAndSpecial: GardenPlotGiftAndSpecial
[15:48:57.7445693][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   SpecialInteractCooldown: 10
[15:48:57.7445699][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   StoredGrows: 1
[15:48:57.7445704][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   OutcomeKey: 1
[15:48:57.7445713][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   GiftFunctionArgs:
[15:48:57.7445720][INFO/log.cpp:28] NikkelM-Optimized_Gardening:     Ticks: 4
[15:48:57.7445727][INFO/log.cpp:28] NikkelM-Optimized_Gardening:   OnUsedFunctionName: UseGardenPlot
[15:48:57.7445735][INFO/log.cpp:28] NikkelM-Optimized_Gardening:
]]
