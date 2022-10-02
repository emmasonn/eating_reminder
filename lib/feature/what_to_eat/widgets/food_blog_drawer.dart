import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          const ProfileDrawerHeader(),
          const Divider(
            color: Color(0xff34333f),
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
                    isActive: widget.tag == 'schedule',
                    onPressed: () {
                      GoRouter.of(context).go('/schedule');
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
                  FoodDrawerItem(
                    title: 'Account',
                    icon: Icons.food_bank,
                    isActive: widget.tag == 'account',
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
