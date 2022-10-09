import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/Auth/pages/page_auth.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';
import 'package:informat/feature/meal_schedule/widgets/food_schedule_sticky.dart';

class PageMealSchedule extends ConsumerStatefulWidget {
  const PageMealSchedule({super.key});

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fade,
        child: const PageMealSchedule());
  }

  @override
  ConsumerState<PageMealSchedule> createState() => _PageMealScheduleState();
}

class _PageMealScheduleState extends ConsumerState<PageMealSchedule> {
  late MealScheduleManager mealScheduleManager;

  @override
  void initState() {
    super.initState();
    mealScheduleManager = ref.read(mealScheduleProvider.notifier);
    // mealScheduleManager.subscribeToSchedule();
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
          backgroundColor: Colors.white,
          centerTitle: false,
          iconTheme: IconThemeData(color: theme.primaryColor, size: 25),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          // title: const Text(
          //   'Meal Schedule',
          //   style: TextStyle(
          //     fontFamily: 'RubikBold',
          //     fontSize: 20,
          //   ),
          // ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.share,
              ),
            )
          ],
        ),
        drawer: const FoodBlogDrawer(tag: 'schedule'),
        body: SafeArea(
            child: Container(
          width: size.width,
          height: size.height,
          child: CustomScrollView(slivers: <Widget>[
            ...[
              'Monday',
              'Tueday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ].map((e) {
              return FoodScheduleStickyCard(
                title: e,
              );
            }).toList()
          ]),
        )));
  }
}
