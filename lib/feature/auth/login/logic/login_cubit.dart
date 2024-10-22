import 'package:clean_architecture_app/feature/auth/login/logic/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formkey = GlobalKey<FormState>();

  void loginAccount({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccess(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginError(error: error.toString()));
    });
  }
}
