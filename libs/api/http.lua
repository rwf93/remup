local chttp = require("https")
local buffer = require("./buffer")

local ru = RemUp
ru.HTTP = {}
local http = ru.HTTP

function http.Fetch(url, success, fail, headers, body, options)
	-- everything past url is optional

	return chttp.request(url, function(res)
		local size = 0
		local chunked = false
		local cont = ""

		for k,v in ipairs(res.headers) do
			local key = v[1]:lower()
			if key == "content-length" then
				contentLength = tonumber(v[2])
			elseif key == "content-encoding" then
				chunked = true
			end
		end

		local buf = buffer:new(size or 1024)
		local cursor = 0

		res:on("data", function(dat)
			dat:emit("Data", dat)
		end)

		res:on("end", function()
			dat:emit("Finish")
		end)
	end)

end