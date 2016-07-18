require 'dom'

describe DomParser do

  # describe "#parser_script" do
  #   it "converts a string to array of tags" do
  #     string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
  #     subject.parser_script(string)
  #     expect(subject.elements.length).to eq(10)
  #   end

  #   it "parses a tag correctly" do
  #     string ="<div class='foo bar'>"
  #     subject.parser_script(string)
  #     expect(subject.elements.first).to eq("<div class='foo bar'>")
  #   end

  #   it "parses a text element" do 
  #     string ="<div class='foo bar'> hello </div>"
  #     subject.parser_script(string)
  #     expect(subject.elements[1]).to eq("hello")
  #   end

  #   it "recognizes tags when there are no spaces between them" do
  #     string = "<html><div></div> Text <p></p></html>"
  #     subject.parser_script(string)
  #     expect(subject.elements[1]).to eq("<div>")
  #   end

  #   it "handles newline characters" do
  #     string = "<html><div></div> Text\n <p></p></html>"
  #     subject.parser_script(string)
  #     expect(subject.elements[4]).to eq("<p>")
  #   end

  # end

  # describe "#parse_tag" do 
  #   it "returns a hash tag type and attributes" do 
  #     tag = "<p class=\"foo bar\" id='baz' src = 'hello' >"
  #     expect(subject.parse_tag(tag).keys).to eq([:type, :class, :id, :src])
  #   end

  #   it "has the correct values for each key" do
  #     tag = "<p class=\"foo bar\" id='baz' src = 'hello' >"
  #     expect(subject.parse_tag(tag).values).to eq(["p", "foo bar", "baz", "hello"])
  #   end

  #   it "handles closing tags" do
  #     tag = "</p>"
  #     expect(subject.parse_tag(tag)[:type]).to eq("p")
  #   end

  # end

  # describe "#closing_tag?" do 
  #   it "validates a normal closing tag" do
  #     tag = "</a>"
  #     expect(subject.closing_tag?(tag)).to be(true)
  #   end

  #   it "returns false when passed an opening tag" do
  #     tag = "<a>"
  #     expect(subject.closing_tag?(tag)).to be(false)
  #   end
  # end

  # describe "#opening_tag?" do
  #   it "returns true when passed an opening tag" do
  #     tag = "<a>"
  #     expect(subject.opening_tag?(tag)).to be(true)
  #   end

  #   it "returns false when passed an closing tag" do
  #     tag = "</a>"
  #     expect(subject.opening_tag?(tag)).to be(false)
  #   end
  # end

  # describe "#closing_tag_for?" do
  #   it "identifies a closing tag pair" do
  #     opening_node = double(data: { type: "p" } )
  #     closing = "</p>"
  #     # allow(subject).to receive(:closing_tag?).and_return(true)
  #     expect(subject.closing_tag_for?(closing, opening_node))
  #       .to be(true)
  #   end

  #   it "returns false for an unmatched pair" do
  #     opening_node = double(data: { type: "p" } )
  #     closing = "</img>"
  #     # allow(subject).to receive(:closing_tag?).and_return(true)
  #     expect(subject.closing_tag_for?(closing, opening_node))
  #       .to be(false)
  #   end
  # end

  # describe "#tag_node?" do
  #   it "returns true when node is a tag" do
  #     node = double(data:{})
  #     expect(subject.tag_node?(node)).to be(true)
  #   end

  #   it "returns false when node isn't  a tag" do
  #     node = double(data:"Not a tag")
  #     expect(subject.tag_node?(node)).to be(false)
  #   end
  # end

  describe "#create_tree" do 
    it "creates all first level nodes" do
      html = "<html> <div> </div> Text <p> </p> </html>"
      subject.create_tree(html)
      expect(subject.root.children.length).to eq(3)
    end

    it "creates child nodes for first level nodes" do
      html = "<html> <div> <p> </p> </div> </html>"
      subject.create_tree(html)
      expect(subject.root.children[0].children[0].data[:type]).to eq("p")
    end

    it "raises an error if the doctument doesn't start with a tag" do
      html = "Not HTML"
      expect{ subject.create_tree(html) }.to raise_error(ArgumentError )
    end
  end

end
