class ExtraDes {
  static const String linkedList =
      "Sequentially visits each node in the linked list.";
  static const String stackdes = "LIFO structure with push and pop operations.";
  static const String queuedes = "FIFO structure with enqueue and dequeue.";
  static const String hashMapDes =
      "Key-value storage with constant time access.";
  static const String hashSetDes = "Stores unique values using hashing.";
}

class TreeDes {
  static const String bfs =
      "Traverses the tree level by level starting from the root.";
  static const String dfsPre =
      "Visits the root first, then recursively traverses subtrees.";
  static const String dfsPost =
      "Visits subtrees first and processes the root node last.";
  static const String dfsin =
      "Visits left subtree, root node, then right subtree.";
}

class GraphDes {
  static const String breathFirstSearch =
      "Breadth First Search (BFS) is a graph traversal algorithm that starts from a source node and explores the graph level by level. First, it visits all nodes directly adjacent to the source. Then, it moves on to visit the adjacent nodes of those nodes, and this process continues until all reachable nodes are visited.";
  static const String depthFirstSearch =
      "Depth First Search (DFS) is a graph traversal method that starts from a source vertex and explores each path completely before backtracking and exploring other paths. To avoid revisiting nodes in graphs with cycles, a visited array is used to track visited vertices.";
  static const String dijkstra =
      "Dijkstra’s algorithm always picks the node with the minimum distance first. By doing so, it ensures that the node has already checked the shortest distance to all its neighbors. If this node appears again in the priority queue later, we don’t need to process it again, because its neighbors have already checked the minimum possible distances";
  static const String prims =
      "Prim’s algorithm is a Greedy algorithm like Kruskal's algorithm. This algorithm always starts with a single node and moves through several adjacent nodes, in order to explore all of the connected edges along the way.";
  static const String kruskal =
      "A minimum spanning tree (MST) or minimum weight spanning tree for a weighted, connected, and undirected graph is a spanning tree (no cycles and connects all vertices) that has minimum weight. The weight of a spanning tree is the sum of all edges in the tree.";
  static const String bellManFord =
      "Given a weighted graph with V vertices and E edges, along with a source vertex src, the task is to compute the shortest distances from the source to all other vertices. If a vertex is unreachable from the source, its distance should be marked as 108. In the presence of a negative weight cycle, return -1 to signify that shortest path calculations are not feasible.";
  static const String aStar =
      "Heuristic-based shortest path algorithm combining Dijkstra and greedy search.";
  static const String floydWarshall =
      "Given a matrix dist[][] of size n x n, where dist[i][j] represents the weight of the edge from node i to node j. If there is no direct edge, dist[i][j] is set to a large value (e.g., 10⁸) to represent infinity. The diagonal entries dist[i][i] are 0, since the distance from a node to itself is zero. The graph may contain negative edge weights, but it does not contain any negative weight cycles.";
  static const String topologicalSort =
      "Topological sorting for Directed Acyclic Graph (DAG) is a linear ordering of vertices such that for every directed edge u→v, vertex u comes before v in the ordering. There may be several topological orderings for a graph.";
  static const String tarjan =
      "Finds strongly connected components using low-link values in one DFS.";
  static const String kahns =
      "Kahn’s Algorithm is a classic algorithm used for topological sorting of a directed acyclic graph (DAG). Topological sorting is a linear ordering of vertices such that for every directed edge u -> v, vertex u comes before v in the ordering. This algorithm is widely used in various applications such as scheduling tasks, course prerequisite ordering, and resolving symbol dependencies in linkers.";
  static const String kosaraju =
      "Builds a minimum spanning tree by selecting edges in increasing weight order.";
}

class ArraySearch {
  static const String linear =
      "In Linear Search, we iterate over all the elements of the array and check if it the current element is equal to the target element. If we find any element to be equal to the target element, then return the index of the current element. Otherwise, if no element is equal to the target element, then return -1 as the element is not found. Linear search is also known as sequential search.";
  static const String binary =
      "Binary Search is a searching technique that works on the Divide and Conquer approach. It is used to search for any element in a sorted array. Compared with linear, binary search is much faster with a Time Complexity of O(logN), whereas linear search works in O(N) time complexity";
  static const String jump =
      "Jump Search is a searching algorithm for sorted arrays. The basic idea is to check fewer elements (than linear search) by jumping ahead by fixed steps or skipping some elements in place of searching all elements.";
  static const String interpolation =
      "The Interpolation Search is an improvement over Binary Search for instances, where the values in a sorted array are uniformly distributed. Interpolation constructs new data points within the range of a discrete set of known data points. Binary Search always goes to the middle element to check. On the other hand, interpolation search may go to different locations according to the value of the key being searched. For example, if the value of the key is closer to the last element, interpolation search is likely to start search toward the end side.";
  static const String exponential =
      "Finds range exponentially, then applies Binary Search within the range.";
  static const String finonacci =
      "Uses Fibonacci numbers to divide the sorted array and narrow down the search range.";
  static const String ternary =
      "Ternary search is a divide-and-conquer search algorithm used to find the position of a target value within a monotonically increasing or decreasing function or in a unimodal array";
}

