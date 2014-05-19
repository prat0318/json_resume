require_relative 'formatter'

module JsonResume
  class FormatterLatex < Formatter

    def format_link str
        str.gsub! /\[(.*?)\]\((.*?)\)/, '{\color{see} \href{\2}{\1}}'
    end

    def format_autolink str
        str.gsub! /<<(\S*?)>>/, '{\color{see} \url{\1}}'
    end

    def format_emphasis str
      str.gsub! /_(.+?)_/, '\textit{\1}'
      str.gsub! /\*\*(.+?)\*\*/, '\textbf{\1}'
    end

    def format_superscripts str
      str.gsub! /<sup>(.*?)<\/sup>/, '$^{\1}$'
      str.gsub! /<sub>(.*?)<\/sub>/, '$_{\1}$'
    end

    def format_symbols str
      str.gsub! /%/, '\%'
      str.gsub! /_/, '\_'
    end

    def format_string str
      format_link str
      format_autolink str
      format_emphasis str
      format_symbols str
      format_superscripts str
    end

    def format
      super

      return self
    end
  end
end


