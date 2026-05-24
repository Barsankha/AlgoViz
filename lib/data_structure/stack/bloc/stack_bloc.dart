import 'package:algov/core/enums/algorithm_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stack_event.dart';
part 'stack_state.dart';

class DataStructureBloc extends Bloc<DataStructureEvent, DataStructureState> {
  DataStructureBloc() : super(DataStructureState()) {
    on<SwitchTypeEvent>((event, emit) {
      emit(state.copyWith(type: event.type));
    });

    on<AddItemEvent>((event, emit) {
      final newItems = List<int>.from(state.items)..add(event.value);
      emit(state.copyWith(items: newItems));
    });

    on<RemoveItemEvent>((event, emit) {
      if (state.items.isEmpty) return;
      final newItems = List<int>.from(state.items);
      if (state.type == StructureType.stack) {
        newItems.removeLast();
      } else {
        newItems.removeAt(0);
      }
      emit(state.copyWith(items: newItems));
    });

    on<ClearEvent>((event, emit) {
      emit(state.copyWith(items: []));
    });
  }
}
