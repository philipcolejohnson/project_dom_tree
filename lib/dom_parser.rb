Node = Struct.new(:data, :children, :parent)

class DomParser
  def initialize
    #@html = html
  end

  def parser_script(string)
    @elements = string.scan(/((?<=>).*?(?=<)|<.*?>)/)
  end

  def parse_tag(string)
    tag = {}

    # save tag after < character
    tag_type = string.match(/<(\w+)(?:>| )/)

    # saves either side of an equal sign
    attributes = string.scan(/(\w+)\s*=\s*['"](.*?)['"]/)

    #options
    options = string.scan(/\s*(\w)\s*[?!==]/)

    tag[:type] = tag_type[1]
    attributes.each do |attribute|
      tag[attribute[0].to_sym] = attribute[1]
    end

    tag
  end

  def create_tree
    parser_script(@html)
    @root = create_node(@elements[0])
    # current_node = @root
    make_children(@root, 1)
  end

  def create_node(tag, parent = nil)
    Node.new(tag, nil, parent)
  end


  def make_children(parent, tag_index)

    current_node = parent



    # return if the next one is a closing tag?
    loop do 
      return if closing_tag_for?(@elements[tag_index, parent])
      # if next one is a tag
      if opening_tag?(@elements[tag_index])
        create_node(parse_tag(@elements[tag_index]), parent)
      end
    end
    
    # create a node
    # make_children(node)
    # else
    # create a node
    # loops until we hit closing tag
  end

  def closing_tag_for?(current_tag, parent_node)
    #check if current tag is closing_tag && current_tag.type = parent_node.type.

  end

  def opening_tag?(tag)
    !closing_tag?(tag) && tag[0]=="<"
  end

  def closing_tag?(element)
    element[1] == "/" 
  end
end
