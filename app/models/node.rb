class Node 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String

  has_many :out, :categories, type: :HAS_CATEGORY
  has_one :in, :map, origin: :nodes

end
