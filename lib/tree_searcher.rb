class TreeSearcher
  def initialize(tree = nil)
    raise ArgumentError unless tree.class == DomParser || tree.nil?
    @tree = tree
  end

  def search_by(attrib, value, node = nil)
    node = @tree.root unless node
    return_search_result(search(attrib, value, node))
  end

  def search_children(node, attrib, value)
      return nil if node.nil?
      nodes = find_children(node, attrib, value)
      return_search_result(nodes)
  end

  def search_ancestors(node, attrib, value)
    return nil if node.nil?
    nodes = []
    current_node = node
    until current_node.parent.nil?
      current_node = current_node.parent
      nodes << current_node if check_current_node(attrib, value, current_node)
    end
    return_search_result(nodes)
  end

  private
    def search(attrib, value, node)
      return nil if node.nil?
      nodes = []

      nodes << node if check_current_node(attrib, value, node)

      nodes += find_children(node, attrib, value)
    end

    def check_current_node(attrib, value, node)
      if value.is_a?(String)
        value = /#{value}/i
      end
      matches = false
      if attrib == :class && node.tag?
        unless node.data[:class].nil?
          classes = node.data[:class].split
          matches = true if classes.match(value)
        end
      elsif attrib == :text && !node.tag?
        matches = true if node.data.match(value)
      else
        matches = true if (node.tag? && 
                          node.data[attrib] &&
                          node.data[attrib].match(value))
      end
      matches
    end

    def find_children(node, attrib, value)
      return nil if node.nil?
      nodes = []
      node.children.each do |child|
        nodes += search(attrib, value, child) 
      end
      nodes
    end

    def return_search_result(nodes)
      return nil if nodes.empty?
      nodes
    end

end

