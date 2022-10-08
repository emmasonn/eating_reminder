import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topRight,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
              child: Icon(
                Icons.label,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Card(
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amina (Hausa Meal Schedule)',
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          const Text('🌎'),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'United Arab Emirate',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.yellowAccent,
            child: RotatedBox(
              quarterTurns: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '4.6',
                    style: GoogleFonts.montserrat(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
