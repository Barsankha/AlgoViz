enum AlgoPhase {
  initialization,
  selection,
  exploration,
  relaxation,
  stackPhase,
  unionFind,
  completion,
}

enum AlgoOp {
  initVisited,
  initDistance,
  initParent,
  initIndegree,
  initDisjointSet,

  enqueue,
  dequeue,
  pushStack,
  popStack,

  visitNode,
  markVisited,

  exploreEdge,
  relaxEdge,

  selectMin,
  updateHeuristic,

  unionSet,
  findSet,

  outputResult,
}
