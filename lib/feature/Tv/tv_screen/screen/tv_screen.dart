import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:clean_architecture_app/core/theming/style.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
import '../../airing_today/ui/screen/airing_today_series_screen.dart';
import '../../popular_series/ui/screen/popular_series_screen.dart';
import '../../top_rated_series/ui/screen/top_rated_series.dart';
import '../widget/tv_slider.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManger.maindark,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  TvSlider(),
                  Positioned(
                    bottom: 70,
                    left: 10,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Play',
                              style: TextStyles.font12WhiteSemiBold,
                            ),
                          ),
                        ),
                        horizentalSpacing(200),
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.5),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 20), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_circle_fill_rounded,
                              size: 70,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                        horizentalSpacing(30),
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpacing(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const TopRatedSeriesScreen(),
                    verticalSpacing(20),
                    const PopularSeriesScreen(),
                    verticalSpacing(20),
                    const AiringTodaySeriesScreen(),
                    verticalSpacing(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
