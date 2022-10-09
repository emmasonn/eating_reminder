import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/animations/slide_animation.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_card.dart';

class ScheduleStickyCard extends StatefulWidget {
  const ScheduleStickyCard({
    super.key,
    this.title,
  });
  final String? title;

  @override
  State<ScheduleStickyCard> createState() => _ScheduleStickyCardState();
}

class _ScheduleStickyCardState extends State<ScheduleStickyCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 500,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
        header: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title ?? '',
            style: GoogleFonts.montserrat(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.vertical,
            itemCount: 3,
            primary: false,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return SlideAnimation(
                itemCount: 3,
                position: index,
                animationController: _animationController,
                slideDirection: SlideDirection.fromTop,
                child: const ScheduleCard(),
              );
            }),
          )
        ])));
  }
}
