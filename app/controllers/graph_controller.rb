class GraphController < ApplicationController

def index

end

def data
  @map = Map.find(params[:map_id])
  @categories = @map.categories
  p "--------- @map ---------"
  p @map.nodes.to_json
  response = { nodes: [], edges: []}
  @map.nodes.each do |n|
    response[:nodes] << {id: n.id, name: n.name, description: n.description}
    n.rels.each do |rel|
      start = idIndex(@map.nodes, rel.start_node.id)
      stop = idIndex(@map.nodes, rel.end_node.id)
      if !start.nil? && !stop.nil?
        response[:edges] << {source: start, target: stop, type: rel.rel_type }
      end
    end
  end
  index_offset = @map.nodes.count 
  @categories.each do |n|
    response[:nodes] << {id: n.id, name: n.name}
    n.rels.each do |rel|
      start = idIndex(@map.nodes, rel.start_node.id)
      stop = idIndex(@categories, rel.end_node.id, index_offset)
      if !start.nil? && !stop.nil?
        response[:edges] << {source: start, target: stop, type: rel.rel_type }
      end
    end
  end
  p "------------ response -----------"
  puts response.to_json
  respond_to do |format|
    format.html { render 'graph/show'}
    format.json { render json: response}
  end
end

private

def idIndex(a, id, offset = 0)
  p "--------- idIndex called ------------"
  a.each_with_index do |node, index|
    if node.id == id
      p "------- index ---------"
      p index
      return index + offset
    end
  end
  nil
end

end
