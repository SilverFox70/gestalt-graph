class GraphController < ApplicationController

def index

end

def data
  @map = Map.find(params[:map_id])
  p "--------- @map ---------"
  p @map.nodes.to_json
  response = { nodes: [], rels: []}
  @map.nodes.each do |n|
    response[:nodes] << {id: n.id, name: n.name}
  end
  p "------------ response -----------"
  p response.to_json
  respond_to do |format|
    format.html { render 'graph/show'}
    format.json { render json: response}
  end
end

end
