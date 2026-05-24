import 'dart:core';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/algorithm_utils/algorithm_factory.dart';
import 'package:algov/data_structure/array/algorithms/pages/searching_algo_page.dart';
import 'package:algov/data_structure/array/algorithms/pages/sorting_algo_page.dart';
import 'package:algov/data_structure/graph/algorithms/pages/graph_algo_list_page.dart';
import 'package:algov/data_structure/graph/algorithms/searching/bellman_ford_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/depth_first_search.dart';
import 'package:algov/data_structure/graph/algorithms/searching/dijkstras_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/kruskal_algo.dart';
import 'package:algov/data_structure/graph/algorithms/searching/prims_algo.dart';
import 'package:algov/data_structure/greedy/greedy_page.dart';
import 'package:algov/data_structure/hash/pages/hash_home.dart';
import 'package:algov/data_structure/hash/pages/hash_set.dart';
import 'package:algov/data_structure/linked_list/pages/linked_list_viz_screen.dart';
import 'package:algov/data_structure/queue/pages/queue_page.dart';
import 'package:algov/data_structure/stack/pages/stack_algo_vis_page.dart';
import 'package:algov/data_structure/tree/generator/tree_bfs_generator.dart';
import 'package:algov/ui/screens/custom_screen/custom_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlgoItem {
  final String name;
  final String meta;
  final IconData icon;
  final Widget path;

  const AlgoItem({
    required this.name,
    required this.meta,
    required this.icon,
    required this.path,
  });
}

final String boyills = 'assets/pngs/1.png';
final String computerills = 'assets/pngs/2.png';
final bubble = AlgorithmFactory.sort(ArrayAlgorithmType.bubbleSort);
final bubbleRepo = AlgorithmRepository.sortingAlgorithms[0];
final quick = AlgorithmFactory.sort(ArrayAlgorithmType.quickSort);
final quickRepo = AlgorithmRepository.sortingAlgorithms[4]; //
final dijkstra = AlgorithmFactory.graphfunc(GraphAlgoType.dijkstra);
final dijkstraRepo = AlgorithmRepository.graphAlgos[2];
final binary = AlgorithmFactory.arraysearch(ArraySortAlgoType.binarySearch);
final binaryRepo = AlgorithmRepository.searchingAlgorithms[1];
final merge = AlgorithmFactory.sort(ArrayAlgorithmType.mergeSort);
final mergeRepo = AlgorithmRepository.sortingAlgorithms[3];
final dfs = AlgorithmFactory.graphfunc(GraphAlgoType.depthFirstSearch);
final dfsRepo = AlgorithmRepository.graphAlgos[3];
final bfs = AlgorithmFactory.treefunc(TreeAlgoType.bfs);
final bfsRepo = AlgorithmRepository.treeAlgos[0];
final linear = AlgorithmFactory.arraysearch(ArraySortAlgoType.linearSearch);
final linearRepo = AlgorithmRepository.searchingAlgorithms[0];
final bellman = AlgorithmRepository.graphAlgos[3];
final kruskalRepo = AlgorithmRepository.graphAlgos[6];
final primRepo = AlgorithmRepository.graphAlgos[7];

List<Map<String, dynamic>> drawerItem = [
  {
    'index': 1,
    'icon': Icons.data_array,
    'title': 'Array',
    'ontap': CyanSystemTabs(
      pageOne: SortingAlgorithmsMainPage(isSearch: true),
      pageTwo: SearchingAlgorithmsMainPage(issearch: true),
      titleText: 'Array',
      tab1: 'Sorting',
      tab2: 'Searching',
    ),
  },
  {
    'index': 2,
    'icon': Icons.linear_scale,
    'title': 'Linked List',
    'ontap': const LinkedListVisualizer(),
  },
  {
    'index': 3,
    'icon': Icons.layers,
    'title': 'Stack',
    'ontap': StackAlgoVisPage(),
  },
  {
    'index': 4,
    'icon': Icons.reorder,
    'title': 'Queue',
    'ontap': QueueAlgoVisPage(),
  },
  {
    'index': 5,
    'icon': CupertinoIcons.tree,
    'title': 'Tree',
    'ontap': GraphAlgoListPage(isSearch: false, isGraph: false),
  },
  {
    'index': 6,
    'icon': Icons.view_list,
    'title': 'HashMap',
    'ontap': HashHome(),
  },
  {
    'index': 7,
    'icon': Icons.grid_view,
    'title': 'Hash Set',
    'ontap': HashSetHome(),
  },
  {
    'index': 8,
    'icon': Icons.hub,
    'title': 'Graph',
    'ontap': GraphAlgoListPage(isSearch: false, isGraph: true),
  },
];

