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
    DisplayName = "{I} Semer\n {SI} Semer tout"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Tout Récolter\n {G} Arroser"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Tout Récolter\n {SI} Admirer"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Tout Récolter\n {G} Arroser\n {SI} Admirer"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/fr/HelpText.fr.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
