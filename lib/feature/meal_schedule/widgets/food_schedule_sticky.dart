import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/animations/slide_animation.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_meal_card.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodScheduleStickyCard extends StatefulWidget {
  const FoodScheduleStickyCard({
    super.key,
    required this.title,
    required this.scheduleId,
    required this.foods,
    required this.onPressed,
  });
  final String? title;
  final String? scheduleId;
  final List<FoodModel> foods;

  final Function() onPressed;

  @override
  State<FoodScheduleStickyCard> createState() => _FoodScheduleStickyCardState();
}

class _FoodScheduleStickyCardState extends State<FoodScheduleStickyCard>
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
    final theme = Theme.of(context);
    return SliverStickyHeader(
      header: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: theme.appBarTheme.backgroundColor),
        padding: const EdgeInsets.only(left: 33.0, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.calendarDays,
                  color: Colors.blue,
                  size: 10,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.title ?? '',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).goNamed('add-food', params: {
                        'id': widget.scheduleId ?? ''
                      }, queryParams: {
                        'day': widget.title,
                        'id': widget.scheduleId,
                      });
                      widget.onPressed.call();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.penToSquare))
              ],
            ),
          ],
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            if (widget.foods.isEmpty) ...[
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
                          'No meal has been added \n for ${widget.title}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText2,
                        )
                      ],
                    ),
                  )
                ],
              )
            ] else ...[
              Container(
                height: 270,
                child: ListView.builder(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.foods.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final food = widget.foods[index];
                      if (index != widget.foods.length - 1) {
                        return SlideAnimation(
                          itemCount: widget.foods.length,
                          position: index,
                          animationController: _animationController,
                          slideDirection: SlideDirection.fromRight,
                          child: ScheduleMealCard(
                            foodModel: food,
                          ),
                        );
                      } else {
                        return SlideAnimation(
                          itemCount: widget.foods.length,
                          position: index,
                          animationController: _animationController,
                          slideDirection: SlideDirection.fromRight,
                          child: Row(
                            children: [
                              ScheduleMealCard(
                                foodModel: food,
                              ),
                              InkWell(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed('add-food', params: {
                                    'id': widget.scheduleId ?? ''
                                  }, queryParams: {
                                    'day': widget.title,
                                    'id': widget.scheduleId,
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(50),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[500]),
                                  child: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }),
              )
            ]
          ],
        ),
      ),
    );
  }
}
