import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/ui/widgets/custom_widgets/config_item.dart';
import 'package:algov/ui/widgets/custom_widgets/cyan_text_field.dart';
import 'package:flutter/material.dart';

class SpeedRow extends StatefulWidget {
  final VisualController controller; // or whatever controller type is
  final bool isCompact;
  final double availableWidth;
  final Algo algorithm;
  final bool isdark;

  const SpeedRow({
    super.key,
    required this.controller,
    required this.isCompact,
    required this.availableWidth,
    required this.algorithm,
    required this.isdark,
  });

  @override
  State<SpeedRow> createState() => _SpeedRowState();
}

class _SpeedRowState extends State<SpeedRow> {
  late double _currentSpeed;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentSpeed = widget.controller.speed;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConfigItem(
          isdark: widget.isdark,
          label: "Speed: ${_currentSpeed.toStringAsFixed(2)}x",
          width: widget.availableWidth * (widget.isCompact ? 0.55 : 0.6),
          child: Slider(
            activeColor: widget.isdark ? Colors.cyanAccent : Colors.tealAccent,
            inactiveColor: Colors.transparent,
            value: _currentSpeed,
            min: 0.25,
            max: 5.0,
            divisions: 19,
            label: 'Speed: ${_currentSpeed.toStringAsFixed(2)}x',
            onChanged: (v) {
              setState(() => _currentSpeed = v);
              widget.controller.speed = v; // still update controller
            },
          ),
        ),
        if (widget.controller is SearchAlgoController)
          SizedBox(
            width: widget.availableWidth * 0.36,
            height: widget.availableWidth * 0.3,
            child: CyanTextField(
              tcontroller: textEditingController,
              isdark: widget.isdark,
              labelText: "<9",
              isicon: true,
              width: widget.availableWidth * 0.36, // adjust as needed
              height: widget.availableWidth * 0.3,
              isCompact: widget.isCompact,
              cont: widget.controller as SearchAlgoController,
              algorithm:
                  widget.algorithm
                      as SearchingAlgorithm, // you need to pass or manage this
            ),
          ),
      ],
    );
  }
}
