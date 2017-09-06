-- If not using then set the name to nil

minetest.register_privilege("setspawn", "Lets person set respawn point")
minetest.register_privilege("setpoint", "Lets person set predefined points")

myspawn = {}
myspawn.storage = minetest.get_mod_storage()

-- Nothing to change past here
-- Respawn function
minetest.register_on_respawnplayer(function(player)
    myspawn.go(player:get_player_name(), myspawn.get("spawn"))
    return true
end)


-- Teleport name to pos
myspawn.go = function(name, pos)
	if name ~= nil and pos ~= nil then
		local player = minetest.get_player_by_name(name)
		player:setpos(pos)
		return true
	end
	return false
end

-- Set registered point
myspawn.set = function(name, pos)
	if name ~= nil and pos ~= nil then
		myspawn.storage:set_string(name, minetest.pos_to_string(pos))
		return true
	end
	return false, "Erreur setting point "..name
end

-- Get registered point
myspawn.get = function(name)
	if name ~= nil then
		local value = myspawn.storage:get_string(name)
		return minetest.string_to_pos(value)
	end
	return false, "name is nil"
end

-- Commands
minetest.register_chatcommand("respawn", {
	description = "Teleport to spawn point",
	func = function(name)
		if myspawn.go(name, myspawn.get("spawn")) then
			return true
		end
		return false, "Spawn point error"
	end,
})

minetest.register_chatcommand("setspawn", {
	description = "Set spawn point",
	privs = {setspawn=true},
	func = function(name, txt)
		local player = minetest.get_player_by_name(name)
		local pos
		if txt == "" then
			pos = player:getpos()
			txt = minetest.pos_to_string(pos)
			minetest.log("Text is nil")
		else
			pos = minetest.string_to_pos(txt)
			minetest.log("Text:"..txt)
		end
		minetest.chat_send_player(name, "Position of spawn defined to "..txt)
		myspawn.set("spawn", pos)
		minetest.setting_set('static_spawnpoint', txt)
		minetest.setting_save()
		return true
	end,
})

minetest.register_chatcommand("getpoint", {
	description = "Get registered point",
	privs = {setpoint=true},
	func = function(name, txt)
		local point = myspawn.get(txt)
		minetest.chat_send_player(name, "Position "..txt.." defined to "..minetest.pos_to_string(point))
		return true
	end,
})

minetest.register_chatcommand("points", {
	description = "Get all registered points",
	privs = {setpoint=true},
	func = function(name, txt)
		local msg = ""
		for point, value in pairs(myspawn.storage:to_table().fields) do
			msg = msg.."\n"..point..": "..value
		end
		minetest.chat_send_player(name, "Configured points: \n"..msg)
		return true
	end,
})

minetest.register_chatcommand("go", {
	description = "Teleport to custom point",
	privs = {server=true},
	func = function(name, txt)
		local spawnpoint = myspawn.get(txt)
		if myspawn.go(name, spawnpoint) then
			minetest.chat_send_player(name, "Teleport to "..minetest.pos_to_string(spawnpoint))
			return true
		end
		return false, "Spawn point error "
	end,
})

minetest.register_chatcommand("setpoint", {
	description = "Set teleport point",
	privs = {setpoint=true},
	func = function(name, txt)
		--minetest.chat_send_player(name, "Debug:"..txt)
		local player = minetest.get_player_by_name(name)

		for point, value in txt:gmatch("([%w_-]+)%s(%S+[%s,]+%S+[%s,]+%S+)") do
			minetest.log("[myspawn] Defining point "..point.." value to ".. value)
			if point == "spawn" then
				return false, "Not allowed to set spawn point with this command"
			end
			local pos = minetest.string_to_pos(value)
			minetest.chat_send_player(name, "Position of "..point.." defined to "..value)
			myspawn.set(point, pos)
			return true
		end
		for point in txt:gmatch("([%w_-]+)") do
			local pos = player:getpos()
			local value = minetest.pos_to_string(pos)
			minetest.log("[myspawn] Defining point "..point.." value to ".. value)
			if point == "spawn" then
				return false, "Not allowed to set spawn point with this command"
			end
			minetest.chat_send_player(name, "Position of "..point.." defined to "..value)
			myspawn.set(point, pos)
			return true
		end

		return false, "Unable to set point"
	end
})


if minetest.setting_get('static_spawnpoint') == nil and myspawn.get("spawn") ~= false then
	minetest.setting_set('static_spawnpoint', minetest.pos_to_string(myspawn.get("spawn")))
	minetest.setting_save()
	minetest.log("[SPAWN] static_spawnpoint set !")
end



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
end)
]]--
