class Map 
  include Neo4j::ActiveNode
  property :title, type: String
  property :create_at#, type: Datetime
  property :updated_at#, type: DateTime

  has_one :in, :author, type: :CREATED, model_class: :User
  has_many :out, :nodes, type: :HAS_NODES
  has_many :out, :categories, type: :HAS_CATEGORY

  def self.categories
  	Category.find(map.category_ids)
  end

end
