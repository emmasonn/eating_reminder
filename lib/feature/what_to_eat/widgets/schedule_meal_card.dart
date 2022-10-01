import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleMealCard extends StatefulWidget {
  const ScheduleMealCard({super.key});

  @override
  State<ScheduleMealCard> createState() => _ScheduleMealCardState();
}

class _ScheduleMealCardState extends State<ScheduleMealCard> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'BreakFast',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: const Card(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/food_icon.png'),
            ),
          ),
        ),
        Container(
            width: 200,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              'Egusi, Meat, Swallow and Ogbono',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 14,
              ),
            ))
      ],
    );
  }
}
