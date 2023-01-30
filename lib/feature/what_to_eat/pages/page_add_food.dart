import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/helpers/image_processors.dart';
import 'package:informat/core/utils/custom_select_image_dialog.dart';
import 'package:informat/core/utils/time_based_utils.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_drop_down.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_progress_dialog.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/core/widgets/custom_top_snackbar.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:informat/feature/what_to_eat/managers/food_state.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:nb_utils/nb_utils.dart';

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
  String? mealPeriod;
  String? title;
  String? desc;
  String? foodImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen<FoodManager>(foodProvider, (prev, manager) {
      final state = manager.currentFoodState;

      if (state is FoodsLoading) {
        showCustomDialog(
          context,
          const CustomProgressDialog(),
        );
      } else if (state is CreateFoodLoaded) {
        //pop loading dialog
        Navigator.pop(context);

        if (state.status) {
          //show top appbar
          showCustomTopSnackBar(
            context,
            msg: 'Created Successfuly',
            color: greenColor,
          );
          reValidateForm();
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
                ownerId: '',
                imageUrl: foodImage,
                scheduleId: widget.scheduleId ?? '',
                title: title ?? '',
                description: desc,
                period: mealPeriod ?? '',
                day: widget.day ?? '',
                lastUpdated: DateTime.now(),
              );

              log(food);

              ref.read(foodProvider).createFood(food);
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
                  selectImageBottomSheet(
                    context,
                    onSelected: (image) {
                      Navigator.pop(context);
                      setState(() {
                        foodImage = image;
                      });
                      log(image);
                    },
                  );
                },
                child: CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.2),
                  child: foodImage.isEmptyOrNull
                      ? Column(
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
                        )
                      : loadImageWidget(foodImage!),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'Food Name',
              onChanged: (value) {
                title = value;
              },
              displayHint: DisplayHint.inside,
            ),
            CustomDropDown(
              title: 'Meal Schedule',
              items: schedulers,
              onSelected: (value) {
                mealPeriod = value?.props[0] as String? ?? '';
                log('mealperiod: $mealPeriod');
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
    );
  }

  void reValidateForm() {
    ref.invalidate(foodProvider);
    setState(() {
      mealPeriod = '';
      title = '';
      desc = '';
      foodImage = '';
    });
  }
}
