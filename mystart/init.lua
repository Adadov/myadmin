
local servername = minetest.setting_get('server_name')

local f = assert(io.open(minetest.get_worldpath().."/rules.txt", "r"))
local the_text = f:read("*all")
f:close()

minetest.chat_send_all("Please tell the admin that the rules file needs to be created")

minetest.setting_set("default_privs", "shout")

minetest.register_on_newplayer(function(player)

	minetest.log('[MYSTART] New player '..player:get_player_name()..' with privs: '..dump(minetest.get_player_privs(player:get_player_name())))

	minetest.show_formspec(player:get_player_name(), "start_screen",

		"size[12,11;]"..
		"bgcolor[#0E1AD8;true]"..
		"textarea[0.5,0.5;11.5,8;name;;"..the_text.."]"..
		"label[4,7.5;Acceptez-vous les règles?]"..
		"label[4,8;Do you agree to follow the rules?]"..
		"button_exit[2,9;6,2;yes;OUI YES]"..
		"button_exit[7,9;6,2;no;NON NO]")

	minetest.register_on_player_receive_fields(function(player, start_screen, fields)
		local pname = player:get_player_name()
		local privs=minetest.get_player_privs(pname)

		if fields["yes"] then

			privs.shout=true
			privs.interact=true
			privs.home=true
			--privs.fast=false
			minetest.set_player_privs(pname,privs)

			return true

		elseif fields["no"] then

			minetest.kick_player(pname, "You need to agree to the rules to play!")

		end

	end)

end)


