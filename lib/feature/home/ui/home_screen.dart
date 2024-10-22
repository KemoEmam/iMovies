import 'package:clean_architecture_app/feature/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theming/colors.dart';
import '../logic/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return Scaffold(
            body: context
                .read<HomeCubit>()
                .screen[context.read<HomeCubit>().currentIndex],
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: ColorManger.lightgray,
                  height: 1,
                  width: double.infinity,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: ColorManger.maindark,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: ColorManger.gray,
                    currentIndex: context.read<HomeCubit>().currentIndex,
                    showUnselectedLabels: true,
                    onTap: (index) {
                      context.read<HomeCubit>().changeBottomState(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.local_movies),
                        label: 'Movies',
                      ),
                      BottomNavigationBarItem(
                        label: 'TV',
                        icon: Icon(Icons.tv),
                      ),
                      BottomNavigationBarItem(
                        label: 'Search',
                        icon: Icon(Icons.search),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
