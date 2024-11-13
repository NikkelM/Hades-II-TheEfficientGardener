--[[
function PlantAdmirePresentation( usee, args )
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "PlantAdmirePresentation" })

	--SetAnimation({ Name = "MelinoeGatherStart", DestinationId = CurrentRun.Hero.ObjectId })
	--AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 0.1 )
	thread( PlayVoiceLines, HeroVoiceLines.PlantInteractVoiceLines, true, usee )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "MelTalkBroodingFull01", DestinationId = CurrentRun.Hero.ObjectId })
	wait( 1.85 )
	RemoveInputBlock({ Name = "PlantAdmirePresentation" })
end
]]

-- Usee is the current plot
modutil.mod.Path.Wrap("PlantAdmirePresentation", function(base, usee, args)
	-- If the current plot is ready to harvest or not - admire or harvest all
	if usee.GrowTimeRemaining > 0 then
		-- Admire
		base(usee, args)
		return
	end

	if usee.SeedName == nil then
		-- TODO: The plot is empty - implement plant all functionality
		print("Plot is empty")
	else
		-- The plot is ready to harvest - harvest all
		-- Harvest the current plot first for presentation purposes
		game.UseGardenPlot(usee, nil, game.CurrentRun.Hero)
		game.wait(0.25)

		-- Harvest all remaining ready plots, skip the others
		for _, plot in pairs(game.GameState.GardenPlots) do
			if plot.SeedName == nil then
			elseif plot.GrowTimeRemaining == 0 then
				-- Reset the cooldown for the function, as we want to be able to use it multiple times
				game.SessionState.GlobalCooldowns["UsedGardenPlot"] = -999
				game.UseGardenPlot(plot, nil, game.CurrentRun.Hero)
				game.wait(0.25)
			else
			end
		end
	end
end)
