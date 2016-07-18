Philip's DOM Reader

# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

#INSTRUCTIONS:

### Load all the classes
load './lib/dom.rb'

### Read in HTML and build the object
tree = DomParser.new

tree.build_tree("./test.html")

tree.create_tree("HTML String")

r = NodeRenderer.new(tree)

s = TreeSearcher.new(tree)

### Search by string or regular expression
divs = s.search_by(:type, "div")

divs.each { |node| r.render(node) }

bodies = s.search_ancestors(divs[1], :type, "body")

bodies.each { |node| r.render(node) }

imgs = s.search_children(tree.root, :type, "img")

imgs.each { |node| r.render(node) }

### Change a node with tree.edit_element
#### note: changing a tag will also change its closing tag
####       or delete the closing tag if it's text

divs = s.search_by(:type, "div")

tree.edit_element(divs[0])

### Output the entire DOM structure
tree.output
