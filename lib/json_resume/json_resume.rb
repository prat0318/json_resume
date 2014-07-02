require_relative 'reader'

module JsonResume
	class << self
		def new(json_input, options = {})
			options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
			JsonResume::Core.new(json_input, options)
		end
	end

	class Core
		attr_accessor :reader

		def initialize(json_input, options)
			@reader = Reader.new(json_input, options)
			@reader.format!
		end
	end
end
