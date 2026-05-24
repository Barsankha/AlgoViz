import 'package:algov/core/engine/controller/sorting_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/overlay_service.dart';
import 'package:algov/data_structure/array/algorithms/searching/linear_search.dart';
import 'package:algov/data_structure/hash/bloc/hash_bloc.dart';
import 'package:algov/data_structure/hash/models/items.dart';
import 'package:algov/ui/widgets/custom_widgets/custom_icon_button.dart';
import 'package:algov/ui/widgets/custom_widgets/cyan_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HashControls extends StatefulWidget {
  final bool isdark;
  final bool isCompact;
  final DsType type;
  const HashControls({
    super.key,
    required this.isdark,
    required this.isCompact,
    required this.type,
  });
  @override
  State<HashControls> createState() => _HashControlsState();
}

class _HashControlsState extends State<HashControls> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _performSearch(BuildContext ctx, HashState state, int key) {
    final index = key.abs() % HashState.bucketCount;
    final chain = state.buckets[index];
    HashItem? found;
    for (final item in chain) {
      if (item.hashKey == key) {
        found = item;
        break;
      }
    }
    final message =
        found != null
            ? (widget.type == DsType.hashMap
                ? 'Found → Key: $key, Value: ${found.mapValue!}'
                : 'Contains $key: Yes')
            : (widget.type == DsType.hashMap
                ? 'Key $key not found'
                : 'Key $key not found');
    CoolToast.show(context, message, isError: found == null);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.isdark ? Colors.white : Colors.black;
    final TextStyle textStyle = TextStyle(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.bold,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth;
        return BlocBuilder<HashBloc, HashState>(
          buildWhen:
              (previous, current) =>
                  previous.size != current.size ||
                  previous.loadFactor != current.loadFactor ||
                  previous.type != current.type,
          builder: (context, state) {
            final isMap = widget.type == DsType.hashMap;
            final opLabel = isMap ? 'Put' : 'Add';
            final searchLabel = isMap ? 'Get' : 'Contains';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 12),
                CyanTextField(
                  isCompact: widget.isCompact,
                  width: itemWidth * 0.95,
                  height: itemWidth * 0.35,
                  cont: SortingController(),
                  algorithm: LinearSearchAlgorithm(),
                  labelText: 'Key / Element',
                  isicon: false,
                  isdark: widget.isdark,
                  tcontroller: _keyController,
                ),
                const SizedBox(height: 20),
                if (isMap) ...[
                  const SizedBox(height: 2),
                  CyanTextField(
                    isCompact: widget.isCompact,
                    width: itemWidth * 0.95,
                    height: itemWidth * 0.35,
                    cont: SortingController(),
                    algorithm: LinearSearchAlgorithm(),
                    labelText: 'Value',
                    isicon: false,
                    isdark: widget.isdark,
                    tcontroller: _valueController,
                  ),
                ],
                const SizedBox(height: 6),
                Text('Buckets: ${HashState.bucketCount}', style: textStyle),
                Text('Entries: ${state.size}', style: textStyle),
                Text(
                  'Load Factor: ${state.loadFactor.toStringAsFixed(2)}',
                  style: textStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Hash: index = |input| % ${HashState.bucketCount}',
                  style: TextStyle(fontSize: 16, color: color),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomIconButton(
                      onpressed: () {
                        final keyStr = _keyController.text.trim();
                        if (keyStr.isEmpty) {
                          CoolToast.show(
                            context,
                            'Enter a key/element',
                            isError: true,
                          );
                          return;
                        }
                        final key = int.tryParse(keyStr);
                        if (key == null) {
                          CoolToast.show(
                            context,
                            "Invalid key/element",
                            isError: true,
                          );
                          return;
                        }
                        int? value;
                        if (isMap) {
                          final valStr = _valueController.text.trim();
                          if (valStr.isEmpty) {
                            CoolToast.show(
                              context,
                              "Empty value",
                              isError: true,
                            );
                            return;
                          }
                          value = int.tryParse(valStr);
                          if (value == null) {
                            CoolToast.show(
                              context,
                              'Invalid value',
                              isError: true,
                            );
                            return;
                          }
                        }
                        context.read<HashBloc>().add(
                          PutEvent(type: widget.type, value: value, key: key),
                        );
                        _keyController.clear();
                        if (isMap) _valueController.clear();
                      },
                      iconData: Icons.add_circle,
                      text: opLabel,
                      isdark: widget.isdark,
                      isCompact: widget.isCompact,
                    ),
                    CustomIconButton(
                      onpressed: () {
                        final keyStr = _keyController.text.trim();
                        if (keyStr.isEmpty) {
                          CoolToast.show(
                            context,
                            'Enter a key to remove',
                            isError: true,
                          );
                          return;
                        }
                        final key = int.tryParse(keyStr);
                        if (key == null) {
                          CoolToast.show(
                            context,
                            'Invalid key/element',
                            isError: true,
                          );
                          return;
                        }
                        context.read<HashBloc>().add(RemoveEvent(key));
                        _keyController.clear();
                      },
                      iconData: Icons.remove_circle,
                      text: 'Remove',
                      isCompact: widget.isCompact,
                      isdark: widget.isdark,
                    ),
                    CustomIconButton(
                      onpressed: () {
                        final keyStr = _keyController.text.trim();
                        if (keyStr.isEmpty) {
                          CoolToast.show(context, "Empty key", isError: true);
                          return;
                        }
                        final key = int.tryParse(keyStr);
                        if (key == null) {
                          CoolToast.show(
                            context,
                            'Invalid key/element',
                            isError: true,
                          );
                          return;
                        }
                        final bloc = context.read<HashBloc>();
                        final currentState = bloc.state;
                        _performSearch(context, currentState, key);
                      },
                      iconData: Icons.search,
                      text: searchLabel,
                      isCompact: widget.isCompact,
                      isdark: widget.isdark,
                    ),
                    CustomIconButton(
                      onpressed:
                          () => context.read<HashBloc>().add(ClearEvent()),
                      iconData: Icons.clear_all,
                      text: 'Clear',
                      isCompact: widget.isCompact,
                      isdark: widget.isdark,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// class HashControls extends StatefulWidget {
//   final bool isdark;
//   final bool isCompact;
//   final DsType type;
//   const HashControls({
//     super.key,
//     required this.isdark,
//     required this.isCompact,
//     required this.type,
//   });

//   @override
//   State<HashControls> createState() => _HashControlsState();
// }

// class _HashControlsState extends State<HashControls> {
//   final _keyController = TextEditingController();
//   final _valueController = TextEditingController();

//   @override
//   void dispose() {
//     _keyController.dispose();
//     _valueController.dispose();
//     super.dispose();
//   }

//   void _performSearch(BuildContext ctx, HashState state, int key) {
//     final index = key.abs() % HashState.bucketCount;
//     final chain = state.buckets[index];
//     HashItem? found;
//     for (final item in chain) {
//       if (item.hashKey == key) {
//         found = item;
//         break;
//       }
//     }

//     final message =
//         found != null
//             ? (widget.type == DsType.hashMap
//                 ? 'Found → Key: $key, Value: ${found.mapValue!}'
//                 : 'Contains $key: Yes')
//             : (widget.type == DsType.hashSet
//                 ? 'Key $key not found'
//                 : 'Contains $key: No');

//     CoolToast.show(context, message, isError: found != null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color color = widget.isdark ? Colors.white : Colors.black;
//     final TextStyle textStyle = TextStyle(
//       fontSize: 16,
//       color: color,
//       fontWeight: FontWeight.bold,
//     );
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final itemWidth = constraints.maxWidth;
//         return BlocBuilder<HashBloc, HashState>(
//           buildWhen: (previous, current) => previous.type != current.type,
//           builder: (context, state) {
//             final isMap = widget.type == DsType.hashMap;
//             final opLabel = isMap ? 'Put' : 'Add';
//             final searchLabel = isMap ? 'Get' : 'Contains';
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const SizedBox(height: 12),
//                 CyanTextField(
//                   isCompact: widget.isCompact,
//                   width: itemWidth * 0.95,
//                   height: itemWidth * 0.35,
//                   cont: SortingController(),
//                   algorithm: LinearSearchAlgorithm(),
//                   labelText: 'Key / Element',
//                   isicon: false,
//                   isdark: widget.isdark,
//                   tcontroller: _keyController,
//                 ),
//                 const SizedBox(height: 20),
//                 if (isMap) ...[
//                   const SizedBox(height: 2),
//                   CyanTextField(
//                     isCompact: widget.isCompact,
//                     width: itemWidth * 0.95,
//                     height: itemWidth * 0.35,
//                     cont: SortingController(),
//                     algorithm: LinearSearchAlgorithm(),
//                     labelText: 'Value',
//                     isicon: false,
//                     isdark: widget.isdark,
//                     tcontroller: _valueController,
//                   ),
//                 ],
//                 const SizedBox(height: 6),
//                 Text('Buckets: ${HashState.bucketCount}', style: textStyle),
//                 Text('Entries: ${state.size}', style: textStyle),
//                 Text(
//                   'Load Factor: ${state.loadFactor.toStringAsFixed(2)}',
//                   style: textStyle,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Hash: index = |input| % ${HashState.bucketCount}',
//                   style: TextStyle(fontSize: 16, color: color),
//                 ),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 16,
//                   runSpacing: 16,
//                   children: [
//                     CustomIconButton(
//                       onpressed: () {
//                         final keyStr = _keyController.text.trim();
//                         if (keyStr.isEmpty) {
//                           CoolToast.show(
//                             context,
//                             'Enter a key/element',
//                             isError: true,
//                           );
//                           return;
//                         }
//                         final key = int.tryParse(keyStr);
//                         if (key == null) {
//                           CoolToast.show(
//                             context,
//                             "Invalid key/element",
//                             isError: true,
//                           );
//                           return;
//                         }
//                         int? value;
//                         if (isMap) {
//                           final valStr = _valueController.text.trim();
//                           if (valStr.isEmpty) {
//                             CoolToast.show(
//                               context,
//                               "Empty value",
//                               isError: true,
//                             );
//                             return;
//                           }
//                           value = int.tryParse(valStr);
//                           if (value == null) {
//                             CoolToast.show(
//                               context,
//                               'Invalid value',
//                               isError: true,
//                             );

//                             return;
//                           }
//                         }

//                         context.read<HashBloc>().add(
//                           PutEvent(type: widget.type, value: value, key: key),
//                         );
//                         _keyController.clear();
//                         if (isMap) _valueController.clear();
//                       },
//                       iconData: Icons.add_circle,
//                       text: opLabel,
//                       isdark: widget.isdark,
//                       isCompact: widget.isCompact,
//                     ),
//                     CustomIconButton(
//                       onpressed: () {
//                         final keyStr = _keyController.text.trim();
//                         if (keyStr.isEmpty) return;
//                         final key = int.tryParse(keyStr);
//                         if (key == null) {
//                           CoolToast.show(
//                             context,
//                             'Invalid key/element',
//                             isError: true,
//                           );
//                           return; //
//                         }
//                         context.read<HashBloc>().add(RemoveEvent(key));
//                         _keyController.clear();
//                       },
//                       iconData: Icons.remove_circle,
//                       text: 'Remove',
//                       isCompact: widget.isCompact,
//                       isdark: widget.isdark,
//                     ),
//                     CustomIconButton(
//                       onpressed: () {
//                         final keyStr = _keyController.text.trim();
//                         if (keyStr.isEmpty) {
//                           CoolToast.show(context, "Empty key", isError: true);
//                           return;
//                         }
//                         final key = int.tryParse(keyStr);
//                         if (key == null) {
//                           CoolToast.show(
//                             context,
//                             'Invalid key/element',
//                             isError: true,
//                           );
//                           return;
//                         }
//                         _performSearch(context, state, key);
//                       },
//                       iconData: Icons.search,
//                       text: searchLabel,
//                       isCompact: widget.isCompact,
//                       isdark: widget.isdark,
//                     ),
//                     CustomIconButton(
//                       onpressed:
//                           () => context.read<HashBloc>().add(ClearEvent()),
//                       iconData: Icons.clear_all,
//                       text: 'Clear',
//                       isCompact: widget.isCompact,
//                       isdark: widget.isdark,
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
