require_relative './Model/CustomCommand.rb'

class CustomCommands

	attr_accessor :messager

	PluginLoader.registerPlugin("CustomCommands", self)

	def self.getInstance(messager = nil, logger = nil)
		if @instance == nil
			@instance = CustomCommands.new(messager, logger)
		end
		return @instance
	end

	def addCom(data, edit = false)
		priv = 40
		if data[0][0..3] == "-ul="
			case(data[0][4..-1])
			when "owner"
				priv = 0
			when "mod"
				priv = 10
			when "sub"
				priv = 20
			when "regular"
				priv = 20
			when "0"
				priv = 0
			else
				priv = data[0][4..-1].to_i
				if priv == 0
					@messager.message("Unbekannter Userlevel \"" + data[0][4..-1] + "\".")
					return false
				end
			end
			data = data.drop(1)
		end

		if data.length < 2
			@messager.message("Zu wenig Argumente.")
			return false
		end

		cmd = data[0]

		msg = data[1..-1].join(" ")

		command = Command.new(cmd, lambda do |data, actualPriv|
			if actualPriv < priv
				@messager.message(replaceVariables(msg, data))
			end
		end)

		if edit
			if !delCom(cmd, false)
				return false
			end
		end

		id = PluginLoader.addCommand(command)
		if id < 0
			@messager.message("Kommando " + command.cmd + " existiert bereits.")
		else
			@commandIDs[command.cmd] = id
			CustomCommand.create(:name => command.cmd, :msg => msg, :priv => priv)
			@messager.message("Kommando " + command.cmd + " wurde erfolgreich " + (edit ? "geändert." : "angelegt."))
		end
	end

	def delCom(cmd, verbose = true)
		if @commandIDs.key?(cmd)
			if PluginLoader.removeCommand(cmd, @commandIDs[cmd])
				@messager.message("Kommando " + cmd + " erfolgreich entfernt.") if verbose
				@commandIDs.delete(cmd)
				CustomCommand.get(cmd).destroy()
				return true
			end
		end
		@messager.message("Kommando " + cmd + " existiert nicht oder ist kein CustomCommands-Kommando.")
		return false
	end

	def replaceVariables(msg, data)
		for i in 0..8
			newmsg = msg.gsub("$(#{i+1})", data[i].to_s)
		end
		newmsg.gsub!("$(query)", data.join(" "))
		return newmsg
	end

	def initialize(messager, logger)
		@messager = messager
		@commandIDs = {}
		CustomCommand.all.each do |command|
			real_command = Command.new(command.name, lambda do |data, actualPriv|
				if actualPriv < command.priv
					@messager.message(replaceVariables(command.msg, data))
				end
			end)
			id = PluginLoader.addCommand(real_command)
			if id < 0
				@messager.message("Kommando " + real_command.cmd + " existiert bereits.")
			else
				@commandIDs[real_command.cmd] = id
			end
		end
	end

	def self.addPlugin()
		PluginLoader.addCommand(Command.new("!addcom", lambda do |data, priv|
			if priv <= 10
				getInstance.addCom(data)
			end
		end))
		PluginLoader.addCommand(Command.new("!delcom", lambda do |data, priv|
			if priv <= 10
				getInstance.delCom(data[0])
			end
		end))
		PluginLoader.addCommand(Command.new("!editcom", lambda do |data, priv|
			if priv <= 10
				getInstance.addCom(data, true)
			end
		end))
	end
end
