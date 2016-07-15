

def parse_tag(string)
  tag = {}
  tag_type = string.match(/<(\w+) /)
  attributes = string.scan(/(\w+)\s*=\s*['|"](.*?)['|"]/)

  
  tag[:type] = tag_type[1]
  attributes.each do |attribute|
    tag[attribute[0].to_sym] = attribute[1]
  end

  p tag 

end

# tag = parse_tag("<p class='foo bar' id='baz' src = 'hello'>")

# tag = parse_tag("<img src='http://www.example.com' title='funny things'>")