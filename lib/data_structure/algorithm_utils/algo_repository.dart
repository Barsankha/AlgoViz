import 'package:algov/core/utils/constants/description.dart';
import 'package:algov/core/utils/constants/psuedocode.dart';
import 'package:algov/data_structure/algorithm_utils/algo_info.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:flutter/material.dart';

class AlgorithmRepository {
  static final List<List<AlgorithmInfo>> allAlgorithms = [
    sortingAlgorithms,
    searchingAlgorithms,
    graphAlgos,
    linkedListAlgo,
    stackAlgo,
    queueAlgo,
    treeAlgos,
    hashAlgo,
  ];

  static final List<AlgorithmInfo> alorithm =
      allAlgorithms.expand((e) => e).toList();
  static AlgorithmInfo? findById(String id) {
    try {
      return alorithm.firstWhere((algo) => algo.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<AlgorithmInfo> sortingAlgorithms = [
    AlgorithmInfo(
      //
      id: 'ASO1',
      type: ArrayAlgorithmType.bubbleSort,
      title: "Bubble Sort", //
      description: ArraySorting.bubblesortDes,
      complexity: ["Ω(n)", "Θ(n²)", "O(n²)", "O(1)"],
      notes: "Stable, In-place",
      usecases: ["Educational purposes", "Very small datasets"],
      pros: ["Simple to understand and implement", "No extra memory"],
      cons: ["Very slow for large inputs", "Rarely use in Production systems"],
      icon: Icons.bubble_chart,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.bubblesortPsue,
    ),
    AlgorithmInfo(
      id: 'ASO2',
      type: ArrayAlgorithmType.selectionSort,
      title: "Selection Sort",
      description: ArraySorting.selectionDes,
      complexity: ["Ω(n²)", "Θ(n²)", "O(n²)", "O(1)"],
      notes: "Unstable, In-place",
      usecases: ["When memory writes are costly"],
      pros: ["Simple", "Minimal swaps"],
      cons: ["Always quadratic time"],
      icon: Icons.touch_app,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.selectionSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO3',
      type: ArrayAlgorithmType.insertionSort,
      title: "Insertion Sort",
      description: ArraySorting.insertionDes,
      complexity: ["Ω(n)", "Θ(n²)", "O(n²)", "O(1)"],
      notes: "Stable, In-place",
      usecases: ["Nearly sorted data", "Small datasets"],
      pros: ["Fast for small inputs", "Adaptive"],
      cons: ["Slow for large lists"],
      icon: Icons.input,
      complexityColor: Colors.orangeAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.insertionSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO4',
      type: ArrayAlgorithmType.mergeSort,
      title: "Merge Sort",
      description: ArraySorting.mergesortdes,
      complexity: ["Ω(n log n)", "Θ(n log n)", "O(n log n)", "O(n)"],
      notes: "Stable, Not In-place",
      usecases: ["Large datasets", "External sorting"],
      pros: ["Guaranteed performance", "Stable"],
      cons: ["Extra memory usage"],
      icon: Icons.merge,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.mergeSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO5',
      type: ArrayAlgorithmType.quickSort,
      title: "Quick Sort",
      description: ArraySorting.quickDes,
      complexity: ["Ω(n log n)", "Θ(n log n)", "O(n²)", "O(log n)"],
      notes: "Unstable, In-place",
      usecases: ["General-purpose sorting"],
      pros: ["Very fast in practice", "Cache friendly"],
      cons: ["Worst-case quadratic"],
      icon: Icons.flash_on,
      complexityColor: Colors.orangeAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.quickSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO6',
      type: ArrayAlgorithmType.cocktailSort,
      title: "Cocktail Sort",
      description: ArraySorting.cocktaildes,
      complexity: ["Ω(n)", "Θ(n²)", "O(n²)", "O(1)"],
      notes: "Stable, In-place",
      usecases: ["Slightly improved bubble sort"],
      pros: ["Better than bubble in some cases"],
      cons: ["Still quadratic"],
      icon: Icons.swap_horiz,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.cocktailSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO7',
      type: ArrayAlgorithmType.countingSort,
      title: "Counting Sort",
      description: ArraySorting.countingDes,
      complexity: ["Ω(n + k)", "Θ(n + k)", "O(n + k)", "O(k)"],
      notes: "Stable, Not comparison-based",
      usecases: ["Small integer ranges"],
      pros: ["Linear time", "Very fast"],
      cons: ["High memory usage"],
      icon: Icons.format_list_numbered,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.countingSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO8',
      type: ArrayAlgorithmType.cycleSort,
      title: "Cycle Sort",
      description: ArraySorting.cycledes,
      complexity: ["Ω(n²)", "Θ(n²)", "O(n²)", "O(1)"],
      notes: "Unstable, In-place",
      usecases: ["When memory writes are expensive"],
      pros: ["Minimum writes"],
      cons: ["Complex logic", "Slow"],
      icon: Icons.autorenew,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.cycleSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO9',
      type: ArrayAlgorithmType.heapSort,
      title: "Heap Sort",
      description: ArraySorting.heapdes,
      complexity: ["Ω(n log n)", "Θ(n log n)", "O(n log n)", "O(1)"],
      notes: "Unstable, In-place",
      usecases: ["Memory-constrained systems"],
      pros: ["Guaranteed performance", "No extra memory"],
      cons: ["Not cache friendly"],
      icon: Icons.account_tree,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.heapSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO10',
      type: ArrayAlgorithmType.introSort,
      title: "Intro Sort",
      description: ArraySorting.introdes,
      complexity: ["Ω(n log n)", "Θ(n log n)", "O(n log n)", "O(log n)"],
      notes: "Unstable, In-place",
      usecases: ["Standard library sorting"],
      pros: ["Best of multiple algorithms"],
      cons: ["Complex implementation"],
      icon: Icons.layers,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.introSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO11',
      type: ArrayAlgorithmType.redixSort,
      title: "Radix Sort",
      description: ArraySorting.redixdes,
      complexity: ["Ω(nk)", "Θ(nk)", "O(nk)", "O(n + k)"],
      notes: "Stable, Not comparison-based",
      usecases: ["Large integers", "Strings"],
      pros: ["Linear time"],
      cons: ["Extra memory"],
      icon: Icons.filter_list,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.radixSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO12',
      type: ArrayAlgorithmType.shellSort,
      title: "Shell Sort",
      description: ArraySorting.shelldes,
      complexity: ["Ω(n log n)", "Θ(n^1.5)", "O(n²)", "O(1)"],
      notes: "Unstable, In-place",
      usecases: ["Medium-sized arrays"],
      pros: ["Faster than insertion"],
      cons: ["Gap choice matters"],
      icon: Icons.space_bar,
      complexityColor: Colors.orangeAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.shellSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO13',
      type: ArrayAlgorithmType.timSort,
      title: "Tim Sort",
      description: ArraySorting.timdes,
      complexity: ["Ω(n)", "Θ(n log n)", "O(n log n)", "O(n)"],
      notes: "Stable, Not In-place",
      usecases: ["Real-world data", "Standard library sort"],
      pros: ["Very fast in practice"],
      cons: ["Extra memory"],
      icon: Icons.auto_graph,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.timSortPsue,
    ),

    AlgorithmInfo(
      id: 'ASO14',
      type: ArrayAlgorithmType.bucketSort,
      title: "Bucket Sort",
      description: ArraySorting.bucketdes,
      complexity: ["Ω(n)", "Θ(n + k)", "O(n²)", "O(n + k)"],
      notes: "Stable (depends), Not In-place",
      usecases: ["Uniformly distributed data"],
      pros: ["Fast average case"],
      cons: ["Poor worst case"],
      icon: Icons.inventory_2,
      complexityColor: Colors.orangeAccent,
      algoCategory: AlgoCategory.sorting,
      psuedocode: ArraySortPsuedoCode.bucketSortPsue,
    ),
    // AlgorithmInfo(
    //   id: 'AS015',
    //   type: ArraySorting().treeSort,

    //   title: "Tree Sort",
    //   description:
    //       "Inserts elements into a Binary Search Tree and retrieves them using inorder traversal.",
    //   complexity: ["Ω(n log n)", "Θ(n log n)", "O(n²)", "O(n)"],
    //   notes: "Unstable, Not In-place",
    //   usecases: [
    //     "Educational demonstrations of Binary Search Trees",
    //     "When balanced trees are used (e.g., AVL, Red-Black Tree)",
    //   ],
    //   pros: [
    //     "Conceptually simple and intuitive",
    //     "Produces sorted output via inorder traversal",
    //     "Efficient when the tree remains balanced",
    //   ],
    //   cons: [
    //     "Degrades to O(n²) for already sorted input",
    //     "Requires additional memory for tree nodes",
    //     "Not suitable for large datasets without self-balancing trees",
    //   ],
    //   icon: CupertinoIcons.tree,
    //   complexityColor: Colors.orangeAccent,
    // ),
  ];

  // searching algo
  static List<AlgorithmInfo> searchingAlgorithms = [
    /// LINEAR SEARC
    AlgorithmInfo(
      id: 'ASE1',
      type: ArraySortAlgoType.linearSearch,
      title: "Linear Search",
      description: ArraySearch.linear,
      complexity: ["Ω(1)", "Θ(n)", "O(n)", "O(1)"],
      notes: "Works on both sorted and unsorted data.",
      usecases: [
        "Very small datasets",
        "Unsorted arrays",
        "When simplicity is preferred",
      ],
      pros: [
        "Very easy to implement",
        "No need for sorted data",
        "No extra memory",
      ],
      cons: ["Slow for large datasets", "Not scalable"],
      icon: Icons.manage_search,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.linearSearchPsue,
    ),

    /// BINARY SEARCH
    AlgorithmInfo(
      id: 'ASE2',
      type: ArraySortAlgoType.binarySearch,
      title: "Binary Search",
      description: ArraySearch.binary,
      complexity: ["Ω(1)", "Θ(log n)", "O(log n)", "O(1)"],
      notes: "Array must be sorted before applying Binary Search.",
      usecases: [
        "Large sorted datasets",
        "Databases and indexing",
        "Search-heavy systems",
      ],
      pros: ["Very fast", "Highly efficient for large inputs"],
      cons: ["Requires sorted data", "Sorting cost may be expensive"],
      icon: Icons.fork_right,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.binarySearchPsue,
    ),

    /// JUMP SEARCH
    AlgorithmInfo(
      id: 'ASE3',
      type: ArraySortAlgoType.jumpSearch,
      title: "Jump Search",
      description: ArraySearch.jump,
      complexity: ["Ω(1)", "Θ(√n)", "O(√n)", "O(1)"],
      notes: "Works only on sorted arrays.",
      usecases: ["Sorted arrays", "When binary search is not feasible"],
      pros: ["Faster than Linear Search", "Simple implementation"],
      cons: ["Slower than Binary Search", "Requires sorted data"],
      icon: Icons.trending_flat,
      complexityColor: Colors.orange,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.jumpSearchPsue,
    ),

    /// INTERPOLATION SEARCH
    AlgorithmInfo(
      id: 'ASE4',
      type: ArraySortAlgoType.interpolationSearch,
      title: "Interpolation Search",
      description: ArraySearch.interpolation,
      complexity: ["Ω(1)", "Θ(log log n)", "O(n)", "O(1)"],
      notes: "Best for uniformly distributed sorted data.",
      usecases: ["Uniformly distributed datasets", "Large numerical ranges"],
      pros: ["Faster than Binary Search in best cases"],
      cons: ["Performs poorly on non-uniform data", "Complex logic"],
      icon: Icons.linear_scale,
      complexityColor: Colors.blue,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.interpolationSearchPsue,
    ),

    /// EXPONENTIAL SEARCH
    AlgorithmInfo(
      id: 'ASE5',
      type: ArraySortAlgoType.exponentialSearch,
      title: "Exponential Search",
      description: ArraySearch.exponential,
      complexity: ["Ω(1)", "Θ(log n)", "O(log n)", "O(1)"],
      notes: "Works on sorted arrays and useful for unbounded lists.",
      usecases: ["Unbounded or infinite arrays", "Large sorted datasets"],
      pros: [
        "Efficient for large arrays",
        "Better than Binary Search for unknown bounds",
      ],
      cons: ["Requires sorted data", "More complex than Binary Search"],
      icon: Icons.trending_up,
      complexityColor: Colors.teal,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.exponentialSearchPsue,
    ),
    AlgorithmInfo(
      id: 'ASE6',
      type: ArraySortAlgoType.fibonacciSearch,
      title: "Fibonacci Search",
      description: ArraySearch.finonacci,
      complexity: ["Ω(1)", "Θ(log n)", "O(log n)", "O(1)"],
      notes:
          "Works only on sorted arrays. Performs fewer comparisons than Binary Search in some cases.",
      usecases: [
        "Large sorted datasets",
        "Systems where division operations are costly",
      ],
      pros: [
        "Efficient for large datasets",
        "Uses only addition and subtraction",
        "Good cache performance",
      ],
      cons: [
        "Requires sorted data",
        "More complex than Binary Search",
        "Rarely used in practice",
      ],
      icon: Icons.functions,
      complexityColor: Colors.indigo,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.fibonacciSearchPsue,
    ),
    AlgorithmInfo(
      id: 'ASE7',
      type: ArraySortAlgoType.ternarySearch,
      title: "Ternary Search",
      description: ArraySearch.ternary,
      complexity: ["Ω(1)", "Θ(log n)", "O(log n)", "O(1)"],
      notes:
          "Works only on sorted data. Not faster than Binary Search in practice.",
      usecases: [
        "Educational purposes",
        "Unimodal functions (optimization problems)",
      ],
      pros: ["Conceptually simple", "Useful in function optimization problems"],
      cons: [
        "Slower than Binary Search due to extra comparisons",
        "Requires sorted data",
        "Rarely used in real systems",
      ],
      icon: Icons.segment,
      complexityColor: Colors.deepOrange,
      algoCategory: AlgoCategory.searching,
      psuedocode: ArraySearchPsuedocode.ternarySearchPsue,
    ),
  ];

  ///
  ///
  ///
  ///
  static List<AlgorithmInfo> graphAlgos = [
    // ================= BS =================
    AlgorithmInfo(
      id: 'G1',
      type: GraphAlgoType.breathFirstSearch,
      title: "Breadth First Search",
      description: GraphDes.breathFirstSearch,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Uses a queue. Guarantees shortest path in unweighted graphs.",
      usecases: [
        "Shortest path (unweighted)",
        "Level order traversal",
        "Connectivity checking",
      ],
      pros: ["Finds shortest path", "Simple and reliable"],
      cons: ["High memory usage", "Not suitable for weighted graphs"],
      icon: Icons.waves,
      complexityColor: Colors.green,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.breadthFirstSearchPsue,
    ),

    // ================= DFS =================
    AlgorithmInfo(
      id: 'G2',
      type: GraphAlgoType.depthFirstSearch,
      title: "Depth First Search",
      description: GraphDes.depthFirstSearch,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Uses recursion or stack. Does not guarantee shortest path.",
      usecases: ["Cycle detection", "Topological sorting", "Path existence"],
      pros: ["Low memory usage", "Good for deep traversal"],
      cons: ["May get stuck in deep paths", "No shortest path guarantee"],
      icon: Icons.account_tree,
      complexityColor: Colors.blue,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.depthFirstSearchPsue,
    ),

    // ================= DIJKSTRA =================
    AlgorithmInfo(
      id: 'G3',
      type: GraphAlgoType.dijkstra,
      title: "Dijkstra’s Algorithm",
      description: GraphDes.dijkstra,
      complexity: ["Ω(E log V)", "Θ(E log V)", "O(E log V)", "O(V)"],
      notes: "Does not support negative edge weights.",
      usecases: ["GPS navigation", "Network routing"],
      pros: ["Efficient", "Accurate shortest paths"],
      cons: ["Fails with negative weights"],
      icon: Icons.route,
      complexityColor: Colors.orange,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.dijkstraPsue,
    ),

    // ================= BELLMAN FORD =================
    AlgorithmInfo(
      id: 'G4',
      type: GraphAlgoType.bellManFord,
      title: "Bellman–Ford Algorithm",
      description: GraphDes.bellManFord,
      complexity: ["Ω(VE)", "Θ(VE)", "O(VE)", "O(V)"],
      notes: "Can detect negative cycles.",
      usecases: ["Graphs with negative weights", "Financial modeling"],
      pros: ["Handles negative weights", "Cycle detection"],
      cons: ["Slower than Dijkstra"],
      icon: Icons.warning,
      complexityColor: Colors.red,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.bellmanFordPsue,
    ),

    // ================= FLOYD WARSHALL =================

    // AlgorithmInfo(
    //   type: GraphAlgoType.floydWarshall,
    //   id: 'G5',
    //   title: "Floyd–Warshall Algorithm",
    //   description: GraphDes.floydWarshall,
    //   complexity: ["Ω(V³)", "Θ(V³)", "O(V³)", "O(V²)"],
    //   notes: "Matrix-based algorithm.",
    //   usecases: ["Dense graphs", "All-pairs shortest path"],
    //   pros: ["Very simple conceptually", "Handles negative weights"],
    //   cons: ["Extremely slow for large graphs"],
    //   icon: Icons.grid_on,
    //   complexityColor: Colors.purple,
    //   algoCategory: AlgoCategory.graph,
    //   psuedocode: [],
    // ),

    // ================= A* =================
    AlgorithmInfo(
      id: 'G6',
      type: GraphAlgoType.aStar,
      title: "A* Search",
      description: GraphDes.aStar,
      complexity: ["Ω(E)", "Θ(E)", "O(E)", "O(V)"],
      notes: "Performance depends on heuristic quality.",
      usecases: ["Game AI", "Pathfinding on maps"],
      pros: ["Very fast with good heuristic", "Optimal path"],
      cons: ["Needs heuristic"],
      icon: Icons.explore,
      complexityColor: Colors.teal,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.aStarPsue,
    ),

    // ================= KRUSKAL =================
    AlgorithmInfo(
      id: 'G7',
      type: GraphAlgoType.kruskal,
      title: "Kruskal’s MST",
      description: GraphDes.kruskal,
      complexity: ["Ω(E log E)", "Θ(E log E)", "O(E log E)", "O(V)"],
      notes: "Uses union–find.",
      usecases: ["Network design", "Clustering"],
      pros: ["Simple MST logic"],
      cons: ["Sorting edges is costly"],
      icon: Icons.linear_scale,
      complexityColor: Colors.indigo,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.kruskalPsue,
    ),

    // ================= PRIM =================
    AlgorithmInfo(
      id: 'G8',
      type: GraphAlgoType.prims,
      title: "Prim’s MST",
      description: GraphDes.prims,
      complexity: ["Ω(E log V)", "Θ(E log V)", "O(E log V)", "O(V)"],
      notes: "Similar to Dijkstra but for MST.",
      usecases: ["Dense graphs", "Network optimization"],
      pros: ["Efficient for dense graphs"],
      cons: ["Requires priority queue"],
      icon: Icons.device_hub,
      complexityColor: Colors.cyan,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.primsPsue,
    ),

    // ================= KAHN =================
    AlgorithmInfo(
      id: 'G9',
      type: GraphAlgoType.kahns,
      title: "Kahn’s Algorithm",
      description: GraphDes.kahns,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Detects cycles in DAGs.",
      usecases: ["Task scheduling", "Build systems"],
      pros: ["Cycle detection"],
      cons: ["Only for DAGs"],
      icon: Icons.sort,
      complexityColor: Colors.cyan,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.kahnsPsue,
    ),

    // ================= KOSARAJU =================
    AlgorithmInfo(
      id: 'G10',
      type: GraphAlgoType.kosaraju,
      title: "Kosaraju’s SCC",
      description: GraphDes.kosaraju,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Uses graph transpose.",
      usecases: ["Component compression"],
      pros: ["Easy to understand"],
      cons: ["Needs two DFS passes"],
      icon: Icons.layers,
      complexityColor: Colors.deepPurple,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.kosarajuPsue,
    ),

    // ================= TARJAN =================
    AlgorithmInfo(
      id: 'G11',
      type: GraphAlgoType.tarjan,
      title: "Tarjan’s SCC",
      description: GraphDes.tarjan,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Single DFS algorithm.",
      usecases: ["Compiler optimizations"],
      pros: ["Single pass"],
      cons: ["Harder to understand"],
      icon: Icons.timeline,
      complexityColor: Colors.deepOrange,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.tarjanPsue,
    ),

    // ================= TOPO SORT =================
    AlgorithmInfo(
      id: 'G12',
      type: GraphAlgoType.topologicalSort,
      title: "Topological Sort",
      description: GraphDes.topologicalSort,
      complexity: ["Ω(V + E)", "Θ(V + E)", "O(V + E)", "O(V)"],
      notes: "Only works on DAGs.",
      usecases: ["Dependency resolution"],
      pros: ["Simple"],
      cons: ["Fails on cyclic graphs"],
      icon: Icons.arrow_forward,
      complexityColor: Colors.greenAccent,
      algoCategory: AlgoCategory.graph,
      psuedocode: GraphPsuedoCode.topologicalSortPsue,
    ),
  ];

  static List<AlgorithmInfo> treeAlgos = [
    /// -------- Tree BFS --------
    AlgorithmInfo(
      id: 'T1',
      type: TreeAlgoType.bfs,
      title: "Breadth-First Search",
      description: TreeDes.bfs,
      complexity: ["Ω(n)", "Θ(n)", "O(n)", "O(n)"],
      notes: "Uses a queue; visits nodes by increasing depth.",
      usecases: [
        "Level-order traversal",
        "Finding shortest path in unweighted trees",
        "Serialization of trees",
      ],
      pros: ["Finds shortest path", "Level-wise traversal"],
      cons: ["High memory usage for wide trees"],
      icon: Icons.account_tree_outlined,
      complexityColor: Colors.greenAccent,
      algoCategory: AlgoCategory.tree,
      psuedocode: TreePsuedoCode.bfsPsue,
    ),

    /// -------- DFS In-Order (Binary Tree) --------
    AlgorithmInfo(
      id: 'T2',
      type: BinaryTreeAlgoType.dfsIn,
      title: "DFS In-Order",
      description: TreeDes.dfsin,
      complexity: ["Ω(n)", "Θ(n)", "O(n)", "O(h)"],
      notes: "Produces sorted output for Binary Search Trees.",
      usecases: ["BST traversal", "Sorted data retrieval"],
      pros: ["Sorted order in BST"],
      cons: ["Not applicable to non-binary trees"],
      icon: Icons.swap_horiz,
      complexityColor: Colors.lightGreen,
      algoCategory: AlgoCategory.binaryTree,
      psuedocode: TreePsuedoCode.dfsInPsue,
    ),

    /// -------- DFS Pre-Order --------
    AlgorithmInfo(
      id: 'T3',
      type: TreeAlgoType.dfsPre,
      title: "DFS Pre-Order",
      description: TreeDes.dfsPre,
      complexity: ["Ω(n)", "Θ(n)", "O(n)", "O(h)"],
      notes: "Root is processed before children.",
      usecases: ["Tree copying", "Prefix expression evaluation"],
      pros: ["Easy to serialize trees"],
      cons: ["Does not give sorted order"],
      icon: Icons.trending_up,
      complexityColor: Colors.lightGreen,
      algoCategory: AlgoCategory.tree,
      psuedocode: TreePsuedoCode.dfsPrePsue,
    ),

    /// -------- DFS Post-Order --------
    AlgorithmInfo(
      id: 'T4',
      type: TreeAlgoType.dfsPost,
      title: "DFS Post-Order",
      description: TreeDes.dfsPost,
      complexity: ["Ω(n)", "Θ(n)", "O(n)", "O(h)"],
      notes: "Children are processed before parent.",
      usecases: ["Tree deletion", "Expression tree evaluation"],
      pros: ["Useful for cleanup operations"],
      cons: ["Root processed last"],
      icon: Icons.trending_down,
      complexityColor: Colors.lightGreen,
      algoCategory: AlgoCategory.tree,
      psuedocode: TreePsuedoCode.dfsPostPsue,
    ),
  ];

  /// ===================== BINARY TREE =====================
  static List<AlgorithmInfo> binaryTreeAlgo = [
    AlgorithmInfo(
      id: 'T5',
      type: BinaryTreeAlgoType.dfsIn,
      title: "DFS In-Order",
      description: "Traverses the tree in Left → Root → Right order.",
      complexity: ["Ω(N)", "Θ(N)", "O(N)"],
      notes: "Commonly used in Binary Search Trees.",
      usecases: ["BST traversal", "Sorted output"],
      pros: ["Simple", "In-order sorting"],
      cons: ["Recursive stack usage"],
      icon: Icons.account_tree,
      complexityColor: Colors.greenAccent,
      algoCategory: AlgoCategory.tree,
      psuedocode: TreePsuedoCode.dfsInPsue,
    ),
  ];
  //
  /// ===================== LINKED LIST =====================
  static List<AlgorithmInfo> linkedListAlgo = [
    AlgorithmInfo(
      id: 'LL1',
      type: AlgoCategory.linkedList,
      title: "Linked List",
      description: ExtraDes.linkedList,
      complexity: ["Ω(N)", "Θ(N)", "O(N)"],
      notes: "Access is sequential only.",
      usecases: ["Iteration", "Searching"],
      pros: ["Dynamic size", "Memory efficient"],
      cons: ["No random access"],
      icon: Icons.linear_scale,
      complexityColor: Colors.blueAccent,
      algoCategory: AlgoCategory.linkedList,
      psuedocode: ExtraPsuedocode.linkedListPsue,
    ),
  ];

  /// ===================== STACK =====================
  static List<AlgorithmInfo> stackAlgo = [
    AlgorithmInfo(
      id: 'S1',
      type: AlgoCategory.stack,
      title: "Stack",
      description: ExtraDes.stackdes,
      complexity: ["Ω(1)", "Θ(1)", "O(1)"],
      notes: "Uses top pointer.",
      usecases: ["Undo/Redo", "Expression evaluation"],
      pros: ["Fast access"],
      cons: ["Limited access"],
      icon: Icons.layers,
      complexityColor: Colors.orangeAccent,
      algoCategory: AlgoCategory.stack,
      psuedocode: ExtraPsuedocode.stackPsue,
    ),
  ];

  /// ===================== QUEUE =====================
  static List<AlgorithmInfo> queueAlgo = [
    AlgorithmInfo(
      id: 'Q1',
      type: AlgoCategory.queue,
      title: "Queue",
      description: ExtraDes.queuedes,
      complexity: ["Ω(1)", "Θ(1)", "O(1)"],
      notes: "Used in scheduling.",
      usecases: ["BFS", "Task scheduling"],
      pros: ["Order preserved"],
      cons: ["Slower than stack"],
      icon: Icons.queue,
      complexityColor: Colors.purpleAccent,
      algoCategory: AlgoCategory.queue,
      psuedocode: ExtraPsuedocode.queuePsue,
    ),
  ];

  /// ===================== HASH =====================
  static List<AlgorithmInfo> hashAlgo = [
    AlgorithmInfo(
      id: 'H1',
      type: AlgoCategory.hashmap,
      title: "Hash Map",
      description: ExtraDes.hashMapDes,
      complexity: ["Ω(1)", "Θ(1)", "O(N)"],
      notes: "Collisions affect performance.",
      usecases: ["Caching", "Fast lookup"],
      pros: ["Very fast"],
      cons: ["Extra memory"],
      icon: Icons.grid_view,
      complexityColor: Colors.tealAccent,
      algoCategory: AlgoCategory.hashmap,
      psuedocode: ExtraPsuedocode.hashMapPsue,
    ),
    AlgorithmInfo(
      id: 'H2',
      type: AlgoCategory.hashset,
      title: "Hash Set",
      description: ExtraDes.hashSetDes,
      complexity: ["Ω(1)", "Θ(1)", "O(N)"],
      notes: "No duplicate values.",
      usecases: ["Uniqueness checks"],
      pros: ["Fast lookup"],
      cons: ["No ordering"],
      icon: Icons.check_box_outline_blank,
      complexityColor: Colors.tealAccent,
      algoCategory: AlgoCategory.hashset,
      psuedocode: ExtraPsuedocode.hashSetPsue,
    ),
  ];

  /// ===================== KNAPSACK =====================
  static List<AlgorithmInfo> knapsackAlgo = [
    AlgorithmInfo(
      id: 'KS1',
      type: AlgoCategory.values,
      title: "0/1 Knapsack",
      description: "Selects items to maximize value without repetition.",
      complexity: ["Ω(N×W)", "Θ(N×W)", "O(N×W)"],
      notes: "Dynamic Programming based.",
      usecases: ["Resource optimization"],
      pros: ["Optimal solution"],
      cons: ["High memory usage"],
      icon: Icons.backpack,
      complexityColor: Colors.redAccent,
      algoCategory: AlgoCategory.binaryTree,
      psuedocode: ArraySortPsuedoCode.bubblesortPsue,
    ),
  ];
}
