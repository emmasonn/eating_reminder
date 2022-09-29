import 'package:flutter/material.dart';
import 'package:informat/core/widgets/custom_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
