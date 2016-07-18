require 'dom'

describe TreeSearcher do

  describe "#search_by" do
    it "finds elements in children and parent node" do
      child = double(children:[], data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_by(:type, "p", parent).size).to eq(3)
    end

    it "can search with regular expressions" do
      child = double(children:[], data:{ type: "div" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "div" }, tag?:true)
      expect(subject.search_by(:type, /iv/, parent).size).to eq(3)
    end

    it "can search within text blocks" do
      child = double(children:[], data:"hello", tag?:false)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_by(:text, "hell", parent).size).to eq(2)
    end

    it "returns nil if there are no matches" do
      child = double(children:[], data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_by(:type, "img", parent)).to be(nil)
    end
  end

  describe "#search_children" do
    it "doesn't check itself" do
      child = double(children:[], data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_children(parent, :type, "p").size).to eq(2)
    end

    it "finds elements in children" do
      child = double(children:[], data:{ type: "div" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_children(parent, :type, "div").size).to eq(2)
    end

    it "can search with regular expressions" do
      child = double(children:[], data:{ type: "div" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "div" }, tag?:true)
      expect(subject.search_children(parent, :type, /iv/).size).to eq(2)
    end

    it "can search within text blocks" do
      child = double(children:[], data:"hello", tag?:false)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_children(parent, :text, "hell").size).to eq(2)
    end

    it "returns nil if there are no matches" do
      child = double(children:[], data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child], data:{ type: "p" }, tag?:true)
      expect(subject.search_children(parent, :type, "img")).to be(nil)
    end
  end

  describe "#search_ancestors" do
    it "doesn't check itself" do
      parent = double(data:{ type: "p" }, tag?:true, parent:nil)
      expect(subject.search_ancestors(parent, :type, "p")).to be(nil)
    end

    it "finds elements in ancestors" do
      child = double(children:[], tag?:true)
      parent = double(children: [child], data:{ type: "p" }, tag?:true, parent:nil)
      allow(child).to receive(:parent).and_return(parent)
      expect(subject.search_ancestors(child, :type, "p").size).to eq(1)
    end

    it "can search with regular expressions" do
      child = double(children:[], tag?:true)
      parent = double(children: [child], data:{ type: "div" }, tag?:true, parent:nil)
      allow(child).to receive(:parent).and_return(parent)
      expect(subject.search_ancestors(child, :type, /iv/).size).to eq(1)
    end

    it "can search within text blocks" do
      child = double(children:[], tag?:false)
      parent = double(children: [child], data:"hell", tag?:false, parent:nil)
      allow(child).to receive(:parent).and_return(parent)
      expect(subject.search_ancestors(child, :text, "hell").size).to eq(1)
    end

    it "returns nil if there are no matches" do
      child = double(children:[], tag?:true)
      parent = double(children: [child], data:{ type: "p" }, tag?:true, parent:nil)
      allow(child).to receive(:parent).and_return(parent)
      expect(subject.search_ancestors(child, :type, "img")).to be(nil)
    end
  end

end