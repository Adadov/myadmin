
minetest.register_privilege("myprivs_levels", "Lets person set level of privlege people have")
minetest.register_privilege("myprivs_levels_super", "Lets person set level of privlege people have plus the super level")
--[[
local myprivs={}

function myprivs.save()
        local file = io.open(minetest.get_worldpath().."/myprivs.txt", "w")
        if file then
                file:write(minetest.serialize(myprivs.players))
                file:close()
        end
end

function myprivs.load()
        local file = io.open(minetest.get_worldpath().."/myprivs.txt", "r")
        if file then
                local table = minetest.deserialize(file:read("*all"))
                if type(table) == "table" then
                        return table
                end
        end
        return {}
end

myprivs.players = myprivs.load()
function myprivs.player(name)
        return myprivs.players[name]
end

function myprivs.assertPlayer(playern,playerx,myprivs_level)
        myprivs.tbv(myprivs.players, playern)
        myprivs.tbv(myprivs.players[playern], "name", playern)
        myprivs.tbv(myprivs.players[playern], "setby", playerx)
        myprivs.tbv(myprivs.players[playern], "myprivs_level", myprivs_level)
end
]]--
local function setprivs(player,param)
	local leveltitle=" restricted player" -- the lowest level
	local levelnum=0
	local pname = minetest.get_player_by_name(player)
	local myprivs_level=myprivs.player(player)
	
	if param == "" then
		minetest.chat_send_player(player, "Usage: /userlevel <player> <prison|restrict|interact|helper|mod|admin|super>")
		return false
	end

	local args = param:split(" ") -- look into this. Can it crash if the player does not have two parameters?
	if #args < 2 then
		minetest.chat_send_player(player, "Usage: /userlevel <player> <prison|restrict|interact|helper|mod|admin|super>")
		return false
	end
	
	local playername=args[1]

	minetest.set_player_privs(playername, {}) -- Reset all privileges to nothing
	local privs=minetest.get_player_privs(param)
	
	-- Convert level names to numeric values for priv hierarchy
	-- need to confirm the user requesting this is at least this level
	if args[2]=="prison" then
		levelnum=0
		--teleport the player to prison for 1 hour and then teleport them to spawn with restricted access
		return
	end
	if args[2]=="restricted" then levelnum=5 end
	if args[2]=="interact" then levelnum=10 end
	if args[2]=="helper" then levelnum=15 end
	if args[2]=="mod" then levelnum=20 end
	if args[2]=="admin" then levelnum=25 end
	if args[2]=="super" then levelnum=50 end

	--myprivs.assertPlayer(playername,pname,levelnum)
	--myprivs.save()
	
	if levelnum == 0 then
		minetest.chat_send_player(player, "Usage: /userlevel <player> <prison|restrict|interact|helper|mod|admin|super>")
		return false
	end
	-- These are the base levels and should be left as is to establish the priv hierarchy
	-- In order to remove a priv from a level, do so within the chatcommand() after the call to setpriv()
	-- I'm counting in 5's so we can easily add other levels in between
	if levelnum >= 5 then
		-- Restricted
		privs.shout=true
		privs.nointeract=true
		leveltitle=" restricted player with the ability to gain interact"
		
		-- Normal
		if levelnum >= 10 then
			privs.nointeract=nil
			privs.interact=true
			privs.home=true
			privs.fast=true
			leveltitle=" normal player"
		end
		
		-- Helper
		if levelnum >= 15 then
			privs.fly=true
			privs.noclip=true
			leveltitle=" helper"
		end
		
		-- Moderator
		if levelnum >= 20 then
			privs.myprivs_levels=true
			privs.teleport=true
			privs.tp_admin=true
			privs.basic_privs=true
			privs.kick=true
			leveltitle=" moderator"
		end
		
		-- Admin
		if levelnum >= 25 then
			privs.bring=true
			privs.ban=true
			privs.areas=true
			leveltitle="n admin"
		end
		
		-- Super Admin
		if levelnum >= 50 then
			privs.give=true
			privs.privs=true
			privs.tps_magicchests=true
			leveltitle=" super admin"
		end
		
		minetest.set_player_privs(playername,privs)
		minetest.chat_send_player(player, playername .. " is now a" .. leveltitle .. ".")
	end
end

minetest.register_chatcommand("userlevel", {
	description = "Moderator/Administrator tool to control the privileges of players. Usage: /userlevel <player> <prison|restrict|interact|helper|mod|admin|super>",
	params = "<player> <prison|restrict|interact|helper|mod|admin|super>",
	privs = {myprivs_levels=true},
	func = setprivs
})

