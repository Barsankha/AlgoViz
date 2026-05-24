import 'package:algov/core/enums/algorithm_type.dart';
import 'package:flutter/material.dart';

class AlgorithmInfo<T> {
  final String id;
  final T type;
  final String title;
  final String description;
  final List<String> complexity;
  final String notes;
  final Color complexityColor;
  final IconData icon;
  final List<String> pros;
  final List<String> cons;
  final List<String> usecases;
  final List<String> psuedocode;
  final AlgoCategory algoCategory;

  const AlgorithmInfo({
    required this.id,
    required this.complexity,
    required this.cons,
    required this.pros,
    required this.complexityColor,
    required this.usecases,
    required this.icon,
    required this.type,
    required this.title,
    required this.description,
    required this.notes,
    required this.algoCategory,
    required this.psuedocode,
  });
  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(), // or custom serialize
      'title': title,
      'description': description,
      'complexity': complexity,
      'notes': notes,
      'complexityColor': complexityColor,
      'icon': {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily,
        'fontPackage': icon.fontPackage,
      },
      'pros': pros,
      'cons': cons,
      'usecases': usecases,
      'algoCategory': algoCategory.name,
    };
  }
}
//