import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/utils/date_time_util.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_progress_dialog.dart';
import 'package:informat/core/widgets/custom_progress_widget.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:informat/feature/what_to_eat/managers/food_state.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart' as pr;
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';
import 'package:informat/feature/meal_schedule/widgets/food_schedule_sticky.dart';

class PageMealSchedule extends ConsumerStatefulWidget {
  const PageMealSchedule({
    super.key,
    required this.scheduleId,
  });
  final String scheduleId;

  static Page page({LocalKey? key, required String scheduleId}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fade,
        child: PageMealSchedule(
          scheduleId: scheduleId,
        ));
  }

  @override
  ConsumerState<PageMealSchedule> createState() => _PageMealScheduleState();
}

class _PageMealScheduleState extends ConsumerState<PageMealSchedule> {
  Map<String, List<FoodModel>> foodsAndDay = {};
  late FoodManager foodManager;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      pr.Provider.of<FoodManager>(context, listen: false)
          .subscribeToFoodSchedule(widget.scheduleId);
    }
  }

  @override
  void didChangeDependencies() {
    foodManager = pr.Provider.of<FoodManager>(context, listen: false);
    super.didChangeDependencies();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        iconTheme: IconThemeData(color: theme.primaryColor, size: 25),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          'Meal Schedule',
          style: TextStyle(
            fontFamily: 'RubikBold',
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.share,
            ),
          )
        ],
      ),
      drawer: const FoodBlogDrawer(tag: 'schedule'),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          width: size.width,
          height: size.height,
          child: StreamBuilder<Map<String, List<FoodModel>>>(
              stream: pr.Provider.of<FoodManager>(context, listen: false)
                  .foodsStream(widget.scheduleId),
              builder: (context, snapshot) {
                Map<String, List<FoodModel>> foodsAndDay = {};
                if (snapshot.hasData) {
                  foodsAndDay = snapshot.data ?? {};
                } else if (snapshot.hasError) {
                  return Container(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const CustomProgressDialog();
                }
                return CustomScrollView(slivers: <Widget>[
                  //create the food plan
                  if (foodsAndDay.isNotEmpty) ...[
                    ...weekDays.map((e) {
                      return FoodScheduleStickyCard(
                        title: e,
                        scheduleId: widget.scheduleId,
                        foods: foodsAndDay[e] ?? [],
                        onPressed: () {
                          foodManager.unSubscribeToFoodSchedule();
                        },
                      );
                    }).toList()
                  ]
                ]);
              }),
        ),
      ),
    );
  }
}
