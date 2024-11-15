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
    DisplayName = "{I} 種植\n {SI} 全部種植"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} 收获所有\n {G} 澆水"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} 收获所有\n {SI} 欣賞"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} 收获所有\n {G} 澆水\n {SI} 欣賞"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/zh-TW/HelpText.zh-TW.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
