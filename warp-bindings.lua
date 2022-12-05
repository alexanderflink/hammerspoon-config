local function createWarpBindings()
	local window_mode = hs.hotkey.modal.new({ "ctrl" }, "w")

	window_mode:bind({}, "h", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd", "alt" }, "left")
	end)

	window_mode:bind({}, "j", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd", "alt" }, "down")
	end)

	window_mode:bind({}, "k", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd", "alt" }, "up")
	end)

	window_mode:bind({}, "l", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd", "alt" }, "right")
	end)

	window_mode:bind({}, "c", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd" }, "w")
	end)

	window_mode:bind({}, "v", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd" }, "d")
	end)

	window_mode:bind({}, "s", function()
		window_mode:exit()
		hs.eventtap.keyStroke({ "cmd", "shift" }, "d")
	end)

	return window_mode
end

local warp_filter = hs.window.filter.new("Warp")
local warp_bindings

warp_filter:subscribe(hs.window.filter.windowVisible, function()
	warp_bindings = createWarpBindings()
end)

warp_filter:subscribe(hs.window.filter.windowNotVisible, function()
	if warp_bindings then
		warp_bindings:delete()
	end
end)
