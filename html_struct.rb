

def parse_tag(string)
  tag = {}
  
  # save tag after < character
  tag_type = string.match(/<(\w+) /)

  # saves either side of an equal sign
  attributes = string.scan(/(\w+)\s*=\s*['"](.*?)['"]/)

  #options
  options = string.scan(/\s*(\w)\s*[^=]/)
  
  tag[:type] = tag_type[1]
  attributes.each do |attribute|
    tag[attribute[0].to_sym] = attribute[1]
  end

  tag

end

# p tag = parse_tag("<p class=\"foo bar\" id='baz' src = 'hello' repeat>")

# p tag = parse_tag("<img src='http://www.example.com' title = 'funny things' repeat>")
p tag = parse_tag("<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
)

Node = Struct.new(:data, :children, :parent)

def parser_script(string)


end


html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

