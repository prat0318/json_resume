require 'spec_helper'
require 'json_resume/reader'
require 'json_resume/formatter'

describe "#reader" do
  context "when given a json file name" do
    it 'reads in the file' do
      File.should_receive(:read).with('test.json').and_return("{\"test\":1}")
      reader = JsonResume::Reader.new 'test.json'
      expect(reader.hash).to eq({"test"=>1})
    end
  end

  context "when given a json string" do
    it 'reads in the string' do
      reader = JsonResume::Reader.new "{\"test\":1}"
      expect(reader.hash).to eq({"test"=>1})
    end
  end

  context "when doing a format!" do
    it 'updates the hash with the formatted hash' do
      expect_any_instance_of(JsonResume::Formatter).to receive(:format).and_return(double(:hash =>{}))
      JsonResume::Reader.new("{\"test\":1}").format!
    end
  end
end

