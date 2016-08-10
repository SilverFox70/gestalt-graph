class Category 
  include Neo4j::ActiveNode
  property :kind, type: String

  has_one :in, :map, origin: :categories
  has_one :in, :node, origin: :categories


end
