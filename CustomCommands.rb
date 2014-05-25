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

	def initialize(messager, logger)
		@messager = messager
	end

	def self.addPlugin()
		PluginLoader.addCommand(Command.new("!addcom", lambda do |data, priv|
			if priv <= 10
				getInstance.messager.message("Nope.") #not doing anything.
			end
		end))
		PluginLoader.addCommand(Command.new("!delcom", lambda do |data, priv|
			if priv <= 10
				getInstance.messager.message("Nope.") #not doing anything.
			end
		end))
		PluginLoader.addCommand(Command.new("!editcom", lambda do |data, priv|
			if priv <= 10
				getInstance.messager.message("Nope.") #not doing anything.
			end
		end))
	end
end
