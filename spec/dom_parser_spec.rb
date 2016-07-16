require 'dom_parser'

describe DomParser do

  describe "#parser_script" do
    it "converts a string to array of tags" do
      string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
      expect(subject.parser_script(string).length).to eq(11)
    end

    it "parses a tag correctly" do
      string ="<div class='foo bar'>"
      expect(subject.parser_script(string).first).to eq(["<div class='foo bar'>"])
    end

    it "parses a text element" do 
      string ="<div class='foo bar'> hello </div>"
      expect(subject.parser_script(string)[1]).to eq([" hello "])
    end

  end

  describe "#parse_tag" do 
    it "returns a hash tag type and attributes" do 
      tag = "<p class=\"foo bar\" id='baz' src = 'hello' >"
      expect(subject.parse_tag(tag).keys).to eq([:type, :class, :id, :src])
    end

    it "has the correct values for each key" do
      tag = "<p class=\"foo bar\" id='baz' src = 'hello' >"
      expect(subject.parse_tag(tag).values).to eq(["p", "foo bar", "baz", "hello"])
    end

    it "handles closing tags" do
      tag = "</p>"
      expect(subject.parse_tag(tag)[:type]).to eq("p")
    end

  end

  describe "#closing_tag?" do 
    it "validates a normal closing tag" do
      tag = "</a>"
      expect(subject.closing_tag?(tag)).to be(true)
    end

    it "returns false when passed an opening tag" do
      tag = "<a>"
      expect(subject.closing_tag?(tag)).to be(false)
    end
  end

  describe "#opening_tag?" do
    it "returns true when passed an opening tag" do
      tag = "<a>"
      expect(subject.opening_tag?(tag)).to be(true)
    end

    it "returns false when passed an closing tag" do
      tag = "</a>"
      expect(subject.opening_tag?(tag)).to be(false)
    end
  end
end
