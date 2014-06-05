require_relative 'formatter_html'
require_relative 'formatter_latex'
require_relative 'formatter_md'
require 'rest-client'
require 'json'

module JsonResume
	class Reader
		attr_accessor :hash

		def initialize(json_input, options)
      output_type = options[:output_type] || "html" #default html, others latex, md
			@json_string = case json_input
						   when /\.json$/i then File.read(json_input)
               when /^(http|https|www)/ then RestClient.get(json_input)
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
        :markdown => JsonResume::FormatterMd,
      }
      type = @output_type.to_sym
      @hash = formatters[type].new(@hash).format.hash
    end
	end
end    

