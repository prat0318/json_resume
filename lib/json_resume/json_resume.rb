require_relative 'reader'

module JsonResume
	class << self
		def new(json_input)
			JsonResume::Core.new(json_input)
		end
	end

	class Core
		attr_accessor :reader
		
		def initialize(json_input)
			@reader = Reader.new(json_input)
			@reader.format!
		end
	end
end