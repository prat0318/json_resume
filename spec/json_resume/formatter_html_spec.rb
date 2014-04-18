require 'spec_helper'
require 'json_resume/formatter_html'

describe '#urlformatter' do
  context 'when given a link for html output' do
    it 'converts link to href' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test [Hello]{http://google.com}"
      formatter.format_link! str 
      expect(str).to eq('test <a href="http://google.com">Hello</a>')
    end

    it 'converts autolink to url' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test <<http://google.com>>"
      formatter.format_autolink! str 
      expect(str).to eq('test <a href="http://google.com">http://google.com</a>')
    end
    
    it 'converts links and autolinks to url' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test <<http://google.com>> [Hello]{http://google.com} <<http://google.com>>"
      formatter.format_string! str 
      expect(str).to eq('test <a href="http://google.com">http://google.com</a> <a href="http://google.com">Hello</a> <a href="http://google.com">http://google.com</a>')
    end
  end
end


