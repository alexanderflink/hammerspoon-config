local function getUser()
	return string.gsub(hs.execute("whoami"), "\n", "")
end

return getUser
