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
    make_children(@root)
  end

  def create_node(tag, parent = nil)
    Node.new(tag, nil, parent)
  end

  def make_children(parent)
    # return if the next one is a closing tag?
    return if closing_tag?(@elements.first)
    # if next one is a tag
    
    # create a node
    # make_children(node)
    # else
    # create a node
    # loops until we hit closing tag
  end

  def closing_tag?(element)
    element[1] == "/" 
  end
end
