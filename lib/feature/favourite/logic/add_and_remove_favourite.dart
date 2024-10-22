import 'package:clean_architecture_app/feature/auth/sign_up/data/user_model.dart';
import 'package:clean_architecture_app/feature/favourite/data/favourite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  UserModel? userModel;

  void addFavourite(
      {required String id,
      required String title,
      required String decription,
      required String image,
      required String overview})async {
    emit(AddFavouriteLoading());
    FavouriteModel favouriteModel = FavouriteModel(
      id: id,
      title: title,
      decription: decription,
      image: image,
      overview: overview,
    );
   await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('favourite')
        .doc(id)
        .collection('favData')
        .add(favouriteModel.toJson())
        .then((value) {
      emit(AddFavouriteSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(AddFavouriteError(error: e.toString()));
    });
  }

  void removeFavourite({required String id})async {
    emit(RemoveFavouriteLoading());
   await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('favourite')
        .doc(id)
        .delete()
        .then((value) {
      emit(RemoveFavouriteSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(RemoveFavouriteError(error: e.toString()));
    });
  }
}
