import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/widgets/custom_carousel.dart';
import 'package:informat/feature/meal_schedule/widgets/custom_floating_bar.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_sticky_card.dart';
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';

class PageScheduleGroups extends ConsumerStatefulWidget {
  const PageScheduleGroups({super.key});

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fade,
        child: const PageScheduleGroups());
  }

  @override
  ConsumerState<PageScheduleGroups> createState() => _PageMealScheduleState();
}

class _PageMealScheduleState extends ConsumerState<PageScheduleGroups> {
  late MealScheduleManager mealScheduleManager;

  @override
  void initState() {
    super.initState();
    mealScheduleManager = ref.read(mealScheduleProvider.notifier);
    mealScheduleManager.subscribeToSchedule();
  }

  @override
  void dispose() {
    mealScheduleManager.unSubscribeStream();
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final state = ref.watch(mealScheduleProvider);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          iconTheme: IconThemeData(color: theme.primaryColor, size: 25),
          leading: Align(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/food_icon.png',
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text(
            'Meal Schedule',
            style: TextStyle(
              fontFamily: 'RubikBold',
              fontSize: 25,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                  onPressed: () {
                    if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
                      _scaffoldKey.currentState!.openDrawer();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Icon(
                      FontAwesomeIcons.bars,
                      color: theme.primaryColor,
                    ),
                  )),
            ),
          ],
        ),
        drawer: const FoodBlogDrawer(tag: 'scheduleGroups'),
        floatingActionButton: const CustomFloatingBar(),
        body: SafeArea(
            child: Container(
          width: size.width,
          height: size.height,
          child: CustomScrollView(slivers: <Widget>[
            // SliverAppBar(
            //   pinned: false,
            //   floating: false,
            //   snap: false,
            //   automaticallyImplyLeading: false,
            //   expandedHeight: 200,
            //   flexibleSpace: SizedBox(
            //     height: 200,
            //     width: size.width,
            //     child: const CustomCarousel(),
            //   ),
            // ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            //this section contain the meal schedules created and
            //pinned by user
            const ScheduleStickyCard(
              title: 'Personalized',
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            //the below section will show list of meal schedule created for
            //different ethnic group dwelling in thet country of user
            ...[
              'Suggestions',
            ].map((e) {
              return ScheduleStickyCard(
                title: e,
              );
            }).toList()
          ]),
        )));
  }
}
