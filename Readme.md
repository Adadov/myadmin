#myadmin
-------

Adds admin tools Player Join Rules, curseword detection, chat commands and more to Minetest.


#Contributors
- [DonBatman](https://github.com/DonBatman)
- [RobbieF](https://github.com/Cat5TV)
 

#Tools

2 tools included.

Ultimate tool - Removes node right away with no delay and no wear. Items do not go into inventory
				to get tool use /giveme ut

Ultimate tool with drops - Same as Ultimate tool except nodes go into your inventory
				to get tool use /giveme utd


#Chats

These are fun little chat commands. They include things like /afk, /back, /bbl, /happy, /sad, /mad
You can get a full list of the commands by using /chats

#Curse Words

This is a list of words that are banned on the server. These words can be editted in the settings.txt file.


#User Level (*myprivs*)

The User Level (myprivs) mod is a set of configurable privs for different levels of players. You can set the level with a chat command.

**Usage:** /userlevel player level

**Example Usage:** */userlevel DonBatman admin*

**Required Privs:** *myprivs_levels*

The available level options are:
- *super* - Super Admin
- *admin* - Admin
- *mod* - Moderator
- *helper* - Helper
- *interact* - Normal Player
- *prison* - Prisoner

Required minetest.conf options:
- *myprivs.prison=x,y,z* - Where to place prisoners. Should be an impenetrable fortress.
- *myprivs.prisontime=5* - Where 5 is how many real-life hours to send a player to prison for. Can be 0.5 for a half hour.
- *myprivs.spawn=x,y,z* - When prisoners are released, this is where should they spawn.


#Spawn

Spawn is an easy way to set spawn locations. In the settings.txt file you can set the chat command and coordinates for the spawn locations.


#Start

Start is the screen that is shown to new players when they join the server. You can list the rules in rules.txt. The player then can  agree to the rules or not.
If the player doess not agree to the rules then he/she will be kicked from the server.


#Extras

Extras are extra neat things that  I would like to see on servers. Right now there is only one extra but I plan on adding more.

/setbar is a command to set the size of the hotbar. You can set it from 1 - 16.



#Names Per IP

This is the names_per_ip mod from Krock. It limits the number of accounts that each ip address can have.
This is settable in the settings.txt.


#Guest

There is a setting to decide if you want to allow names with guest in them.
This is settable in settings.txt


#Password

A setting in the settingstxt to allow you to set whether or not you allow empty passwords.
This can be set in minetest.conf file as well.


#Underworld

This might not fit in this mod but I added it here anyway.

This is a teleporter that when set also places a teleporter below at what ever height you set it at.
Place a teleporter and a form opens. Name the teleporter and set the depth of the other. Click set.
When you step into the teleporter you will teleport down. After 10 seconds you can use the teleporter again.

You need the myadmin_levels_super priv to place and destroy the teleporters.













licence - DWYWPL
