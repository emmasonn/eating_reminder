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
    final state = ref.watch(mealScheduleProvider);
    if (state is CreateScheduleLoading) {
      isLoading = true;
    } else if (state is CreateScheduleLoaded) {
      isLoading = false;
      Future.delayed(const Duration(microseconds: 500), () {
        Navigator.pop(context);
      });
    }

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
                    Text(
                      'Create Meal Scheadule',
                      style: GoogleFonts.montserrat(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
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
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            mealScheduleManager
                                .createSchedule(MealScheduleModel(
                              country: 'Nigeria',
                              title: title,
                              description: 'Created by Nnamani',
                              createdAt: DateTime.now(),
                            ));
                          },
                          child: Text('Submit',
                              style: GoogleFonts.montserrat(fontSize: 14)),
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
