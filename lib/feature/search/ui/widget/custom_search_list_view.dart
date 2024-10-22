import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:clean_architecture_app/feature/search/data/model/search_model.dart';
import 'package:clean_architecture_app/feature/search/logic/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/style.dart';
import '../../logic/search_cubit.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState<SearchModel>>(
      builder: (BuildContext context, SearchState<SearchModel> state) {
        return Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Card(
                    color: const Color.fromARGB(255, 50, 46, 46),
                    child: Row(
                      children: [
                        verticalSpacing(15),
                        SizedBox(
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: context
                                        .read<SearchCubit>()
                                        .searchList!
                                        .results![index]
                                        .posterPath !=
                                    null
                                ? CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${context.read<SearchCubit>().searchList!.results![index].posterPath}')
                                : CachedNetworkImage(
                                    imageUrl:
                                        'https://ih0.redbubble.net/image.425660345.5511/raf,360x360,075,t,fafafa:ca443f4786.jpg',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        horizentalSpacing(20),
                        Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpacing(10),
                                  SizedBox(
                                      width: 200,
                                      child: context
                                                  .read<SearchCubit>()
                                                  .searchList!
                                                  .results![index]
                                                  .title !=
                                              null
                                          ? Text(
                                              '${context.read<SearchCubit>().searchList!.results![index].title}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyles.font18WhiteBold)
                                          : context
                                                      .read<SearchCubit>()
                                                      .searchList!
                                                      .results![index]
                                                      .originalTitle !=
                                                  null
                                              ? Text(
                                                  '${context.read<SearchCubit>().searchList!.results![index].originalTitle}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyles
                                                      .font18WhiteBold)
                                              : Text(
                                                  '${context.read<SearchCubit>().searchList!.results![index].originalName}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyles
                                                      .font18WhiteBold,
                                                )),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      context
                                          .read<SearchCubit>()
                                          .searchList!
                                          .results![index]
                                          .overview!,
                                      style: TextStyles.font12LightgreySemiBold,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  verticalSpacing(15),
                                  Text(
                                    '⭐  ${context.read<SearchCubit>().searchList!.results![index].voteAverage!.toStringAsFixed(2)} ',
                                    style: TextStyles.font12WhiteBold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: context.read<SearchCubit>().searchList!.results!.length,
          ),
        );
      },
    );
  }
}
