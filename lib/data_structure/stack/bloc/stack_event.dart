part of 'stack_bloc.dart';

abstract class DataStructureEvent {}

class SwitchTypeEvent extends DataStructureEvent {
  final StructureType type;
  SwitchTypeEvent(this.type);
}

class AddItemEvent extends DataStructureEvent {
  final int value;
  AddItemEvent(this.value);
}

class RemoveItemEvent extends DataStructureEvent {}

class ClearEvent extends DataStructureEvent {}
