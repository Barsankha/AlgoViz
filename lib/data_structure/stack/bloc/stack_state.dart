part of 'stack_bloc.dart';

class DataStructureState {
  final StructureType type;
  final List<int> items;

  DataStructureState({this.type = StructureType.stack, this.items = const []});

  DataStructureState copyWith({StructureType? type, List<int>? items}) {
    return DataStructureState(
      type: type ?? this.type,
      items: items ?? this.items,
    );
  }
}
