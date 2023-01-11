import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_progress_dialog.dart';
import 'package:informat/core/widgets/custom_top_snackbar.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';
import 'package:informat/feature/meal_schedule/widgets/custom_carousel.dart';
import 'package:informat/feature/meal_schedule/widgets/custom_floating_bar.dart';
import 'package:informat/feature/meal_schedule/widgets/schedule_sticky_card.dart';
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';
import 'package:nb_utils/nb_utils.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MealScheduleModel> mealSchedules = [];

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final state = ref.watch(mealScheduleProvider);

    if (state is AllSchedulesLoaded) {
      mealSchedules = state.mealSchedules ?? [];
    }

    ref.listen(mealScheduleProvider, (prev, state) {
      if (state is ScheduleLoading) {
        showCustomDialog(
          context,
          const CustomProgressDialog(),
        );
      } else if (state is CreateScheduleLoaded) {
        //pop loading
        Navigator.pop(context);

        if (state.status) {
          //show top appbar
          showCustomTopSnackBar(
            context,
            msg: 'Created Successfuly',
            color: greenColor,
          );
        } else {
          //show top appbar
          showCustomTopSnackBar(
            context,
            msg: state.error ?? '',
            color: redColor,
          );
        }
      }
    });

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
            ScheduleStickyCard(
              title: 'Pinned',
              mealSchedules: mealSchedules,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            //the below section will show list of meal schedule created by
            //other people in thet country of user
            ...[
              'Others meal schedules',
            ].map((e) {
              return ScheduleStickyCard(
                title: e,
                mealSchedules: [],
              );
            }).toList()
          ]),
        )));
  }

  void reinitProvider() {
    ref.invalidate(mealScheduleProvider);
    mealScheduleManager = ref.read(mealScheduleProvider.notifier);
  }
}
