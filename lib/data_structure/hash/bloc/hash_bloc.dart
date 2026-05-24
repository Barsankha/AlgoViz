import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/hash/models/items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hash_event.dart';
part 'hash_state.dart';

//
class HashBloc extends Bloc<HashEvent, HashState> {
  HashBloc() : super(HashState.initial(DsType.hashMap)) {
    on<SwitchTypeEvent>((event, emit) {
      emit(HashState.initial(event.type));
    });

    on<PutEvent>((event, emit) {
      final index = event.key.abs() % HashState.bucketCount;
      final newBuckets =
          state.buckets.map((l) => List<HashItem>.from(l)).toList();
      final chain = newBuckets[index];

      final existingIdx = chain.indexWhere((item) => item.hashKey == event.key);

      if (event.type == DsType.hashMap) {
        if (existingIdx != -1) {
          chain[existingIdx] = HashItem(event.key, event.value);
        } else {
          chain.add(HashItem(event.key, event.value!));
        }
      } else {
        if (existingIdx == -1) {
          chain.add(HashItem(event.key, null));
        }
      }

      emit(state.copyWith(buckets: newBuckets));
    });

    on<RemoveEvent>((event, emit) {
      final index = event.key.abs() % HashState.bucketCount;
      final newBuckets =
          state.buckets.map((l) => List<HashItem>.from(l)).toList();
      final chain = newBuckets[index];
      chain.removeWhere((item) => item.hashKey == event.key);
      emit(state.copyWith(buckets: newBuckets));
    });

    on<ClearEvent>((event, emit) {
      emit(HashState.initial(state.type));
    });
  }
}
