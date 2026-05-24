import 'package:algov/data_structure/array/algorithms/searching/binary_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/exponential_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/fibonacci_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/interpolation_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/jump_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/linear_search.dart';
import 'package:algov/data_structure/array/algorithms/searching/ternary_search.dart';
import 'package:algov/data_structure/array/algorithms/sorting/bubble_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/bucket_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/cocktail_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/counting_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/cycle_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/heap_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/insertion_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/intro_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/merge_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/quick_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/redix_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/selection_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/shell_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/tim_sort.dart';
import 'package:algov/data_structure/array/algorithms/sorting/tree_sort.dart';
import 'package:algov/data_structure/graph/algorithms/searching/astar_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/bellman_ford_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/breath_first_search.dart';
import 'package:algov/data_structure/graph/algorithms/searching/depth_first_search.dart';
import 'package:algov/data_structure/graph/algorithms/searching/dijkstras_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/floyd_walshall.dart';
import 'package:algov/data_structure/graph/algorithms/searching/khans_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/kosaraju_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/kruskal_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/prims_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/tarjans_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/topological_sort.dart';
import 'package:algov/data_structure/hash/pages/hash_home.dart';
import 'package:algov/data_structure/hash/pages/hash_set.dart';
import 'package:algov/data_structure/linked_list/pages/linked_list_viz_screen.dart';
import 'package:algov/data_structure/queue/pages/queue_page.dart';
import 'package:algov/data_structure/stack/pages/stack_algo_vis_page.dart';
import 'package:algov/data_structure/tree/generator/tree_bfs_generator.dart';
import 'package:algov/data_structure/tree/generator/tree_dfs_inorder.dart';
import 'package:algov/data_structure/tree/generator/tree_dfs_postorder.dart';
import 'package:algov/data_structure/tree/generator/tree_dfs_preorder.dart';

import '../../core/enums/algorithm_type.dart';

class AlgorithmFactory {
  static search(AlgoCategory algoCat, dynamic type) {
    switch (algoCat) {
      case AlgoCategory.sorting:
        return sort(type);
      case AlgoCategory.searching:
        return arraysearch(type);
      case AlgoCategory.graph:
        return graphfunc(type);
      case AlgoCategory.tree:
        return treefunc(type);
      case AlgoCategory.binaryTree:
        return binaryTreefunc(type);
      case AlgoCategory.linkedList:
        return LinkedListVisualizer();
      case AlgoCategory.stack:
        return StackAlgoVisPage();
      case AlgoCategory.queue:
        return QueueAlgoVisPage();
      case AlgoCategory.hashmap:
        return HashHome();
      case AlgoCategory.hashset:
        return HashSetHome();
    }
  }

  static sort(ArrayAlgorithmType type) {
    switch (type) {
      case ArrayAlgorithmType.bubbleSort:
        return BubbleSort();
      case ArrayAlgorithmType.selectionSort:
        return SelectionSort();
      case ArrayAlgorithmType.insertionSort:
        return InsertionSort();
      case ArrayAlgorithmType.quickSort:
        return QuickSort();
      case ArrayAlgorithmType.mergeSort:
        return MergeSort();
      case ArrayAlgorithmType.heapSort:
        return HeapSort();
      case ArrayAlgorithmType.countingSort:
        return CountingSort();
      case ArrayAlgorithmType.redixSort:
        return RadixSort();
      case ArrayAlgorithmType.bucketSort:
        return BucketSort();
      case ArrayAlgorithmType.shellSort:
        return ShellSort();
      case ArrayAlgorithmType.cocktailSort:
        return CocktailSort();
      case ArrayAlgorithmType.cycleSort:
        return CycleSort();
      case ArrayAlgorithmType.introSort:
        return IntroSort();
      case ArrayAlgorithmType.timSort:
        return TimSort();
      case ArrayAlgorithmType.treeSort:
        return TreeSort();
    }
  }

  static arraysearch(ArraySortAlgoType type) {
    switch (type) {
      case ArraySortAlgoType.linearSearch:
        return LinearSearchAlgorithm();
      case ArraySortAlgoType.binarySearch:
        return BinarySearchAlgorithm();
      case ArraySortAlgoType.exponentialSearch:
        return ExponentialSearch();
      case ArraySortAlgoType.fibonacciSearch:
        return FibonacciSearch();
      case ArraySortAlgoType.interpolationSearch:
        return InterpolationSearch();
      case ArraySortAlgoType.jumpSearch:
        return JumpSearch();
      case ArraySortAlgoType.ternarySearch:
        return TernarySearch();
    }
  }

  static graphfunc(GraphAlgoType type) {
    switch (type) {
      case GraphAlgoType.breathFirstSearch:
        return BFSAlgorithm();
      case GraphAlgoType.depthFirstSearch:
        return DFSAlgorithm();
      case GraphAlgoType.dijkstra:
        return DijkstraAlgorithm();
      case GraphAlgoType.prims:
        return PrimAlgorithm();
      case GraphAlgoType.kruskal:
        return KruskalAlgorithm();
      case GraphAlgoType.bellManFord:
        return BellmanFordAlgorithm();
      case GraphAlgoType.aStar:
        return AStarAlgorithm();
      case GraphAlgoType.floydWarshall:
        return FloydWarshallAlgorithm();
      case GraphAlgoType.topologicalSort:
        return TopologicalSortAlgorithm();
      case GraphAlgoType.tarjan:
        return TarjanAlgorithm();
      case GraphAlgoType.kahns:
        return KahnsAlgorithm();
      case GraphAlgoType.kosaraju:
        return KosarajuAlgorithm();
    }
  }

  static treefunc(TreeAlgoType type) {
    switch (type) {
      case TreeAlgoType.bfs:
        return TreeBfsAlgorithm();
      case TreeAlgoType.dfsPre:
        return TreeDfsPreOrderAlgorithm();
      case TreeAlgoType.dfsPost:
        return TreeDfsPostAlgorithm();
    }
  }

  static binaryTreefunc(BinaryTreeAlgoType type) {
    switch (type) {
      case BinaryTreeAlgoType.dfsIn:
        return TreeDfsInAlgorithm();
    }
  }
}
