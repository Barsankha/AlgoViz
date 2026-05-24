import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:flutter/material.dart';

class TreeSort implements SortingAlgorithm {
  @override
  String get id => "tree";

  @override
  String get name => "Tree Sort";

  @override
  String get description =>
      "Builds a Binary Search Tree and retrieves elements using inorder traversal.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    _TreeNode? root;

    // 1️⃣ Insert elements into BST
    for (int i = 0; i < items.length; i++) {
      onExplain("Inserting ${items[i].value} into Binary Search Tree");
      root = await _insert(root, items[i], refresh, onExplain);
      await refresh(); // visualize insert
    }

    // 2️⃣ Inorder traversal to sort array
    int index = 0;
    await _inorder(root, items, () {
      onExplain("Placing ${items[index].value} back into array");
      index++;
    }, refresh);
  }

  // ---------------- BST INSERT ----------------
  Future<_TreeNode> _insert(
    _TreeNode? node,
    SortItem item,
    Future<void> Function() refresh,
    void Function(String) onExplain,
  ) async {
    if (node == null) {
      onExplain("Inserted ${item.value} as new node");
      await refresh();
      return _TreeNode(item.value);
    }

    if (item.value < node.value) {
      onExplain("${item.value} < ${node.value}, going left");
      await refresh();
      node.left = await _insert(node.left, item, refresh, onExplain);
    } else {
      onExplain("${item.value} ≥ ${node.value}, going right");
      await refresh();
      node.right = await _insert(node.right, item, refresh, onExplain);
    }

    return node;
  }

  // ---------------- INORDER TRAVERSAL ----------------
  Future<void> _inorder(
    _TreeNode? node,
    List<SortItem> items,
    VoidCallback onVisit,
    Future<void> Function() refresh,
  ) async {
    if (node == null) return;

    await _inorder(node.left, items, onVisit, refresh);

    // Place value back into array
    items[onVisitIndex(items)] = SortItem(node.value);
    onVisit();
    await refresh();

    await _inorder(node.right, items, onVisit, refresh);
  }

  // Helper to get next free index
  int onVisitIndex(List<SortItem> items) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].value == -1) return i;
    }
    return 0;
  }
}

class _TreeNode {
  final int value;
  _TreeNode? left;
  _TreeNode? right;

  _TreeNode(this.value);
}