final List<AlgoItem> newitems = [
  AlgoItem(
    name: 'Bubble Sort',
    meta: 'O(n²) • Easy',
    icon: Icons.bubble_chart,
    path: RouteAnim.buildScreen(bubble, bubbleRepo),
  ),
  AlgoItem(
    name: 'Quick Sort',
    meta: 'O(n log n) • Medium',
    icon: Icons.bolt,
    path: RouteAnim.buildScreen(quick, quickRepo),
  ),
  AlgoItem(
    name: 'Binary Search',
    meta: 'O(log n) • Easy',
    icon: Icons.account_tree,
    path: RouteAnim.buildScreen(binary, binaryRepo),
  ),
  AlgoItem(
    name: 'Merge Sort',
    meta: 'O(n log n) • Medium',
    icon: Icons.merge,
    path: RouteAnim.buildScreen(merge, mergeRepo),
  ),

  AlgoItem(
    name: 'DFS',
    meta: 'Graph • Medium',
    icon: Icons.device_hub,
    path: RouteAnim.buildGraph(DFSAlgorithm(), dfsRepo),
  ),

  AlgoItem(
    name: 'BFS',
    meta: 'Graph • Medium',
    icon: Icons.hub,
    path: RouteAnim.buildTree(TreeBfsAlgorithm(), bfsRepo),
  ),
  AlgoItem(
    name: 'Dijkstra',
    meta: 'Pathfinding • Hard',
    icon: Icons.timeline,
    path: RouteAnim.buildGraph(DijkstraAlgorithm(), dijkstraRepo),
  ),
  AlgoItem(
    name: 'Bellman-Ford',
    meta: 'Shortest Path • Hard',
    icon: Icons.trending_up,
    path: RouteAnim.buildGraph(BellmanFordAlgorithm(), bellman),
  ),
  AlgoItem(
    name: 'Kruskal',
    meta: 'Minimum Spanning Tree • Medium',
    icon: Icons.account_tree_outlined,
    path: RouteAnim.buildGraph(KruskalAlgorithm(), kruskalRepo),
  ),
  AlgoItem(
    name: 'Prim',
    meta: 'Minimum Spanning Tree • Medium',
    icon: Icons.forest,
    path: RouteAnim.buildGraph(PrimAlgorithm(), primRepo),
  ),
];

final List<Map<String, dynamic>> categories = [
  {
    'title': 'Sorting',
    'icon': Icons.bar_chart,
    'color': Colors.cyan,
    'path': SortingAlgorithmsMainPage(isSearch: false),
  },
  {
    'title': 'Searching',
    'icon': Icons.search,
    'color': Colors.purpleAccent,
    'path': SearchingAlgorithmsMainPage(issearch: false),
  },
  {
    'title': 'Graphs',
    'icon': Icons.hub,
    'color': Colors.pinkAccent,
    'path': GraphAlgoListPage(isSearch: false, isGraph: true),
  },
  {
    'title': 'Tree',
    'icon': CupertinoIcons.tree,
    'color': Colors.greenAccent,
    'path': GraphAlgoListPage(isSearch: false, isGraph: false),
  },
  // {
  //   'title': 'Dynamic',
  //   'icon': Icons.layers,
  //   'color': Colors.redAccent,
  //   'path': KnapsackScreen(),
  // },
  {
    'title': 'Greedy',
    'icon': Icons.shopping_basket,
    'color': Colors.blueAccent,
    'path': GreedyPage(isgreedy: true),
  },
  {
    'title': 'Recursive',
    'icon': Icons.repeat,
    'color': Colors.amberAccent,
    'path': GreedyPage(isgreedy: false),
  },
  // {
  //   'title': 'Machine Learing',
  //   'icon': Icons.insights,
  //   'color': Colors.cyanAccent,
  //   'path': SearchingAlgorithmsMainPage(issearch: false),
  // },
];
