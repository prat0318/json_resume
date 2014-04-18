require 'spec_helper'
require 'json_resume/formatter_latex'

describe '#urlformatter' do
  context 'when given a link for latex output' do
    it 'converts link to href' do
      formatter = JsonResume::FormatterLatex.new({})
      str = "test [Hello]{http://google.com}"
      formatter.format_link! str 
      expect(str).to eq('test {\color{see} \href{http://google.com}{Hello}}')
    end

    it 'converts autolink to url' do
      formatter = JsonResume::FormatterLatex.new({})
      str = "test <<http://google.com>>"
      formatter.format_autolink! str 
      expect(str).to eq('test {\color{see} \url{http://google.com}}')
    end
    
    it 'converts links and autolinks to url' do
      formatter = JsonResume::FormatterLatex.new({})
      str = "test <<http://google.com>> [Hello]{http://google.com} <<http://google.com>>"
      formatter.format_string! str 
      expect(str).to eq('test {\color{see} \url{http://google.com}} {\color{see} \href{http://google.com}{Hello}} {\color{see} \url{http://google.com}}')
    end
  end
end


