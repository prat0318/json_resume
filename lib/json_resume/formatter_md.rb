require_relative 'formatter'

module JsonResume
 class FormatterMd < Formatter
    def format_autolink str
        str.gsub! /<<(\S*?)>>/, '[\1](\1)'
    end
    
    def format_string str
      format_autolink str
    end

    def format
      super
      
      return self
    end

 end
end

