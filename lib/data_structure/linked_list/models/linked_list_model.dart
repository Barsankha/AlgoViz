import 'dart:ui';

import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';

class VisualLinkedList {
  final Map<String, NodeModel> nodes = {};
  final Map<String, EdgeModel> edges = {};
  List<String> dataNodeIds = [];
  int counter = 0;

  VisualLinkedList() {
    nodes['head'] = NodeModel(id: 'head', label: 'H', position: Offset.zero);
    nodes['null'] = NodeModel(id: 'null', label: 'N', position: Offset.zero);
    _rebuildEdges();
  }

  String _newId() => 'n${counter++}';

  NodeModel _createDataNode(int data) {
    final id = _newId();
    return NodeModel(
      id: id,
      label: data.toString(),
      position: Offset.zero,
      meta: {'data': data},
    );
  }

  void insertAtBeginning(int data) {
    final newNode = _createDataNode(data);
    nodes[newNode.id] = newNode;
    dataNodeIds.insert(0, newNode.id);
    _rebuildEdges();
  }

  void insertAtEnd(int data) {
    final newNode = _createDataNode(data);
    nodes[newNode.id] = newNode;
    dataNodeIds.add(newNode.id);
    _rebuildEdges();
  }

  void insertAtPosition(int data, int position) {
    if (position < 0 || position > dataNodeIds.length) return;
    final newNode = _createDataNode(data);
    nodes[newNode.id] = newNode;
    dataNodeIds.insert(position, newNode.id);
    _rebuildEdges();
  }

  void deleteAtBeginning() {
    if (dataNodeIds.isEmpty) return;
    final id = dataNodeIds.removeAt(0);
    nodes.remove(id);
    _rebuildEdges();
  }

  void deleteAtEnd() {
    if (dataNodeIds.isEmpty) return;
    final id = dataNodeIds.removeLast();
    nodes.remove(id);
    _rebuildEdges();
  }

  void deleteByValue(int data) {
    final index = dataNodeIds.indexWhere(
      (id) => nodes[id]!.meta['data'] == data,
    );
    if (index == -1) return;
    final id = dataNodeIds.removeAt(index);
    nodes.remove(id);
    _rebuildEdges();
  }

  void deleteAtPosition(int position) {
    if (position < 0 || position >= dataNodeIds.length) return;
    final id = dataNodeIds.removeAt(position);
    nodes.remove(id);
    _rebuildEdges();
  }

  String? findFirstId(int data) {
    for (final id in dataNodeIds) {
      if (nodes[id]!.meta['data'] == data) return id;
    }
    return null;
  }

  void reverse() {
    if (dataNodeIds.length <= 1) return;
    dataNodeIds = dataNodeIds.reversed.toList();
    _rebuildEdges();
  }

  void _rebuildEdges() {
    edges.clear();
    String prev = 'head';
    for (final id in dataNodeIds) {
      edges['$prev-to-$id'] = EdgeModel(
        id: '$prev-to-$id',
        from: prev,
        to: id,
        directed: true,
      );
      prev = id;
    }
    edges['$prev-to-null'] = EdgeModel(
      id: '$prev-to-null',
      from: prev,
      to: 'null',
      directed: true,
    );
  }

  int get length => dataNodeIds.length;
}
