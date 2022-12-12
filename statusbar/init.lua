local webserver = hs.httpserver.hsminweb.new("./statusbar/public")
webserver:port(8080)
webserver:start()

local webview = hs.webview.new({ x = 0, y = 0, w = 1680, h = 24 }, { developerExtrasEnabled = true })
webview:behaviorAsLabels({ "canJoinAllSpaces" })
webview:url("http://localhost:" .. webserver:port())
webview:bringToFront(false)
webview:show()

hs.timer.doEvery(1, function()
	webview:evaluateJavaScript([[
	window.updateState({hej: 123})
	]])
end)
