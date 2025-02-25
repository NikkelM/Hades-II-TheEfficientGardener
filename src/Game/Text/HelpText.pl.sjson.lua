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
    DisplayName = "{I} Zbierz wszystko"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Zasadź\n {SI} Zasadź Wszystko"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Zbierz wszystko\n {G} Podlej"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Zbierz wszystko\n {SI} Podziwiaj"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Zbierz wszystko\n {G} Podlej\n {SI} Podziwiaj"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/pl/HelpText.pl.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
