# What is Chocobot-CustomCommands?

A Plugin for [Chocobot](https://github.com/Gotos/Chocobot) for createing new commands on the fly, just like Nightbots CustomCommands.

# How-To

Chocobot-CustomCommands adds 4 new commands:
!addcom, !delcom, !editcom and !listcom.
The first three commands work just like Nightbots commands, with a few tweeks. Just like with nightbot, !addcom ![commandname] [message] will add a new command to Chocobot, which is callen ![commandname] and will simply output [message]. You can delete the command with !delcom ![commandname] or edit it's Message with !editcom ![commandname] [newmessage].
You can restrict the use of this commands to specific user-levels. !addcom -ul=mod ![cmdname] [messade] will generate a command which can only be used by moderators and channelowners. Userlevels can be all, sub, mod or owner or the usual nummeric represantation of Chocobot. Ofcourse !editcom can be used with userlevels, too! If no userlevel is given, userlevel all will be assumed.
Inside the message you can use Placeholders, just like in nightbot. Know placeholders are $(user), $(querry) and $(1) to $(9). $(user) will be replaced with the calling users name, $(querry) contains everything entered after the command itself and $(1) to $(9) will contain singel words after the command. For more information on this placeholders, please have a look at [Nightbots Wikipage on chat variables](http://wiki.nightbot.tv/chat:variables).
!listcom will output all commands added via CustomCommands the calling user can use.

# Install

Just place the CustomCommands-folder inside the "Plugins"-folder of Chocobot. If "Plugins" doesn't exist, create it. Also make sure to rename the CustomCommands-folder to "CustomCommands".
