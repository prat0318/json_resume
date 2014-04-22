require_relative 'formatter'

module JsonResume
  class FormatterLatex < Formatter

    def format_linkedin_github_url
     @hash["linkedin_url"].gsub! /.*\/(.+?)\/?$/, '\1' if @hash["linkedin_url"] 
     @hash["github_url"].gsub! /.*\/(.+?)\/?$/, '\1' if @hash["github_url"] 
    end

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

    def format
      super

      format_linkedin_github_url

      self
    end
  end
end


