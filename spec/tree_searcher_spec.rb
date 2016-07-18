require 'tree_searcher'

describe TreeSearcher do

  describe "#search_by" do
    it "count child nodes one level" do
      child = double(children:nil)
      parent = double(children: [child, child])
      expect(subject.count_children(parent)).to eq(2)
    end

    it "counts multiple levels of children" do
      grand_children = double(children:nil)
      child = double(children: [ grand_children ])
      parent = double(children: [child, child])
      expect(subject.count_children(parent)).to eq(4)
    end
  end

  describe "#count_types" do
    it "count child nodes one level" do
      child = double(children:nil, data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child])
      expect(subject.count_types(parent)["p"]).to eq(2)
    end

    it "counts multiple levels of children" do
      grand_child = double(children:nil, data:{ type: "p" }, tag?:true)
      child = double(children:[ grand_child ], data:{ type: "p" }, tag?:true)
      parent = double(children: [child, child])
      expect(subject.count_types(parent)["p"]).to eq(4)
    end
  end
end