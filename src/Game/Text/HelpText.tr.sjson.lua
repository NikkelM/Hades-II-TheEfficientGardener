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
    DisplayName = "{I} Ek\n {SI} Hepsini Ek"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Hepsini Hasat Et\n {G} Sula"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Hepsini Hasat Et\n {SI} Sevgi Göster"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Hepsini Hasat Et\n {G} Sula\n {SI} Sevgi Göster"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/tr/HelpText.tr.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
