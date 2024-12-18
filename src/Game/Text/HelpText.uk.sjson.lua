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
    DisplayName = "{I} Зібрати все"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Посадити\n {SI} Посадити все"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Зібрати все\n {G} Полити"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Зібрати все\n {SI} Помилуватися"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Зібрати все\n {G} Полити\n {SI} Помилуватися"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/uk/HelpText.uk.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
