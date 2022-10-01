import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';
import 'package:informat/feature/what_to_eat/widgets/schedule_meal_card.dart';
import 'package:informat/feature/what_to_eat/widgets/schedule_sticky_horizontal.dart';
import 'package:informat/feature/what_to_eat/widgets/schedule_sticky_widget.dart';

class PageMealSchedule extends StatefulWidget {
  const PageMealSchedule({super.key});

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fade,
        child: const PageMealSchedule());
  }

  @override
  State<PageMealSchedule> createState() => _PageMealScheduleState();
}

class _PageMealScheduleState extends State<PageMealSchedule> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
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
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.add),
            ),
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
        drawer: const FoodBlogDrawer(tag: 'schedule'),
        body: SafeArea(
            child: Container(
          width: size.width,
          height: size.height,
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: SizedBox(
                height: 200,
                width: size.width,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/food_icon.png'))),
                ),
              ),
            ),
            ...[
              'Monday',
              'Tueday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ].map((e) {
              return ScheduleStickyHorizontal(
                title: e,
              );
            }).toList()
          ]),
        )));
  }
}
