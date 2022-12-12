import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/utils/time_based_utils.dart';
import 'package:informat/core/widgets/custom_drop_down.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

class PageAddFood extends ConsumerStatefulWidget {
  const PageAddFood({super.key, this.scheduleId, this.day});
  final String? scheduleId;
  final String? day;

  static Page page({LocalKey? key, String? id, String? day}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fromBottom,
        child: PageAddFood(
          scheduleId: id,
          day: day,
        ));
  }

  @override
  ConsumerState<PageAddFood> createState() => _PageAddFoodState();
}

class _PageAddFoodState extends ConsumerState<PageAddFood> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late MealScheduleManager mealScheduleManager;
  String mealPeriod = '';
  String title = '';
  String desc = '';

  @override
  void initState() {
    super.initState();
    mealScheduleManager = ref.read(mealScheduleProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.primaryColor, size: 25),
        title: Text(
          widget.day ?? '',
          style:
              GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final food = FoodModel(
                id: '',
                ownerId: '',
                scheduleId: widget.scheduleId ?? '',
                title: title,
                period: mealPeriod,
                day: widget.day ?? '',
              );
            },
            child: Text(
              'Done',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: InkWell(
                  onTap: () {
                    
                  },
                  child: CircleAvatar(
                    backgroundColor: theme.primaryColor.withOpacity(0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(FontAwesomeIcons.image),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Select Food',
                          style: GoogleFonts.montserrat(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Food Name',
                onChanged: (value) {},
                displayHint: DisplayHint.inside,
              ),
              CustomDropDown(
                title: 'Meal Schedule',
                items: mealSchedulers,
                onSelected: (value) {
                  mealPeriod = value?.props[0] as String? ?? '';
                },
              ),
              CustomTextField(
                hintText: 'How will you like to eat this meal?',
                onChanged: (value) {
                  desc = value!;
                },
                displayHint: DisplayHint.inside,
                maxLine: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
