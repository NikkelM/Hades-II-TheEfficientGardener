---@meta _
---@diagnostic disable

local order = {
  "Id",
  "DisplayName"
}

-- Add new interaction buttons to the Garden Plots
local newData = {
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I} Plant\n {A1} Plant all"
  },
  {
    Id = "UseGardenPlotReady",
    DisplayName = "{I} Harvest\n {A1} Harvest all"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Harvest\n {A1} Harvest all\n {G} Water"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Harvest\n {A1} Harvest all\n {SI} Admire"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Harvest\n {A1} Harvest all\n {G} Water", --\n {SI} Admire"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
