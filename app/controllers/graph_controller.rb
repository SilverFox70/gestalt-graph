class GraphController < ApplicationController

def index

end

def data
  @map = Map.find(params[:map_id])
  p "--------- @map ---------"
  p @map.nodes.to_json
  response = { nodes: [], links: []}
  @map.nodes.each do |n|
    response[:nodes] << {id: n.id, name: n.name}
    n.rels.each do |rel|
      start = idIndex(@map.nodes, rel.start_node.id)
      stop = idIndex(@map.nodes, rel.end_node.id)
      if !start.nil? && !stop.nil?
        response[:links] << {source: start, target: stop }
      end
    end
  end
  p "------------ response -----------"
  p response.to_json
  respond_to do |format|
    format.html { render 'graph/show'}
    format.json { render json: response}
  end
end

private

def idIndex(a, id)
  p "--------- idIndex called ------------"
  a.each_with_index do |node, index|
    if node.id == id
      p "------- index ---------"
      p index
      return index
    end
  end
  nil
end

end
