---@meta _
---@diagnostic disable

local songNames = {
	-- "Song_Hades_MainTheme",
}

local songWorldUpgradeData = {
	-- Song_Hades_MainTheme = {
	-- 	Name = "Song_Hades_MainTheme",
	-- 	InheritFrom = { "DefaultSongItem" },
	-- 	TrackName = "/Music/MusicPlayer/MainThemeMusicPlayer",
	-- 	Cost = {
	-- 		CosmeticsPoints = 0,
	-- 	},
	-- },
}

for _, songName in ipairs(songNames) do
	table.insert(game.ScreenData.MusicPlayer.Songs, songName)
end

-- Make sure the inherited fields are applied properly, then insert the new object into the WorldUpgradeData table
for songName, songData in pairs(songWorldUpgradeData) do
	game.ProcessDataInheritance(songData, game.WorldUpgradeData)
	game.WorldUpgradeData[songName] = songData
end
