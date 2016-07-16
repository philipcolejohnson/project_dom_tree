Node = Struct.new(:data, :depth, :children, :parent)

class DomParser
  TAG_TYPE_REGEX = /<[\/|!]?(\w+)(?:>| )/
  TAG_ATTR_REGEX = /(\w+)\s*=\s*['"](.*?)['"]/
  HTML_REGEX = /((?<=>).*?(?=<)|<.*?>)/

  attr_reader :root, :elements

  def initialize
    #@html = html
    @elements = []
  end

  def output
    print_all(@root)
  end

  def print_all(node)
    
    print_node(node)
    
    node.children.each { |child| print_all(child) }
  
    print_closing_tag(node) if tag_node?(node)
  end

  def print_node(node)
    string = "   " * node.depth
    if tag_node?(node)
      string << "<#{node.data[:type]}"
      node.data.each do |key, value|
        unless key == :type
          string << " #{key.to_s}=\"#{value}\""
        end
      end
      string << ">"
    else
      string << node.data
    end
    puts string
  end

  def print_closing_tag(tag_node)
    begin
      string = "   " * tag_node.depth
      string << "</#{tag_node.data[:type]}>"
      puts string
    rescue
      raise "#{tag_node.data} is not a tag"
    end
  end

  def parser_script(string)
    # save everything, split by tags or text
    string.scan(HTML_REGEX).each { |item| @elements << item[0] }
  end

  def parse_tag(string)
    tag = {}

    # save tag after < character
    tag_type = string.match(TAG_TYPE_REGEX)

    # saves either side of an equal sign
    attributes = string.scan(TAG_ATTR_REGEX)

    #options (TODO)
    # options = string.scan(/\s*(\w)\s*[?!==]/)

    tag[:type] = tag_type[1]
    attributes.each do |attribute|
      tag[attribute[0].to_sym] = attribute[1]
    end

    tag
  end

  def create_tree(html)
    parser_script(html)
    if tag?(@elements[0])
      first = parse_tag(@elements[0]) 
    else
      raise "Not an HTML document."
    end
    begin_process(first)
  end

  def begin_process(first)
    if first[:type] == "DOCTYPE"
      @root = create_node(parse_tag(@elements[1]), 0)
      make_children(@root, 2)
    else
      @root = create_node(first, 0)
      make_children(@root, 1)
    end
  end

  #creates a node with no children and an optional parent
  def create_node(data, depth, parent = nil)
    Node.new(data, depth, [], parent)
  end


  def make_children(parent, tag_index) 

    loop do
      return true if @elements[tag_index].nil?
      return tag_index + 1 if closing_tag_for?(@elements[tag_index], parent)
    
      if opening_tag?(@elements[tag_index])
        tag_index = create_tag_child(@elements[tag_index], parent, tag_index)
      elsif !tag?(@elements[tag_index])
        create_text_child(@elements[tag_index], parent)
        tag_index += 1
      else
        # we've hit an unexpected closing tag
        raise "Closing tag #{@elements[tag_index]} is incorrectly placed"
      end
    end

  end

  #accepts a string and a parent node and sees string is the closing tag
  def closing_tag_for?(current_element, parent_node)
    if tag?(current_element)
      return false if !closing_tag?(current_element)
      current_element = parse_tag(current_element)
      current_element[:type] == parent_node.data[:type]
    else
      false
    end
  end

  def create_tag_child(string, parent, tag_index)
    new_child = create_node(parse_tag(string), parent.depth + 1, parent)
    parent.children << new_child
    tag_index = make_children(new_child, tag_index + 1)
  end

  def create_text_child(string, parent)
    parent.children << create_node(string, parent.depth + 1, parent)
  end

  def opening_tag?(tag)
    !closing_tag?(tag) && tag[0]=="<"
  end

  def closing_tag?(element)
    element[1] == "/" 
  end

  def tag?(string)
    string[0] == "<"
  end

  def tag_node?(node)
    node.data.is_a?(Hash)
  end
end
