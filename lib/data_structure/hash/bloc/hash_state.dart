part of 'hash_bloc.dart';

class HashState {
  final DsType type;
  final List<List<HashItem>> buckets;

  static const int bucketCount = 11;

  HashState({required this.type, required this.buckets});

  factory HashState.initial(DsType type) => HashState(
    type: type,
    buckets: List.generate(bucketCount, (_) => <HashItem>[]),
  );

  HashState copyWith({DsType? type, List<List<HashItem>>? buckets}) {
    return HashState(type: type ?? this.type, buckets: buckets ?? this.buckets);
  }

  int get size => buckets.fold(0, (sum, chain) => sum + chain.length);

  double get loadFactor => size / bucketCount;
}
