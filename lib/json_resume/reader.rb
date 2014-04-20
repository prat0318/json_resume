require_relative 'formatter_html'
require_relative 'formatter_latex'
require 'json'

module JsonResume
	class Reader
		attr_accessor :hash

		def initialize(json_input, output_type)
      output_type ||= "html"        #default html, others latex, mdown
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
      formatters = {
        :latex => JsonResume::FormatterLatex,
        :html => JsonResume::FormatterHtml,
      }
      type = @output_type.to_sym
      @hash = formatters[type].new(@hash).format.hash
    end
	end
end    

