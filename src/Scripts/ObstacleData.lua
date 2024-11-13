-- TODO: Better function to wrap?
modutil.mod.Path.Wrap("DeathAreaRoomTransition", function(base, usee, args)
	base(usee, args)
	for _, plot in pairs(game.GameState.GardenPlots) do
		-- If the plot is empty, allow the special interaction, and change the text to the plant/plant all text
		if (plot.SeedName == nil) then
			plot.SpecialInteractGameStateRequirements = nil
			plot.UseTextSpecial = "UseGardenPlotPlant"
		end
	end
end)
