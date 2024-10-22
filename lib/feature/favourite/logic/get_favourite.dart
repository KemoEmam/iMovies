import 'package:clean_architecture_app/feature/auth/sign_up/data/user_model.dart';
import 'package:clean_architecture_app/feature/favourite/data/favourite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favourite_state.dart';

class GetFavourite extends Cubit<FavouriteState> {
  GetFavourite() : super(FavouriteInitial());
  UserModel? userModel;
  FavouriteModel? favouriteList;

  void getFavourite() async {
    emit(GetFavouriteLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('favourite')
        .doc(favouriteList!.id)
        .get()
        .then((value) async {
      favouriteList = FavouriteModel.fromJson(value.data()!);
      print(value.data()!);
      emit(GetFavouriteSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(GetFavouriteError(error: e.toString()));
    });
  }
}
