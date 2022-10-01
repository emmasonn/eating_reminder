import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/what_to_eat/widgets/food_blog_drawer.dart';
import 'package:informat/feature/what_to_eat/widgets/home_food_card.dart';

class PageFoods extends StatefulWidget {
  const PageFoods({
    Key? key,
  }) : super(key: key);

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.none,
        child: const PageFoods());
  }

  @override
  State<StatefulWidget> createState() => _PageContactsState();
}

class _PageContactsState extends State<PageFoods> {
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
          'What to eat',
          style: TextStyle(
            fontFamily: 'RubikBold',
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.bell),
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
      drawer: const FoodBlogDrawer(
        tag: 'home',
      ),
      body: SafeArea(
          child: Container(
        width: size.width,
        height: size.height,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
              automaticallyImplyLeading: false,
              expandedHeight: 250,
              flexibleSpace: SizedBox(
                height: 250,
                width: size.width,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Hey 😊 it\'s launch time',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 250,
                            width: 200,
                            child: CircleAvatar(
                              child: Image.asset(
                                'assets/images/food_icon.png',
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              automaticallyImplyLeading: false,
              expandedHeight: 60,
              flexibleSpace: SizedBox(
                height: 60,
                width: size.width,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Other choices to eat🍗🥘',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: 20,
                primary: false,
                itemBuilder: (context, index) {
                  return const HomeFoodCard();
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
