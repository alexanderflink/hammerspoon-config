local spaces = require("hs.spaces") 

-- Run a startup bash script
hs.execute("./startup.sh")

-- Switch neovide
hs.hotkey.bind({ "alt" }, "space", function()
	local APP_NAME = "Neovide"
	function moveWindow(neovide, space, mainScreen)
		-- move to main space
		local win = nil
		while win == nil do
			win = neovide:mainWindow()
		end
		print(win)
		print(space)
		print(win:screen())
		print(mainScreen)
		local fullScreen = not win:isStandard()
		if fullScreen then
			hs.eventtap.keyStroke("cmd", "return", 0, neovide)
		end
		winFrame = win:frame()
		scrFrame = mainScreen:fullFrame()
		print(winFrame)
		print(scrFrame)
		winFrame.w = scrFrame.w
		winFrame.y = scrFrame.y
		winFrame.x = scrFrame.x
		print(winFrame)
		win:setFrame(winFrame, 0)
		print(win:frame())
		spaces.moveWindowToSpace(win, space)
		if fullScreen then
			hs.eventtap.keyStroke("cmd", "return", 0, neovide)
		end
		win:focus()
	end

	local neovide = hs.application.get(APP_NAME)

	if neovide ~= nil and neovide:isFrontmost() then
		neovide:hide()
	else
		local space = spaces.activeSpaceOnScreen()
		local mainScreen = hs.screen.mainScreen()

		if neovide == nil and hs.application.launchOrFocus(APP_NAME) then
			local appWatcher = nil
			print("create app watcher")
			appWatcher = hs.application.watcher.new(function(name, event, app)
				print(name)
				print(event)
				if event == hs.application.watcher.launched and name == APP_NAME then
					app:hide()
					moveWindow(app, space, mainScreen)
					appWatcher:stop()
				end
			end)
			print("start watcher")
			appWatcher:start()
		end

		if neovide ~= nil then
			moveWindow(neovide, space, mainScreen)
		end
	end
end)
