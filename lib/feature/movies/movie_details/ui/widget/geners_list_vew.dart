import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../logic/movie_details_cubit.dart';

class GenersListVew extends StatelessWidget {
  const GenersListVew({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 75, 75, 75),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                context
                    .read<MovieDetailsCubit>()
                    .movieDetailsList!
                    .genres![index]
                    .name!,
                style: TextStyles.font12WhiteSemiBold,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return horizentalSpacing(20);
        },
        itemCount:
            context.read<MovieDetailsCubit>().movieDetailsList!.genres!.length,
      ),
    );
  }
}
