require 'spec_helper'
require 'json_resume/formatter'

describe "#cleanser" do
  context "when given a hash" do
    it 'removes empty keys in a single level' do
      hash = {"key1" => "", "key2" => ""}
      formatter = JsonResume::Formatter.new hash
      expect(formatter.cleanse.hash).to eq({})
    end

    it 'removes empty keys in a nested level' do
      hash = {"key1"=> "non-empty", "key2" => {"key3" => [], "key4" => ""}}
      formatter = JsonResume::Formatter.new hash
      expect(formatter.cleanse.hash).to eq({"key1"=> "non-empty"})
    end
  end
end

describe "#padder" do
  it 'pads a row if items are odd' do
    hash = {'bio_data' => {'test' => [
                            {'name'=>'sub1', 'url' => 'url1'},
                            {'name'=>'sub2', 'url' => 'url2'},  
                            {'name'=>'sub3', 'url' => 'url3'}  
                          ]}
          }
    formatter = JsonResume::Formatter.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']['test']['rows'].size).to eq(2)
    expect(formatter.hash['bio_data']['test']['rows'][-1]['columns'][-1]).to eq({'name'=>'', 'url'=>''})
  end

  it 'doesn\'t pad a row if items are even' do
    subs = [
              {'name'=>'sub1', 'url' => 'url1'},
              {'name'=>'sub2', 'url' => 'url2'}
          ]
    hash = {'bio_data' => {'test' => subs}}
    formatter = JsonResume::Formatter.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']['test']['rows'].size).to eq(1)
    expect(formatter.hash['bio_data']['test']['rows'][0]['columns']).to eq(subs)
  end

  it 'ignores if data is null' do
    hash = {'bio_data' => {}}
    formatter = JsonResume::Formatter.new hash
    formatter.add_padding('test')
    expect(formatter.hash['bio_data']).to eq({})
  end
end 

describe "#gpa_purger" do
  it 'removes gpa if not opted for' do
    hash = {'bio_data' => {'education' => {'show_gpa' => false, 'schools' => []}}}
    formatter = JsonResume::Formatter.new hash
    formatter.purge_gpa
    expect(formatter.hash['bio_data']['education']['show_gpa']).to be_nil
  end

  it 'removes gpa if gpa not mentioned' do
    hash = {'bio_data' => {'education' => {'show_gpa' => true, 'schools' => [{}]}}}
    formatter = JsonResume::Formatter.new hash
    formatter.purge_gpa
    expect(formatter.hash['bio_data']['education']['show_gpa']).to be_nil
  end
end
