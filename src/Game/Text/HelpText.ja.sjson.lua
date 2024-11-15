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
    DisplayName = "{I}刈り尽くす"
  },
  {
    Id = "UseGardenPlotPlant",
    DisplayName = "{I}植える\n {SI} すべての植物"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I}刈り尽くす\n {G}水をやる"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I}刈り尽くす\n {SI}愛でる"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I}刈り尽くす\n {G}水をやる\n {SI}愛でる"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/ja/HelpText.ja.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
