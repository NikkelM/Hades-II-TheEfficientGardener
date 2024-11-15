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
    DisplayName = "{I} Harvest All"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Plant\n {SI} Plant all"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Harvest All\n {G} Water"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Harvest All\n {SI} Admire"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Harvest All\n {G} Water\n {SI} Admire"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
