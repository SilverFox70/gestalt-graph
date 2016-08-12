class Node 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String

  has_many :out, :categories, type: :HAS_CATEGORY
  has_one :in, :map, origin: :nodes
  has_many :out, :nodes, type: 'connects'

  def self.categories
  	Category.find(node.category_ids)
  end

  def node_map
  	Map.find(self.map_id)
  end

  def connections
    if self.node_ids.empty?
      []
    else
      Node.find(self.node_ids)
    end
  end

end
