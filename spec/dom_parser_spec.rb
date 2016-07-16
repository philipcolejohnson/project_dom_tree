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

  describe "#closing_tag_for?" do
    it "identifies a closing tag pair" do
      opening_node = double(data: { type: "p" } )
      closing = "</p>"
      # allow(subject).to receive(:closing_tag?).and_return(true)
      expect(subject.closing_tag_for?(closing, opening_node))
        .to be(true)
    end

    it "returns false for an unmatched pair" do
      opening_node = double(data: { type: "p" } )
      closing = "</img>"
      # allow(subject).to receive(:closing_tag?).and_return(true)
      expect(subject.closing_tag_for?(closing, opening_node))
        .to be(false)
    end
  end

  describe "#make_children" do
    let(:parent) { subject.create_node(subject.parse_tag("<p>")) }
    let(:current_node) { double(elements: ["hi", "<img>", "</p>"] ) }

    it "creates child nodes of tags"

    it "creates child nodes of text"

    it "can make children of both text and tags"

    it "recursively calls #make_children on tag children" do

      allow(current_node).to receive(:closing_tag_for?).and_return(true, false)
      allow(current_node).to receive(:parse_tag)
        .and_return({ type: "img" }, { type: "img" }, { type: "p" }, { type: "p" })
      allow(current_node).to receive(:make_children).and_return(2 , 3)
      # allow(current_node).to receive(:elements).and_return("<p>")
      expect(current_node.children[0]).to receive(:make_children)
      current_node.make_children(parent, 0)
    end

    it "stops when it hits a closing tag match"
  end
end

# load './lib/dom_parser.rb'
# d = DomParser.new
# html = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
# d.create_tree(html)
