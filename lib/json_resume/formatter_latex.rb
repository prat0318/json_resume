require_relative 'formatter'

module JsonResume
  class FormatterLatex < Formatter

    def format_link! str
        str.gsub! /\[(.*?)\]{(.*?)}/, '{\color{see} \href{\2}{\1}}'
    end

    def format_autolink! str
        str.gsub! /<<(\S*?)>>/, '{\color{see} \url{\1}}'
    end

    def format_string! str
      format_link! str
      format_autolink! str
    end
  end
end


