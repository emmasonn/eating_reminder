import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeFoodCard extends StatefulWidget {
  const HomeFoodCard({Key? key}) : super(key: key);

  @override
  State<HomeFoodCard> createState() => _HomeFoodCardState();
}

class _HomeFoodCardState extends State<HomeFoodCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Image.asset(
            'assets/images/food_icon.png',
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Text(
            'Spagatti',
            style: GoogleFonts.montserrat(
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
