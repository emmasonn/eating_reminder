import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/resources/colors.dart';
import 'package:informat/feature/profile/widgets/drawer_profile_header.dart';
import 'package:informat/feature/settings/manager/settings_manager.dart';
import 'package:informat/feature/what_to_eat/widgets/food_drawer_item.dart';

class FoodBlogDrawer extends ConsumerStatefulWidget {
  const FoodBlogDrawer({
    Key? key,
    required this.tag,
    this.onPressed,
  }) : super(key: key);
  final String tag;
  final Function()? onPressed;

  @override
  ConsumerState<FoodBlogDrawer> createState() => _FoodBlogDrawerState();
}

class _FoodBlogDrawerState extends ConsumerState<FoodBlogDrawer> {
  SettingsManager? settingsManager;
  String currentTheme = 'Light';

  @override
  void initState() {
    super.initState();
    settingsManager = ref.read(settingsProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    //listens to change in settingsModel darktheme to update the app theme
    final isDark = ref.watch(
        settingsProvider.select((settingsModel) => settingsModel.isDarkTheme));

    if (isDark) {
      currentTheme = 'Dark';
    } else {
      currentTheme = 'Light';
    }

    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      width: size.width * 0.7,
      color: theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileDrawerHeader(
            onSignOut: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: lightPink,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: Column(
                children: [
                  FoodDrawerItem(
                    title: 'What to eat',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'home',
                    onPressed: () {
                      GoRouter.of(context).go('/what-to-eat');
                      Navigator.pop(context);
                    },
                  ),
                  FoodDrawerItem(
                    title: 'Collection',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'collection',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FoodDrawerItem(
                    title: 'Meal Schedule',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'scheduleGroups',
                    onPressed: () {
                      GoRouter.of(context).go('/schedule-groups');
                      Navigator.pop(context);
                    },
                  ),
                  FoodDrawerItem(
                    title: 'Notifications',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'notification',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          'Theme',
                          style: TextStyle(fontFamily: 'Rubik'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentTheme,
                            onChanged: (value) {
                              if (value == 'Light') {
                                settingsManager?.changeTheme(ThemeMode.light);
                              } else {
                                settingsManager?.changeTheme(ThemeMode.dark);
                              }
                            },
                            items: ['Light', 'Dark']
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          e,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14, color: Colors.blue),
                                        ),
                                        e == 'Light'
                                            ? const Icon(Icons.light_mode)
                                            : const Icon(Icons.dark_mode)
                                      ],
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: lightPink,
                  ),
                  FoodDrawerItem(
                    title: 'Buy me Coffee ☕',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'notification',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
