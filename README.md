Philip's DOM Reader

# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

INSTRUCTIONS:

# loads all the classes
load './lib/dom.rb'

# alternatively, use tree.create_tree("HTML String")
tree = DomParser.new
tree.build_tree("./test.html")

r = NodeRenderer.new(tree)
s = TreeSearcher.new(tree)

# search by string or regular expression
divs = s.search_by(:type, "div")
divs.each { |node| r.render(node) }

# use tree.edit_element to change a node
# note: changing a tag will also change its closing tag
#       or delete the closing tag if it's text
divs = s.search_by(:type, "div")
tree.edit_element(divs[0])