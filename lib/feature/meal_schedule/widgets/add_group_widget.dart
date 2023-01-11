import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';

class AddMealGroupDialog extends ConsumerStatefulWidget {
  AddMealGroupDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<AddMealGroupDialog> createState() => _AddMealGroupDialogState();
}

class _AddMealGroupDialogState extends ConsumerState<AddMealGroupDialog> {
  bool isLoading = false;
  late MealScheduleManager mealScheduleManager;
  String title = '';
  @override
  void initState() {
    super.initState();
    mealScheduleManager = ref.read(mealScheduleProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(mealScheduleProvider, (prev, state) {
      if (state is ScheduleLoading) {
        isLoading = true;
      } else if (state is CreateScheduleLoaded) {
        isLoading = false;
        Navigator.pop(context);
      }
    });

    return Container(
        height: 250,
        width: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: !isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create Meal Plan',
                        style:
                            theme.textTheme.subtitle1?.copyWith(fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Give it a name',
                      displayHint: DisplayHint.inside,
                      onChanged: (value) {
                        title = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel',
                              style: theme.textTheme.subtitle1?.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                        TextButton(
                          onPressed: () {
                            mealScheduleManager
                                .createSchedule(MealScheduleModel(
                              title: title,
                              createdAt: DateTime.now(),
                            ));
                          },
                          child: Text(
                            'Continue',
                            style: theme.textTheme.subtitle1?.copyWith(
                              color: theme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CupertinoActivityIndicator(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
        ));
  }
}

void showCreateScheduleDialog(BuildContext context) {
  showCustomDialog(
      context,
      Center(
        child: AddMealGroupDialog(),
      ));
}
