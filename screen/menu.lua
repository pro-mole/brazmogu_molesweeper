-- Main menu screen
MenuScreen = setmetatable({}, Screen)

backdrop["brazmogu_logo"] = love.graphics.newImage("/assets/gfx/logo.png")

function MenuScreen:load()
	self.UI = GUI.new()
	
	-- Reset the Challenge level each time you're back to the menu
	challenge.level = 1
	challenge.begins = false
	
	self.UI:addMenu({title = "MOLESWEEPER", items = {
		{text = 'Challenge', action = 'goto', goto = storyscreen},
		{text = 'Custom Game', action = 'submenu', submenu = {title="Game Setup", items={
			{text = 'Start Game', action = 'goto', goto = gamescreen},
			{text = 'Field Width', action = 'setting', varname = 'minefield.width', values = {9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39}},
			{text = 'Field Height', action = 'setting', varname = 'minefield.height', values = {9,11,13,15,17,19,21,23,25,27,29}},
			{text = 'Number of Mines', action = 'setting', varname = 'minefield.mines', values = {4,8,12,15,20,25,30,40}},
			{text = 'Coppermoss', action = 'setting', varname = 'minefield.coppermoss', values = {"YES","NO"}},
			{text = 'Ironcaps', action = 'setting', varname = 'minefield.ironcap', values = {"YES","NO"}},
			{text = 'Goldendrops', action = 'setting', varname = 'minefield.goldendrop', values = {"YES","NO"}},
			{text = 'Back', action = 'back'}
		}}},
		{text = 'Settings', action = 'submenu', submenu = {title="Settings", items={
			{text = 'Sound', action = 'setting', varname = 'audio.sound', values = {"ON","OFF"}},
			{text = 'Music', action = 'setting', varname = 'audio.music', values = {"ON","OFF"}},
			-- {text = 'Fullscreen', action = 'setting', varname = 'video.fullscreen', values = {"YES","NO"}},
			{text = 'Back', action = 'back'}
		}}},
		{text = 'Help', action = 'goto', goto = helpscreen},
		{text = 'About', action = 'goto', goto = aboutscreen},
		{text = 'Quit', action = 'quit'}
	}})
end

function MenuScreen:update(dt)
end

function MenuScreen:draw()
	love.graphics.draw(backdrop.dirtwall, 0, 0)
	local logo = backdrop["brazmogu_logo"]
	love.graphics.setColor(128,128,128,128)
	love.graphics.draw(logo, (love.window.getWidth() - logo:getWidth())/2, love.window.getHeight() - logo:getHeight())
	love.graphics.setColor(255,255,255,255)

	love.graphics.setColor(255,255,255,255)
	self.UI:draw()
end

function MenuScreen:quit()
end

function MenuScreen:keypressed(k, isrepeat)
	self.UI:keypressed(k, isrepeat)
	
	-- Check settings and apply changes
	-- This is done mainly for audio and video settings
	-- Also, to save global settings, but not custom game settings
	if (settings.audio.music == "OFF" and bgm.main:isPlaying()) then
		bgm.main:stop()
	elseif (settings.audio.music == "ON" and not bgm.main:isPlaying()) then
		bgm.main:play()
	end

	if (settings.video.fullscreen == "YES" and not love.window.getFullscreen()) or
		(settings.video.fullscreen == "NO" and love.window.getFullscreen()) then
		love.window.setFullscreen(settings.video.fullscreen == "YES")
		if settings.video.fullscreen == "YES" then
			love.graphics.translate((love.window.getWidth() - 640)/2, (love.window.getHeight() - 640)/2)
		else
			love.graphics.origin()
		end
	end
end

return MenuScreen