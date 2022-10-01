import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/animations/slide_animation.dart';
import 'package:informat/feature/what_to_eat/widgets/schedule_card.dart';
import 'package:informat/feature/what_to_eat/widgets/schedule_meal_card.dart';

class ScheduleStickyWidget extends StatefulWidget {
  const ScheduleStickyWidget({super.key});

  @override
  State<ScheduleStickyWidget> createState() => _ScheduleStickyWidgetState();
}

class _ScheduleStickyWidgetState extends State<ScheduleStickyWidget>
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
          color: Colors.white,
          padding: const EdgeInsets.only(left: 33.0, top: 10, bottom: 10),
          child: Text(
            'Grandma schedule',
            style: GoogleFonts.montserrat(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            scrollDirection: Axis.vertical,
            itemCount: 3,
            primary: false,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return SlideAnimation(
                itemCount: 3,
                position: index,
                animationController: _animationController,
                slideDirection: SlideDirection.fromRight,
                child: const ScheduleMealCard(),
              );
            }),
          )
        ])));
  }
}
