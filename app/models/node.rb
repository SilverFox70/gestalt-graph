class Node 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String

  has_many :out, :categories, type: :HAS_CATEGORY
  has_one :in, :map, origin: :nodes

  def self.categories
  	Category.find(node.category_ids)
  end

  def map_title
  	p "------------- getting map title --------------"
  	Map.find(self.map_id).title
  end
end
