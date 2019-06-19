def shortest_path(graph, start, finish)
  return [finish] if start == finish

  edges_from_start = graph.select { |edge| from(edge) == start }
  edges_to_start = graph.select { |edge| to(edge) == start }

  edges_from_start += reverse_edges(edges_to_start)

  return nil if (edges_from_start.empty?)

  possible_shortest_paths = []
  for edge in edges_from_start
    shortest_path_from_edge_from_start = shortest_path_using_edge(edge, finish, graph)
    possible_shortest_paths << [start] + shortest_path_from_edge_from_start unless shortest_path_from_edge_from_start.nil?
  end

  shortest_of_paths(possible_shortest_paths)
end

def shortest_path_using_edge(edge, finish, graph)
  graph_without_edge_from_start = graph_without_edge(graph, edge)
  shortest_path(graph_without_edge_from_start, to(edge), finish)
end

def reverse_edges(edges)
  edges.map{ |edge| [to(edge), from(edge)]}
end

def shortest_of_paths(paths)
  paths.sort_by!{|path| path.length }[0]
end

def graph_without_edge(graph, edge)
  graph = graph.dup
  graph.delete(edge)
  graph.delete([to(edge), from(edge)])
  graph
end

def from(edge)
  edge[0]
end

def to(edge)
  edge[1]
end

describe 'Dojos' do
  it 'solves a one-edge graph' do
    graph = [
      [:a, :b]
    ]

    expect(shortest_path(graph, :a, :b)).to eq([:a, :b])
  end

  it 'solves a graph with two sequential edges' do
    graph = [
      [:a, :b],
      [:b, :c]
    ]

    expect(shortest_path(graph, :a, :c)).to eq([:a, :b, :c])
  end

  it 'solves a graph with a wrong edge first' do
    graph = [
      [:a, :b],
      [:b, :c]
    ]

    expect(shortest_path(graph, :b, :c)).to eq([:b, :c])
  end

  it 'solves a two-step graph with wrong edges first' do
    graph = [
      [:a, :d],
      [:a, :e],
      [:a, :b],
      [:b, :c]
    ]

    expect(shortest_path(graph, :a, :c)).to eq([:a, :b, :c])
  end


  it 'chooses the shortest of two routes where first is wrong' do
    graph = [
      [:a, :b],
      [:b, :c],
      [:a, :c],
    ]

    expect(shortest_path(graph, :a, :c)).to eq([:a, :c])
  end

  it 'solves a one-edge graph backwards' do
    graph = [
      [:b, :a]
    ]

    expect(shortest_path(graph, :a, :b)).to eq([:a, :b])
  end

  it 'has a loop' do
    graph = [
      [:a, :b],
      [:b, :c],
      [:c, :a],
      [:a, :d],
    ]

    expect(shortest_path(graph, :a, :d)).to eq([:a, :d])
  end
end

