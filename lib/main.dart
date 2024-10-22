import 'package:clean_architecture_app/core/helper/shared_prefrences.dart';
import 'package:clean_architecture_app/movies_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/helper/bloc_observation.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await MySharedPreferences.init();

  setupGetit();
  runApp(
    MoviesApp(
      appRouter: AppRouter(),
    ),
  );
}
