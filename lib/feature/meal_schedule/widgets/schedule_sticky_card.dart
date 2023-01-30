import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/animations/slide_animation.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_card.dart';

class ScheduleStickyCard extends StatefulWidget {
  const ScheduleStickyCard({
    super.key,
    this.title,
    required this.mealSchedules,
  });
  final String? title;
  final List<MealScheduleModel> mealSchedules;

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

    log('meal scheduler: ${widget.mealSchedules.length}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverStickyHeader(
        header: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title ?? '',
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          if (widget.mealSchedules.isEmpty) ...[
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 500,
                  height: 200,
                  color: theme.canvasColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.hourglass_empty,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'No meal schedule',
                        style: theme.textTheme.bodyText2,
                      )
                    ],
                  ),
                )
              ],
            )
          ] else ...[
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.vertical,
              itemCount: widget.mealSchedules.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final currentSchedule = widget.mealSchedules[index];
                return SlideAnimation(
                  itemCount: widget.mealSchedules.length,
                  position: index,
                  animationController: _animationController,
                  slideDirection: SlideDirection.fromTop,
                  child: ScheduleCard(
                    mealScheduleModel: currentSchedule,
                  ),
                );
              },
            )
          ]
        ])));
  }
}
