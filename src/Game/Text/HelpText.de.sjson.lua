---@meta _
---@diagnostic disable

local order = {
  "Id",
  "DisplayName"
}

-- Update the Garden's interaction buttons
-- For planting, Admire is replaced by "Plant All"
-- For harvesting, "Harvest" is replaced by "Harvest All"
local newData = {
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Pflanzen\n {SI} Alle Bepflanzen"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Alles Ernten\n {G} Gießen"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Alles Ernten\n {SI} Bewundern"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Alles Ernten\n {G} Gießen\n {SI} Bewundern"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/de/HelpText.de.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
