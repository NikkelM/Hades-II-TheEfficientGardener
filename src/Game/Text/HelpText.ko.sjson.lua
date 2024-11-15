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
    DisplayName = "{I} 심기\n {SI} 모두 심기"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} 모두 수확\n {G} 물 주기"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} 모두 수확\n {SI} 감상"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} 모두 수확\n {G} 물 주기\n {SI} 감상"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/ko/HelpText.ko.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
