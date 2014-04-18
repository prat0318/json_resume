require_relative 'formatter'

module JsonResume
 class FormatterHtml < Formatter
    def format_link! str
        str.gsub! /\[(.*?)\]{(.*?)}/, '<a href="\2">\1</a>'
    end

    def format_autolink! str
        str.gsub! /<<(\S*?)>>/, '<a href="\1">\1</a>'
    end
    
    def format_string! str
      format_link! str
      format_autolink! str
    end

 end
end

