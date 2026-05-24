import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:flutter/material.dart';

abstract class VisualController extends ChangeNotifier {
  List<dynamic> get items;

  bool get isStarted;
  bool get isSorting;
  bool get isPlaying;

  double get speed;
  set speed(double v);

  Duration get animDuration;
  String get type;

  Future<void> start(Algo algorithm);
  void play();
  void pause();
  void reset();
}
//