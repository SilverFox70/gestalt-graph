class Category 
  include Neo4j::ActiveNode
  property :kind, type: String
  property :create_at#, type: DateTime
  property :updated_at#, type: DateTime

  has_one :in, :map, origin: :categories
  has_many :in, :node, origin: :categories

  def this_map
    if self.map_id.nil?
      nil
    else
    	Map.find(self.map_id)
    end
  end

  def name
  	self.kind
  end

  def connections
    if self.node_ids.empty?
      []
    else
      Category.find(self.node_ids)
    end
  end

end
