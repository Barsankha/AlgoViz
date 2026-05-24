import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/overlay_service.dart';
import 'package:algov/data_structure/array/algorithms/searching/linear_search.dart';
import 'package:algov/data_structure/stack/bloc/stack_bloc.dart';
import 'package:algov/ui/widgets/custom_widgets/custom_icon_button.dart';
import 'package:algov/ui/widgets/custom_widgets/cyan_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlsPanel extends StatelessWidget {
  final bool isCompact;
  final bool isdark;
  final StructureType type;
  final TextEditingController _controller = TextEditingController();

  ControlsPanel({
    super.key,
    required this.isCompact,
    required this.isdark,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CyanTextField(
              isCompact: isCompact,
              width: itemWidth * 0.95,
              height: itemWidth * 0.35,
              cont: SearchAlgoController(),
              algorithm: LinearSearchAlgorithm(),
              labelText: 'Value to add',
              isicon: false,
              isdark: isdark,
              tcontroller: _controller,
            ),
            const SizedBox(height: 8),
            // Operation buttons and info
            BlocBuilder<DataStructureBloc, DataStructureState>(
              builder: (context, state) {
                final isEmpty = state.items.isEmpty;
                final addLabel =
                    type == StructureType.stack ? 'Push' : 'Enqueue';
                final removeLabel =
                    type == StructureType.stack ? 'Pop' : 'Dequeue';
                final peekLabel = type == StructureType.stack ? 'Top' : 'Front';
                final peekValue =
                    isEmpty
                        ? 'N/A'
                        : (type == StructureType.stack
                            ? state.items.last
                            : state.items.first);
                final rearLabel =
                    type == StructureType.stack ? 'Bottom' : 'Rear';
                final rearvalue =
                    isEmpty
                        ? 'N/A'
                        : (type == StructureType.stack
                            ? state.items.first
                            : state.items.last);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size: ${state.items.length}',
                      style: TextStyle(
                        color: isdark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$peekLabel: $peekValue',
                      style: TextStyle(
                        color: isdark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$rearLabel: $rearvalue',
                      style: TextStyle(
                        color: isdark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        CustomIconButton(
                          isdark: isdark,
                          onpressed: () {
                            final value = int.tryParse(_controller.text);
                            if (value != null) {
                              context.read<DataStructureBloc>().add(
                                AddItemEvent(value),
                              );
                              _controller.clear();
                            } else if (_controller.text.isNotEmpty) {
                              CoolToast.show(
                                context,
                                'Please enter a valid integer',
                              );
                            }
                          },
                          isCompact: isCompact,
                          iconData: Icons.add,
                          text: addLabel,
                        ),
                        !isEmpty
                            ? CustomIconButton(
                              isdark: isdark,
                              onpressed: () {
                                context.read<DataStructureBloc>().add(
                                  RemoveItemEvent(),
                                );
                              },
                              isCompact: isCompact,
                              iconData: Icons.remove,
                              text: removeLabel,
                            )
                            : SizedBox.shrink(),
                        CustomIconButton(
                          isdark: isdark,
                          onpressed: () {
                            context.read<DataStructureBloc>().add(ClearEvent());
                          },
                          isCompact: isCompact,
                          iconData: Icons.clear,
                          text: 'Clear',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
