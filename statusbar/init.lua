local getUser = require("statusbar/lua/getUser")
local getTime = require("statusbar/lua/getTime")

local webserver = hs.httpserver.hsminweb.new("./statusbar/public")
webserver:port(8080)
webserver:start()

local webviewController = hs.webview.usercontent.new("statusbar")

local webview = hs.webview.new({ x = 0, y = 0, w = 1680, h = 24 }, { developerExtrasEnabled = true }, webviewController)
webview:behaviorAsLabels({ "canJoinAllSpaces" })
webview:url("http://localhost:" .. webserver:port())
webview:bringToFront(false)
webview:show()

local function updateWebViewState(state)
	local str = "{"

	for k, v in pairs(state) do
		if v then
			str = str .. k .. ":" .. "'" .. v .. "',"
		end
	end

	str = str .. "}"

	webview:evaluateJavaScript("window.updateState(" .. str .. ")")
end

hs.timer.doEvery(1, function()
	local time = getTime()
	updateWebViewState({ time = time })
end)

local function onWebviewReady()
	local user = getUser()
	local time = getTime()
	print(user)
	updateWebViewState({ user = user, time = time })
end

webviewController:setCallback(onWebviewReady)
