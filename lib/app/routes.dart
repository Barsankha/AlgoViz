import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_info.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/engine/graph_factory.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/data_structure/tree/pages/tree_vis_page.dart';
import 'package:algov/ui/screens/graph_vis_screen.dart';
import 'package:algov/ui/screens/visulaizer_screen.dart';
import 'package:flutter/material.dart';

enum AnimType { fade, matrix, circular, slide }

class RouteAnim {
  static Future<void> push(
    BuildContext context,
    Widget des,
    AnimType anim,
  ) async {
    await Navigator.push(context, createCustomRoute(des, anim));
  }

  /////
  static Widget buildGraph(GraphAlgorithm al, AlgorithmInfo algo) {
    final graphAlgos = GraphFactory.whichGraph(algo.type)[0];
    final String startNode = GraphFactory.whichGraph(algo.type)[1];
    return GraphVisScreen(
      algorithm: al,
      graph: graphAlgos,
      description: algo.description,
      complexity: algo.complexity,
      pros: algo.pros,
      cons: algo.cons,
      useCases: algo.usecases,
      notes: algo.notes,
      startNode: startNode,
      title: algo.title,
      id: algo.id,
      psuedocode: algo.psuedocode,
    );
  }

  static Widget buildTree(TreeAlgorithm al, AlgorithmInfo algo) {
    final graphAlgos = GraphFactory.whichGraph(algo.type)[0];
    final String startNode = GraphFactory.whichGraph(algo.type)[1];
    return TreeVisPage(
      algorithm: al,
      graph: graphAlgos,
      description: algo.description,
      complexity: algo.complexity,
      pros: algo.pros,
      cons: algo.cons,
      useCases: algo.usecases,
      notes: algo.notes,
      startNode: startNode,
      title: algo.title,
      id: algo.id,
      psuwdocode: algo.psuedocode,
    );
  }

  static Widget buildScreen(Algo al, AlgorithmInfo algo) {
    return VisualizerScreen(
      algorithm: al,
      description: algo.description,
      pros: algo.pros,
      cons: algo.cons,
      complexity: algo.complexity,
      useCases: algo.usecases,
      notes: algo.notes,
      isSearch: algo.algoCategory == AlgoCategory.searching,
      title: algo.title,
      id: algo.id,
      psuedocode: algo.psuedocode,
    );
  }

  static Route createCustomRoute(Widget des, AnimType anim) {
    return PageRouteBuilder(
      opaque: true,
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => des,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (anim) {
          case AnimType.fade:
            return FadeTransition(opacity: animation, child: child);
          default:
            final curve = Curves.easeInOut;
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(
              tween.chain(CurveTween(curve: curve)),
            );
            return SlideTransition(position: offsetAnimation, child: child);
        }
      },
    );
  }

  static Widget customFade(
    Animation<double> animation,
    Widget child,
    Animation<Offset> tween,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: tween,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
          child: child,
        ),
      ),
    );
  }
}
