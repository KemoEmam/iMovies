import 'package:clean_architecture_app/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/user_model.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final formkey = GlobalKey<FormState>();

  void createAccount({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    print('kkkkk');
    emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          email: email, name: name, password: password, uId: value.user!.uid);
      emit(SignUpSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(SignUpError(error: e.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String password,
    required String uId,
  }) {
    UserModel model = UserModel(
      email: email,
      password: password,
      name: name,
      uId: uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CretaeUserSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(CretaeUserFaluire(error: e.toString()));
    });
  }
}
