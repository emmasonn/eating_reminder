import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({
    super.key,
    required this.mealScheduleModel,
  });
  final MealScheduleModel mealScheduleModel;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.topRight,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: theme.backgroundColor,
                  elevation: 2.0,
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/schedule-groups/schedule/${widget.mealScheduleModel.id}');
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.mealScheduleModel.title,
                                    style: theme.textTheme.subtitle1,
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
                              Text(
                                widget.mealScheduleModel.country ?? '',
                                style: theme.textTheme.subtitle2
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
      ),
    );
  }
}
