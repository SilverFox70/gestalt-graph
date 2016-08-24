class GraphController < ApplicationController

def index
  # not used
end

##
# Depending on th origin type of the request (html or json)
# this method either calls the show.html.erb file (html) or
# it returns the json object that the D3 graph is looking for
# in that some show file. Admittedly, these items should be in
# separate methods, and what you see here is the result of
# brute forcing something under time constraint.
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

##
# Since D3 version 3 creates edges between nodes based on their
# index position in the array as they are passed in, we need to
# keep track of the indexes of the connected nodes so that we
# can properly create edges in D3. Offset is used to account for
# iterating over the array of "category" nodes after the map nodes
# have been pushed into the array. Basically, it keeps the indexes
# lined up properly to define edges between map nodes and categories
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
