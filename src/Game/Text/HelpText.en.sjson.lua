---@meta _
---@diagnostic disable

local order = {
  "Id",
  "DisplayName",
  "Description"
}

-- Data that should be added to the object
local newData = {
  {
    Id = "Song_Hades_MainTheme",
    DisplayName = "No Escape",
    Description = "A rousing theme created for the god of the dead. A piece by Orpheus, Hades' house musician."
  },
}

local helpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')

sjson.hook(helpTextFile, function(data)
  for _, newValue in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newValue, order))
  end
end)
