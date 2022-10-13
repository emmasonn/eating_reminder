import 'package:flutter/material.dart';

class CustomCountryCodesDropDown extends StatefulWidget {
  const CustomCountryCodesDropDown({
    Key? key,
    this.initialValue,
    required this.onSelected,
  }) : super(key: key);
  final void Function(String?) onSelected;
  final String? initialValue;

  @override
  State<CustomCountryCodesDropDown> createState() =>
      _CustomCountryCodesDropDownState();
}

class _CustomCountryCodesDropDownState
    extends State<CustomCountryCodesDropDown> {
  final countryCodes = ['+234(Nigeria)', '+244(USA)'];
  String? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue ?? countryCodes.first;
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
          border: const Border(
            bottom: BorderSide(),
            top: BorderSide(),
            right: BorderSide(),
            left: BorderSide(),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          Text(
            'Country Code',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Rubik',
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    iconSize: 24,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: theme.primaryColorLight,
                        fontWeight: FontWeight.w600),
                    value: currentValue,
                    items: countryCodes.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
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
                        widget.onSelected;
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
