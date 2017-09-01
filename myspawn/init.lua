-- If not using then set the name to nil

local default_respawn = {x=-2413, y=10, z=-1540}

-- Spawn 1
local s1n = "spawn"
local s1 = default_respawn

-- Spawn 2
local s2n = "spawn2"
local s2 = {x=-2412, y=12, z=-1540}

--Spawn 3
local s3n = "spawn3"
local s3 = {x = 0, y = 0, z = 0}

-- Spawn 4
local s4n = nil
local s4 = {x = 0, y = 0, z = 0}

-- Spawn 5
local s5n = nil
local s5 = {x = 0, y = 0, z = 0}

-- Nothing to change past here
minetest.register_on_respawnplayer(function(player)
    player:setpos(default_respawn)
    return true
end)

myspawn = {}

myspawn.go = function(name, pos)
	if name ~= nil then
		if pos ~= nil then
			local player = minetest.get_player_by_name(name)
			player:setpos(pos)
			return true
		end
	end
	return false
end

minetest.register_chatcommand("respawn", {
	description = "Teleport to spawn point",
	func = function(name)
		if myspawn.go(name, default_respawn) then
			return true
		end
		return false, "Spawn point error"
	end,
})

--[[
minetest.register_on_chat_message(function(name, message, playername, player)
	if s1n ~= nil then
		local cmd = "/"..s1n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s1n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s1n)
				player:setpos(s1)
				return true
			end
		end
	end

	if s2n ~= nil then
		local cmd = "/"..s2n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s2n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s2n)
				player:setpos(s2)
				return true
			end
		end
	end

	if s3n ~= nil then
		local cmd = "/"..s3n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s3n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s3n)
				player:setpos(s3)
				return true
			end
		end
	end

	if s4n ~= nil then
		local cmd = "/"..s4n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s4n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s4n)
				player:setpos(s4)
				return true
			end
		end
	end

	if s5n ~= nil then
		local cmd = "/"..s5n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s5n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s5n)
				player:setpos(s5)
				return true
			end
		end
	end


end)
]]--
