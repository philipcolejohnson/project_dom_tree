Philip's DOM Reader

# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

instructiotree:

# load './lib/dom.rb'

tree = DomParser.new
tree.build_tree("./test.html")

r = NodeRenderer.new(tree)

# s = TreeSearcher.new(tree)
# divs = s.search_by(:type, "div")
# divs.each { |node| r.render(node) }