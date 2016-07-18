require_relative './dom_parser'
require_relative './node_renderer'

class TreeSearcher
  def initialize(tree = nil)
    raise ArgumentError unless tree.class == DomParser || tree.nil?
    @tree = tree
  end

  def search_by(attrib, value, node = nil)
    node = @tree.root unless node
    search(attrib, value, node)
  end

  def search_children(node, attrib, value)
    nodes = []
    node.children.each do |child|
      nodes += search(attrib, value, child) 
    end
    nodes
  end

  def search_ancestors(node, attrib, value)
    current_node = node
    nodes = []
    until current_node.nil?
      nodes << current_node if check_current_node(attrib, value, current_node)
      current_node = current_node.parent
    end
    nodes
  end

  private
    def search(attrib, value, node)
      return nil if node.children.nil?
      nodes = []

      nodes << node if check_current_node(attrib, value, node)

      nodes += search_children(node, attrib, value)
    end

    def check_current_node(attrib, value, node)
      matches = false
      if attrib == :class && node.tag?
        unless node.data[:class].nil?
          classes = node.data[:class].split.map(&:downcase)
          matches = true if classes.include?(value.downcase)
        end
      elsif attrib == :text && !node.tag?
        matches = true if node.data.downcase.include?(value.downcase)
      else
        matches = true if (node.tag? && 
                          node.data[attrib] &&
                          node.data[attrib].downcase == value.downcase)
      end
      matches
    end

end

# load './lib/tree_searcher.rb'
d = DomParser.new
d.build_tree("./test.html")

# r = NodeRenderer.new(d)

# s = TreeSearcher.new(d)
# divs = s.search_by(:type, "div")
# divs.each { |node| r.render(node) }