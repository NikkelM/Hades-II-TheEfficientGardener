---@meta _
---@diagnostic disable

local order = {
  "Id",
  "DisplayName"
}

-- Update the Garden's interaction buttons
-- For planting, an additional "Plant All" prompt is added, using the special interaction button ("Admire")
-- For harvesting, "Harvest" is replaced by "Harvest All"
local newData = {
  {
    Id = "UseGardenPlotReady",
    DisplayName = "{I} Raccogli Tutti"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Semina\n {SI} Semina Tutti"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Raccogli Tutti\n {G} Innaffia"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Raccogli Tutti\n {SI} Ammira"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Raccogli Tutti\n {G} Innaffia\n {SI} Ammira"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/it/HelpText.it.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
