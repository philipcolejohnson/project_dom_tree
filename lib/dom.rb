require_relative './dom_parser'
require_relative './node_renderer'
require_relative './tree_searcher'

Node = Struct.new(:data, :depth, :children, :parent) do
  def tag?
    data.is_a?(Hash)
  end
end