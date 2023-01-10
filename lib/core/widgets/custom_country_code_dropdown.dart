import 'package:flutter/material.dart';
import 'package:informat/core/widgets/countries.dart';
import 'package:informat/core/widgets/custom_input_border.dart';

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
  final allCountries = countries.toStringList();
  String? currentValue;
  double cornerRadius = 8.0;
  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    iconSize: 24,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: theme.primaryColorLight,
                        fontWeight: FontWeight.w600),
                    value: currentValue,
                    hint: Text('Select country'),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 18),
                      border: CustomInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      enabledBorder: CustomInputBorder(
                        borderSide: BorderSide(
                          width: 1.2,
                          color: theme.primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      focusedBorder: CustomInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: theme.primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                    ),
                    items: allCountries.map<DropdownMenuItem<String>>((e) {
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
                        widget.onSelected(value);
                      });
                    }),
                    selectedItemBuilder: (context) {
                      return allCountries
                          .map(
                            (e) => Text(e,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          )
                          .toList();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
