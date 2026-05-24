part of 'hash_bloc.dart';

abstract class HashEvent {}

class SwitchTypeEvent extends HashEvent {
  final DsType type;
  SwitchTypeEvent(this.type);
}

class PutEvent extends HashEvent {
  final int key;
  final DsType type;
  final int? value;
  PutEvent({required this.type, required this.key, this.value});
}

class RemoveEvent extends HashEvent {
  final int key;
  RemoveEvent(this.key);
}

class ClearEvent extends HashEvent {}