class ArraySorting {
  static const String bubblesortDes =
      "Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order. This algorithm is not efficient for large data sets as its average and worst-case time complexity are quite high.";
  static const String selectionDes =
      "Selection Sort is a comparison-based sorting algorithm. It sorts by repeatedly selecting the smallest (or largest) element from the unsorted portion and swapping it with the first unsorted element.";
  static const String insertionDes =
      "Insertion sort is a simple sorting algorithm that works by iteratively inserting each element of an unsorted list into its correct position in a sorted portion of the list. It is like sorting playing cards in your hands. You split the cards into two groups: the sorted cards and the unsorted cards. Then, you pick a card from the unsorted group and put it in the right place in the sorted group.";

  static const String mergesortdes =
      "Merge sort is a popular sorting algorithm known for its efficiency and stability. It follows the Divide and Conquer approach. It works by recursively dividing the input array into two halves, recursively sorting the two halves and finally merging them back together to obtain the sorted array.";

  static const String quickDes =
      "QuickSort is a sorting algorithm based on the Divide and Conquer that picks an element as a pivot and partitions the given array around the picked pivot by placing the pivot in its correct position in the sorted array.";

  static const String heapdes =
      "Heap Sort is a comparison-based sorting algorithm based on the Binary Heap data structure.";

  static const String cycledes =
      "Cycle sort is an in-place, unstable sorting algorithm that is particularly useful when sorting arrays containing elements with a small range of values. It was developed by W. D. Jones and published in 1963.\n"
      "The basic idea behind cycle sort is to divide the input array into cycles, where each cycle consists of elements that belong to the same position in the sorted output array. The algorithm then performs a series of swaps to place each element in its correct position within its cycle, until all cycles are complete and the array is sorted.";

  static const String countingDes =
      "Counting Sort is a non-comparison-based sorting algorithm. It is particularly efficient when the range of input values is small compared to the number of elements to be sorted.";

  static const String redixdes =
      "Radix Sort is a linear sorting algorithm (for fixed length digit counts) that sorts elements by processing them digit by digit. It is an efficient sorting algorithm for integers or strings with fixed-size keys.";

  static const String bucketdes =
      "Bucket sort is a sorting technique that involves dividing elements into various groups, or buckets. These buckets are formed by uniformly distributing the elements. Once the elements are divided into buckets, they can be sorted using any other sorting algorithm. Finally, the sorted elements are gathered together in an ordered fashion.";

  static const String introdes =
      "Intro Sort is the best sorting algorithm around. It is a hybrid sorting algorithm, which means that it uses more than one sorting algorithms as a routine. it is being a hybrid sorting algorithm uses three sorting algorithm to minimise the running time, Quicksort, Heapsort and Insertion Sort ";

  static const String timdes =
      "TimSort is a hybrid sorting algorithm that uses the ideas of Merge Sort and Insertion Sort.";

  static const String shelldes =
      "Shell Sort is an optimization of insertion sort that allows the exchange of far-apart elements by using a diminishing gap (increment) sequence.\n"
      "It divides the array into sublists based on the gap and performs insertion sort on each sublist, starting with large gaps to move elements quickly into approximate positions.\n"
      "The gap is progressively reduced (often halved) until it reaches 1, at which point it becomes a standard insertion sort on a nearly sorted array.";

  static const String cocktaildes =
      "Cocktail Sort is a bidirectional variation of bubble sort that alternates passes through the array in both directions.\n"
      "In one pass, it bubbles the largest unsorted element to the end (like bubble sort), and in the reverse pass, it bubbles the smallest unsorted element to the beginning.\n"
      "This reduces the number of passes needed compared to standard bubble sort, especially for arrays where elements are misplaced at opposite ends.";
}
