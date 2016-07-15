class DomParser
  def initialize

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
end
