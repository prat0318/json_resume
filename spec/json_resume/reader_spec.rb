require 'spec_helper'
require 'json_resume/reader'

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
end

