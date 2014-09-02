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

describe "#format_to_output_type" do
  it 'should make format calls to all valid strings' do
    hash = {"key1"=> "non-empty", "key2" => {"key3" => ["test [Hello]{http://google.com}"]}}
    formatter = JsonResume::Formatter.new hash
    expect(formatter).to receive(:format_string).with("non-empty")
    expect(formatter).to receive(:format_string).with("test [Hello]{http://google.com}")
    formatter.format_to_output_type
  end
end

describe "#add_linkedin_github_url" do
  it 'creates linkedin url if id present' do
    hash = {"linkedin_id"=>"xyz"}
    formatter = JsonResume::Formatter.new hash
    formatter.add_linkedin_github_url
    expect(formatter.hash["linkedin_url"]).to eq("http://linkedin.com/in/xyz")
  end

  it 'creates github url if github id present' do
    hash = {"github_id"=>"xyz"}
    formatter = JsonResume::Formatter.new hash
    formatter.add_linkedin_github_url
    expect(formatter.hash["github_url"]).to eq("http://github.com/xyz")
  end

  it 'doesnt create url if id isnt present' do
    hash = {}
    formatter = JsonResume::Formatter.new hash
    formatter.add_linkedin_github_url
    expect(formatter.hash["linkedin_url"]).to be_nil
    expect(formatter.hash["github_url"]).to be_nil
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
