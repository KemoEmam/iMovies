import 'package:flutter/material.dart';

import '../../core/helper/spacing.dart';
import '../../core/theming/colors.dart';
import 'now_playing_videos/ui/screen/now_playing_videos_screen.dart';
import 'popular/ui/screen/popular_screen.dart';
import 'top_rated/ui/screen/top_rated_screen.dart';
import 'trending/ui/widget/drop_down_button.dart';
import 'trending/ui/widget/trending_slider.dart';
import 'upcoming/ui/screen/upcoming_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Trending' ' 🔥',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 16)),
                horizentalSpacing(10),
                const CustomDropDownButton(),
              ],
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.8,
            flexibleSpace: const FlexibleSpaceBar(
              background: TrendingSlider(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Expanded(
              flex: 1,
              child: Container(
                color: ColorManger.maindark,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(30),
                      const PlayingVideos(),
                      verticalSpacing(15),
                      const PopularScreen(),
                      verticalSpacing(15),
                      const UpComingScreen(),
                      verticalSpacing(15),
                      const TopRatedScreen(),
                      verticalSpacing(15),
                    ],
                  ),
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}
