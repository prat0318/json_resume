require_relative 'formatter'
require 'json'

module JsonResume
	class Reader
		attr_accessor :hash

		def initialize(json_input, output_type="html")
			@json_string = case json_input
						   when /\.json$/i then File.read(json_input)
						   else json_input
						   end
      @output_type = output_type
			begin
				@hash = JSON.parse(@json_string)
			rescue JSON::ParserError => e
				raise Exception, "Either you entered a file without .json extension or JSON string is wrong: "+e.message
			end
		end

    def format!
      @hash = JsonResume::Formatter.new(@hash, @output_type).format.hash
    end
	end
end    

