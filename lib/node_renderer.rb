class NodeRenderer
  def initialize(tree = nil)
    raise ArgumentError unless tree.class == DomParser || tree.nil?
    @tree = tree
  end

  def render(node = nil)
    node = @tree.root if node.nil?

    puts
    puts "Current element:"
    string = ""
    if node.tag?
      string << "<#{node.data[:type]}"
      node.data.each do |key, value|
        unless key == :type
          string << " #{key.to_s}=\"#{value}\""
        end
      end
      string << ">"
    else
      string << "'#{node.data}'"
    end
    puts string

    children = count_children(node)
    puts "# of nodes beneath this node: #{ children }"

    type_count = count_types(node)
    type_count.each do |key, value|
      puts"<#{key}> count: #{ value }"
    end
    puts
  end

  def count_children(node)
    return 0 if node.children.nil?
    count = node.children.size
    node.children.each do |child|
      count += count_children(child) 
    end
    count
  end

  def count_types(node)
    return {} if node.children.nil?
    type_count = Hash.new(0)
    node.children.each do |child|
      if child.tag?
        type_count[ child.data[:type] ] += 1
      else
        type_count[ "text" ] += 1
      end
      
      count_types(child).each do |key, count|
        type_count[key] += count
      end
    end
    type_count
  end
end