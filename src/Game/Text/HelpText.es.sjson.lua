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
    DisplayName = "{I} Recoger todo"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Plantar\n {SI} Plantar todo"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Recoger todo\n {G} Regar"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Recoger todo\n {SI} Admirar"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Recoger todo\n {G} Regar\n {SI} Admirar"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/es/HelpText.es.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
