class Node 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String

  has_many :out, :category, type: :HAS_CATEGORY


end
