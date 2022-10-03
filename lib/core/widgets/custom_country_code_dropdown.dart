import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
      height: 60,
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
            height: 5,
          ),
          Text(
            'Country Code',
            style: GoogleFonts.montserrat(fontSize: 12),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          iconSize: 24,
                          style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          value: currentValue,
                          items:
                              countryCodes.map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: ((value) {
                            setState(() {
                              currentValue = value;
                              widget.onSelected;
                            });
                          }))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
