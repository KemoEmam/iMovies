import 'package:clean_architecture_app/feature/Tv/series_details/logic/series_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/style.dart';
import '../../../../core/widgets/custom_movie_banner.dart';
import '../../../../core/widgets/movie_rate.dart';
import '../../crew/ui/series_actor_screen.dart';
import '../../video/ui/series_video_screen.dart';
import '../data/model/series_details.dart';
import '../logic/series_details_state.dart';
import 'widget/geners_list_view.dart';
import 'widget/seasons_list_view.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final int movieId;

  const SeriesDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      body: BlocProvider(
        create: (BuildContext context) =>
            getIt<SeriesDetailsCubit>()..getSeriesDetails(seriesId: movieId),
        child: BlocBuilder<SeriesDetailsCubit,
            SeriesDetailsState<SeriesDetailsModel>>(
          builder: (context, state) {
            if (state is SeriesDetailsStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SeriesDetailsStateSuccess) {
              final seriesDetails =
                  context.read<SeriesDetailsCubit>().seriesDetailsList!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomMovieBanner(
                      bannerImgae:
                          'https://image.tmdb.org/t/p/w500${seriesDetails.posterPath}',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MovieRate(
                                rate:
                                    '⭐ ${seriesDetails.voteAverage!.toStringAsFixed(2)}',
                                review: '(${seriesDetails.voteCount} reviews)',
                              ),
                              const Spacer(),
                              Text(
                                '${seriesDetails.firstAirDate}',
                                style: TextStyles.font12WhiteSemiBold,
                              ),
                            ],
                          ),
                          verticalSpacing(15),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  seriesDetails.name!,
                                  style: TextStyles.font18WhiteBold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  String url = seriesDetails.homepage!;
                                  launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.inAppWebView,
                                  );
                                },
                                icon: const Icon(
                                  Icons.link_outlined,
                                ),
                              ),
                            ],
                          ),
                          verticalSpacing(20),
                          const GenersListView(),
                          verticalSpacing(20),
                          Text(
                            seriesDetails.overview!,
                            style: TextStyles.font12LightgreySemiBold,
                            textAlign: TextAlign.start,
                          ),
                          verticalSpacing(20),
                          Text(
                            'Seasons',
                            style: TextStyles.font18WhiteBold,
                            textAlign: TextAlign.start,
                          ),
                          verticalSpacing(20),
                          const SeasonsListView(),
                          verticalSpacing(50),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: SeriesVideoScreen(
                                seriesId: seriesDetails.id!,
                              ),
                            ),
                          ),
                          verticalSpacing(50),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SeriesActorScreen(
                              seriesId: seriesDetails.id!,
                            ),
                          ),
                          verticalSpacing(50),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
