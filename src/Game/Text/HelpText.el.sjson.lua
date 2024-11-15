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
    DisplayName = "{I} Φύτεμα\n {SI} Φυτό Όλα"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Συγκομιδή όλων\n {G} Πότισμα"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Συγκομιδή όλων\n {SI} Καμάρωμα"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Συγκομιδή όλων\n {G} Πότισμα\n {SI} Καμάρωμα"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/el/HelpText.el.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)