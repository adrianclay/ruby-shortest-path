# Shortest path

Test driven shortest path algorithm in Ruby.

`shortest_path` takes in an array of connected edges, a start node, and a
finishing node and returns one of the shortest paths where you can travel from
start to end.

The graph is treated as bidirectional, i.e. an edge [:a, :b] can be traversed as
[:b, :a].

Example

```ruby
shortest_path([[:a, :b], [:b, :c], [:c, :d]], :a, :b)
 ==
[:a, :b, :c]
``` 
