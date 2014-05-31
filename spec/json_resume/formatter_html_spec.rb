require 'spec_helper'
require 'json_resume/formatter_html'
require 'json_resume/formatter'

describe "#padder" do
  it 'pads a row if items are odd' do
    hash = {'bio_data' => {'test' => [
                            {'name'=>'sub1', 'url' => 'url1'},
                            {'name'=>'sub2', 'url' => 'url2'},  
                            {'name'=>'sub3', 'url' => 'url3'}  
                          ]}
          }
    formatter = JsonResume::FormatterHtml.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']['test']['rows'].size).to eq(2)
    expect(formatter.hash['bio_data']['test']['rows'][-1]['columns'][-1]).to eq({})
  end

  it 'doesn\'t pad a row if items are even' do
    subs = [
              {'name'=>'sub1', 'url' => 'url1'},
              {'name'=>'sub2', 'url' => 'url2'}
          ]
    hash = {'bio_data' => {'test' => subs}}
    formatter = JsonResume::FormatterHtml.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']['test']['rows'].size).to eq(1)
    expect(formatter.hash['bio_data']['test']['rows'][0]['columns']).to eq(subs)
  end

  it 'ignores if data is null' do
    hash = {'bio_data' => {}}
    formatter = JsonResume::FormatterHtml.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']).to eq({})
  end
end 

describe '#urlformatter' do
  context 'when given a link for html output' do
    it 'converts link to href' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test [Hello](http://google.com)"
      formatter.format_link str 
      expect(str).to eq('test <a href="http://google.com">Hello</a>')
    end

    it 'converts autolink to url' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test <<http://google.com>>"
      formatter.format_autolink str 
      expect(str).to eq('test <a href="http://google.com">http://google.com</a>')
    end
    
    it 'converts links and autolinks to url' do
      formatter = JsonResume::FormatterHtml.new({})
      str = "test <<http://google.com>> [Hello](http://google.com) <<http://google.com>>"
      formatter.format_string str 
      expect(str).to eq('test <a href="http://google.com">http://google.com</a> <a href="http://google.com">Hello</a> <a href="http://google.com">http://google.com</a>')
    end
  end
end

describe "#emphasis_formatting" do
  it 'italicizes on _text_' do
    formatter = JsonResume::FormatterHtml.new({})
    str = "Last word should be _italicized_"
    formatter.format_emphasis str
    expect(str).to eq('Last word should be <i>italicized</i>')
  end

  it 'bolds on **text**' do
    formatter = JsonResume::FormatterHtml.new({})
    str = "Last word should be **bold**"
    formatter.format_emphasis str
    expect(str).to eq('Last word should be <b>bold</b>')
  end

  it 'italicizes and bolds if given both' do
    formatter = JsonResume::FormatterHtml.new({})
    str = "Last word should _be **bold and italicized**_"
    formatter.format_emphasis str
    expect(str).to eq('Last word should <i>be <b>bold and italicized</b></i>')
  end
end

describe "#format" do
  it 'calls parent format method' do
    formatter = JsonResume::FormatterHtml.new({'bio_data' => {}})
    expect(formatter).to receive(:cleanse).and_return(nil)
    formatter.format
  end
end


