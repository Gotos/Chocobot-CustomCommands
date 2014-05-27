require 'rubygems'
require 'data_mapper'

class CustomCommand
	include DataMapper::Resource

	property :name,				String, :required => true, :key => true
	property :msg,				Text, :required => true
	property :priv,				Integer, :required => true, :default => 0
end
