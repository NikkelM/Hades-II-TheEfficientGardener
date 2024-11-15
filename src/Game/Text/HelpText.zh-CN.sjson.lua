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
    DisplayName = "{I} 播种\n {SI} 播种一切"
  },
  {
    Id = "GardenPlotHarvestAndGift",
    DisplayName = "{I} 收割所有\n {G} 浇水"
  },
  {
    Id = "GardenPlotHarvestAndSpecial",
    DisplayName = "{I} 收割所有\n {SI} 欣赏"
  },
  {
    Id = "GardenPlotHarvestGiftAndSpecial",
    DisplayName = "{I} 收割所有\n {G} 浇水\n {SI} 欣赏"
  }
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/zh-CN/HelpText.zh-CN.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
