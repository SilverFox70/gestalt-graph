class Map 
  include Neo4j::ActiveNode
  property :title, type: String

  has_one :in, :author, type: :CREATED, model_class: :User
  has_many :out, :nodes, type: :HAS_NODES
  has_many :out, :categories, type: :HAS_CATEGORY


end
