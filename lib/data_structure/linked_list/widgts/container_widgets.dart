import 'package:algov/data_structure/array/algorithms/searching/linear_search.dart';
import 'package:algov/data_structure/linked_list/models/linked_list_model.dart';
import 'package:algov/ui/widgets/custom_widgets/custom_icon_button.dart';
import 'package:algov/ui/widgets/custom_widgets/cyan_text_field.dart';
import 'package:flutter/cupertino.dart';

class ContainerWidget extends StatelessWidget {
  final TextEditingController valueController;
  final TextEditingController positionController;
  final VisualLinkedList vll;
  final void Function() refresh;
  final void Function(BuildContext, String, bool) showError;
  final void Function() traverse;
  final void Function(String) search;
  final bool isdark;
  final bool isCompact;
  const ContainerWidget({
    super.key,
    required this.valueController,
    required this.positionController,
    required this.vll,
    required this.refresh,
    required this.showError,
    required this.traverse,
    required this.search,
    required this.isdark,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CyanTextField(
              isCompact: isCompact,
              width: itemWidth,
              height: isCompact ? 56 : 64,
              cont: valueController,
              tcontroller: valueController,
              algorithm: LinearSearchAlgorithm(),
              labelText: 'Value',
              isicon: false,
              isdark: isdark,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    final val = int.tryParse(valueController.text);
                    if (val == null) {
                      return showError(context, 'Invalid value', false);
                    }
                    vll.insertAtBeginning(val);
                    valueController.clear();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.arrow_turn_up_left,
                  text: 'Insert Begin',
                ),
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    final val = int.tryParse(valueController.text);
                    if (val == null) {
                      return showError(context, 'Invalid value', false);
                    }
                    vll.insertAtEnd(val);
                    valueController.clear();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.arrow_turn_down_right,
                  text: 'Insert End',
                ),
              ],
            ),
            const SizedBox(height: 10),
            CyanTextField(
              isCompact: isCompact,
              width: itemWidth,
              height: isCompact ? 56 : 64,
              cont: positionController,
              tcontroller: positionController,
              algorithm: LinearSearchAlgorithm(),
              labelText: 'Position (0-based)',
              isicon: false,
              isdark: isdark,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    final val = int.tryParse(valueController.text);
                    final pos = int.tryParse(positionController.text);
                    if (val == null ||
                        pos == null ||
                        pos < 0 ||
                        pos > vll.length) {
                      return showError(context, 'Invalid input', false);
                    }
                    vll.insertAtPosition(val, pos);
                    valueController.clear();
                    positionController.clear();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.arrow_down_to_line,
                  text: 'Insert at Pos',
                ),
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    final pos = int.tryParse(positionController.text);
                    if (pos == null || pos < 0 || pos >= vll.length) {
                      return showError(context, 'Invalid position', false);
                    }
                    vll.deleteAtPosition(pos);
                    positionController.clear();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.minus_circle,
                  text: 'Delete at Pos',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    vll.deleteAtBeginning();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.delete_left,
                  text: 'Delete Begin',
                ),
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    vll.deleteAtEnd();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.delete_right,
                  text: 'Delete End',
                ),
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    final val = int.tryParse(valueController.text);
                    if (val == null) {
                      return showError(context, 'Invalid value', false);
                    }
                    vll.deleteByValue(val);
                    valueController.clear();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.clear_circled,
                  text: 'Delete Value',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  isdark: isdark,
                  onpressed: traverse,
                  isCompact: isCompact,
                  iconData: CupertinoIcons.play_arrow_solid,
                  text: 'Traverse',
                ),
                CustomIconButton(
                  isdark: isdark,
                  onpressed: () {
                    vll.reverse();
                    refresh();
                  },
                  isCompact: isCompact,
                  iconData: CupertinoIcons.arrow_2_circlepath,
                  text: 'Reverse',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
