
minetest.register_privilege("myprivs_levels", "Lets person set level of privlege people have")
minetest.register_privilege("myprivs_levels_super", "Lets person set level of privlege people have plus the super level")

minetest.register_chatcommand("myprivs_commands", {
	privs = {myprivs_levels = true},
	func = function(name, param)
		minetest.chat_send_player(name,"Available commands - /admin, /mod, /helper, /norm, /punish, /unpunish, silence, /ghost")
		return true
	end,
})

local function setprivs(param,mylevel)
	minetest.set_player_privs(param, {}) -- Reset all privileges to nothing
	if level == 0 then return end
	-- These are the base levels and should be left as is to establish the priv hierarchy
	-- In order to remove a priv from a level, do so within the chatcommand() after the call to setpriv()
	-- I'm counting in 5's so we can easily add other levels in between
	if level >= 5 then
		-- Restricted
		privs.shout=true
		privs.nointeract=true
		
		-- Normal
		if level >= 10 then
			privs.nointeract=false
			privs.interact=true
			privs.home=true
			privs.fast=true
		end
		
		-- Helper
		if level >= 15 then
			privs.fly=true
			privs.noclip=true
		end
		
		-- Moderator
		if level >= 20 then
			privs.myprivs_levels=true
			privs.teleport=true
			privs.tp_admin=true
			privs.basic_privs=true
			privs.kick=true
		end
		
		-- Admin
		if level >= 25 then
			privs.bring=true
			privs.ban=true
			privs.areas=true
		end
		
		-- Super Admin
		if level >= 50 then
			privs.give=true
			privs.privs=true
			privs.tps_magicchests=true
		end
		
		minetest.set_player_privs(param,privs)
	end
end

minetest.register_chatcommand("userlevel", {
	description = "Moderator/Administrator tool to control the privileges of players.",
	params = "<player> <prison|restrict|interact|helper|mod|admin|super>",
	privs = {myprivs_levels=true},
	func = setprivs
})

minetest.register_chatcommand("super_admin", {
	params = "",
	description = "Super Administrator",
	privs={myprivs_levels_super=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.give=true
			privs.teleport=true
			privs.tp_admin=true
			privs.bring=true
			privs.fast=true
			privs.fly=true
			privs.noclip=true
			privs.privs=true
			privs.basic_privs=true
			privs.kick=true
			privs.ban=true
			privs.areas=true
			privs.myprivs_levels=true
			privs.tps_magicchests=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Super Admin")
			minetest.chat_send_player(name, param .. " is now a Super Admin")
			return true
		end
end})

minetest.register_chatcommand("admin", {
	params = "",
	description = "Administrator",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.teleport=true
			privs.tp_admin=true
			privs.bring=true
			privs.fast=true
			privs.fly=true
			privs.noclip=true
			privs.basic_privs=true
			privs.kick=true
			privs.ban=true
			privs.areas=true
			privs.myprivs_levels=true
			privs.tps_magicchests=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now an Admin")
			minetest.chat_send_player(name, param .. " is now an Admin")
			return true
		end
end})

minetest.register_chatcommand("mod", {
	params = "",
	description = "Moderator",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.teleport=true
			privs.tp_admin=true
			privs.fast=true
			privs.fly=true
			privs.basic_privs=true
			privs.kick=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Moderator")
			minetest.chat_send_player(name, param .. " is now a Moderator")
			return true
		end
end})

minetest.register_chatcommand("helper", {
	params = "",
	description = "Helper",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			privs.fly=true
			privs.kick=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Helper")
			minetest.chat_send_player(name, param .. " is now a Helper")
			return true
		end
end})

minetest.register_chatcommand("norm", {
	params = "",
	description = "Normal Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Normal Player")
			minetest.chat_send_player(name, param .. " is now a Normal Player")
			return true
		end
end})

minetest.register_chatcommand("unpunish", {
	params = "",
	description = "Unpunish Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now unpunished")
			minetest.chat_send_player(name, param .. " is now unpunished")
			return true
		end
end})

minetest.register_chatcommand("punish", { -- will teleport them to prison, set timer, then give them nointeract and place them in spawn
	params = "",
	description = "Punish Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now being punished")
			minetest.chat_send_player(name, param .. " is now punished")
			return true
		end
end})

minetest.register_chatcommand("silence", {
	params = "",
	description = "Silence Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now silenced")
			minetest.chat_send_player(name, param .. " is now silenced")
			return true
		end
end})

minetest.register_chatcommand("ghost", {
	params = "",
	description = "Remove all privs",
	privs={myprivs_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
			minetest.chat_send_player(param, "You are now a ghost")
			minetest.chat_send_player(name, param .. " is now ghosted")
			return true
		end
end})
