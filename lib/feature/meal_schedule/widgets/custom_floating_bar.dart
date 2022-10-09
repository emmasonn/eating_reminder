import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informat/feature/meal_schedule/widgets/custom_floating_item.dart';

class CustomFloatingBar extends StatefulWidget {
  final void Function()? onReload;
  const CustomFloatingBar({Key? key, this.onReload}) : super(key: key);

  @override
  State<CustomFloatingBar> createState() => _CustomFloatingBarState();
}

class _CustomFloatingBarState extends State<CustomFloatingBar> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      childrenButtonSize: const Size(100, 45),
      elevation: 12.0,
      overlayOpacity: 0.8,
      openCloseDial: isDialOpen,
      animationCurve: Curves.ease,
      closeDialOnPop: true,
      animationDuration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      useRotationAnimation: true,
      onClose: () {
        setState(() {});
      },
      onOpen: () {
        setState(() {});
      },
      children: [
        SpeedDialChild(
          labelWidget: CustomFloatingItem(
            title: 'Add From Suggestions',
            icon: FontAwesomeIcons.tag,
            onPressed: () async {
              isDialOpen.value = false;

              //Reload
              widget.onReload!();
            },
          ),
        ),
        SpeedDialChild(
          labelWidget: CustomFloatingItem(
            title: 'Create Meal Schedule',
            icon: Icons.new_label,
            onPressed: () async {
              isDialOpen.value = false;
              //Reload
              widget.onReload!();
            },
          ),
        ),
      ],
      child: Transform.rotate(
        angle: isDialOpen.value ? pi / 4 : 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
