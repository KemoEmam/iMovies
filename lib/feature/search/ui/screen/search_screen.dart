import 'package:clean_architecture_app/core/theming/colors.dart';
import 'package:clean_architecture_app/feature/search/data/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/spacing.dart';
import '../../logic/search_cubit.dart';
import '../../logic/search_state.dart';
import '../widget/custom_search_list_view.dart';
import '../widget/custom_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorManger.maindark,
          body: BlocBuilder<SearchCubit, SearchState<SearchModel>>(
            builder: (context, state) {
              return Column(
                children: [
                  verticalSpacing(10),
                  const CustomTextField(
                    title: 'Search',
                    prefixIcon: Icons.search,
                  ),
                  context.read<SearchCubit>().isSearch == false
                      ? Expanded(
                          child: Image.asset(
                            'assets/images/background.jpg',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        )
                      : const CustomSearch(),
                ],
              );
            },
          )),
    );
  }
}
