local screen = hs.screen.mainScreen()
local canvas = hs.canvas.new({ x = 0, y = 0, w = screen:frame().w, h = 24 })

canvas:behavior({ "stationary", "canJoinAllSpaces" })
canvas:bringToFront(false)

-- define skhd modes
local skhdModes = {
	default = "Default",
	window = "Window",
	space = "Space",
}

local skhdMode = skhdModes.default

local user = string.gsub(hs.execute("whoami"), "\n", "")

local function updateCanvas()
	local x = 0

	canvas[#canvas + 1] = {
		type = "rectangle",
		action = "fill",
		fillColor = { hex = "#14111D", alpha = 1 },
	}

	x = x + 10

	canvas[#canvas + 1] = {
		type = "text",
		text = "",
		textColor = { white = 1 },
		textFont = "Hack Nerd Font",
		frame = { x = x, y = 0, w = "100%", h = "100%" },
		textSize = 18,
		textAlignment = "left",
	}

	x = x + canvas:minimumTextSize(#canvas, " ").w

	canvas[#canvas + 1] = {
		type = "text",
		text = user,
		textColor = { white = 1 },
		textFont = "Hack Nerd Font",
		frame = { x = x, y = 4, w = "100%", h = "100%" },
		textSize = 12,
		textAlignment = "left",
	}

	x = x + canvas:minimumTextSize(#canvas, user).w + 10

	canvas[#canvas + 1] = {
		type = "rectangle",
		action = "fill",
		frame = { x = x, y = 0, w = 75, h = "100%" },
		fillColor = { hex = "#2F90AF", alpha = 1 },
	}

	x = x

	canvas[#canvas + 1] = {
		type = "text",
		text = skhdMode,
		textColor = { hex = "#14111D" },
		textFont = "Hack Nerd Font",
		frame = { x = x, y = 4, w = 75, h = "100%" },
		textSize = 12,
		textAlignment = "center",
	}
end

updateCanvas()
canvas:show()

--------------------------------------------------------------------------------
-- Listen for skhd mode changes
--------------------------------------------------------------------------------

hs.socket.udp
	.server(9001, function(data)
		local message = data:gsub("\n", "")
		if skhdModes[message] then
			skhdMode = skhdModes[message]
			updateCanvas()
		end
	end)
	:receive()
