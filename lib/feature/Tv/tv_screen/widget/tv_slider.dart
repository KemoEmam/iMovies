import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';

class TvSlider extends StatelessWidget {
  TvSlider({super.key});

  final List<String> tvSeriesBanner = [
    "assets/images/berlin.jpg",
    "assets/images/avengers.jpg",
    "assets/images/gameofthrones.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 35, 35, 35),
            const Color.fromARGB(255, 56, 51, 51).withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.04, 0.25],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 500,
              autoPlay: true,
              aspectRatio: 16 / 20,
              autoPlayCurve: Curves.easeIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              reverse: false,
              initialPage: 0,
              viewportFraction: 1.0, // Ensure full width
            ),
            items: tvSeriesBanner.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: constraints.maxWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: ColorManger.lightgray,
                    ),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
