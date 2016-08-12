class Category 
  include Neo4j::ActiveNode
  property :kind, type: String

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

end
