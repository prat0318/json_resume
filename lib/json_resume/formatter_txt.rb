require_relative 'formatter'

module JsonResume
  class FormatterTxt < Formatter
    def format_string str
    end

    def format
      super

      return self
    end
  end
end


