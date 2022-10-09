import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index, _) {
        return Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/food_icon.png'),
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue),
        );
      },
      options: CarouselOptions(
        height: 200,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        autoPlay: true,
        initialPage: 0,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.ease,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
