import 'package:clean_architecture_app/feature/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Tv/tv_screen/screen/tv_screen.dart';
import '../../movies/movies_screen.dart';
import '../../search/ui/screen/search_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentIndex = 0;
  List<Widget> screen = [
    const MoviesScreen(),
    const TvScreen(),
    const SearchScreen(),
    const Column(children: [
      Text('Profile'),
    ]),
  ];
  void changeBottomState(int index) {
    currentIndex = index;
    emit(BottomNavSuccess());
  }
}
