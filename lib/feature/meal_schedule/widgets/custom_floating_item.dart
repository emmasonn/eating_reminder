import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFloatingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;

  const CustomFloatingItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 45.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () => onPressed!(),
          child: Row(
            children: [
              Icon(icon, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                title,
                style: GoogleFonts.montserrat(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
