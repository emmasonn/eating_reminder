import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    this.initialValue,
    required this.title,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  final void Function(Equatable?) onSelected;
  final Equatable? initialValue;
  final String title;
  final List<Equatable> items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  Equatable? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue; // ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border(
            bottom: BorderSide(color: theme.primaryColorLight, width: 1.0),
            top: BorderSide(color: theme.primaryColorLight, width: 1.0),
            right: BorderSide(color: theme.primaryColorLight, width: 1.0),
            left: BorderSide(color: theme.primaryColorLight, width: 1.0),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          // Text(
          //   widget.title,
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontFamily: 'Rubik',
          //     color: theme.primaryColor,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<Equatable>(
                    iconSize: 24,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: theme.primaryColorLight,
                        fontWeight: FontWeight.w600),
                    value: currentValue,
                    hint: Text('Select Meal time'),
                    items: widget.items.map<DropdownMenuItem<Equatable>>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.props[0] as String? ?? '',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: theme.primaryColorLight,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: ((value) {
                      setState(() {
                        currentValue = value;
                        widget.onSelected(value);
                      });
                    }),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
