---@meta _
---@diagnostic disable

local order = {
  "Id",
  "DisplayName"
}

-- Add new interaction buttons to the Garden Plots
-- Special interaction/Admire is replaced by Harvest All
local newData = {
  -- {
  --   Id = "UseGardenPlotPlant",
  --   DisplayName = "{I} Plant\n {A1} Plant all"
  -- },
  -- Need to make sure this doesn't show ever - remove cooldown of special usage
  {
    Id = "UseGardenPlotReady",
    DisplayName = "{I} Harvest"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} Harvest\n {A1} Harvest all\n {G} Water"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} Harvest\n {SI} Harvest All"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} Harvest\n {G} Water\n {SI} Harvest All"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
