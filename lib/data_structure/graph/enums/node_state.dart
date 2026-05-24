enum NodeState {
  unvisited,
  discovered, // in queue / stack
  current,
  visited,
  path,
  scc,
  error,
  normal,
}

enum EdgeState { normal, exploring, selected }
