import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/resources/colors.dart';
import 'package:informat/feature/profile/widgets/drawer_profile_header.dart';
import 'package:informat/feature/what_to_eat/widgets/food_drawer_item.dart';

class FoodBlogDrawer extends StatefulWidget {
  const FoodBlogDrawer({
    Key? key,
    required this.tag,
    this.onPressed,
  }) : super(key: key);
  final String tag;
  final Function()? onPressed;

  @override
  State<FoodBlogDrawer> createState() => _FoodBlogDrawerState();
}

class _FoodBlogDrawerState extends State<FoodBlogDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      color: Colors.white,
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
                          width: 30,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Light',
                            onChanged: (value) {},
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
