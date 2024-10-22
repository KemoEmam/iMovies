import 'package:clean_architecture_app/core/helper/spacing.dart';
import 'package:clean_architecture_app/core/theming/colors.dart';
import 'package:clean_architecture_app/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/login_cubit.dart';
import '../widget/dont_have_account.dart';
import '../widget/login_cover_image.dart';
import '../widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: Column(
              children: [
                const LoginCoverImage(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyles.font22WhiteBold,
                      ),
                      verticalSpacing(15.h),
                      const LoginForm(),
                      verticalSpacing(15.h),
                      const DontHaveAccount(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
