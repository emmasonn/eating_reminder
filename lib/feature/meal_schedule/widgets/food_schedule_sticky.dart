import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/animations/slide_animation.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_meal_card.dart';

class FoodScheduleStickyCard extends StatefulWidget {
  const FoodScheduleStickyCard({
    super.key,
    required this.title,
  });
  final String? title;

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
                      GoRouter.of(context)
                          .go('/schedule-groups/schedule/1/add-food/Monday');
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
            Container(
              height: 270,
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.symmetric(vertical: 20),
                scrollDirection: Axis.horizontal,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
