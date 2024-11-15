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
    DisplayName = "{I} Посадить\n {SI} Посадить всё"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Соберите всё\n {G} Полить"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Соберите всё\n {SI} Полюбоваться"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Соберите всё\n {G} Полить\n {SI} Полюбоваться"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/ru/HelpText.ru.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
