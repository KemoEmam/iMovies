import 'package:clean_architecture_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../logic/sign_up_cubit.dart';
import '../widget/already_have_account.dart';
import '../widget/sign_up_form.dart';
import '../widget/terms_and_privacy_condition.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.maindark,
      appBar: AppBar(
        backgroundColor: ColorManger.maindark,
        elevation: 0.0,
        leading: Icon(Icons.arrow_back, color: Colors.amber[600]),
        title: Text(
          'Sign Up',
          style: TextStyles.font18WhiteBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.w),
          child: BlocProvider(
            create: (context) => SignUpCubit(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.font24WhiteBold,
                ),
                verticalSpacing(8),
                Text(
                  'Sign up now to explore our amazing collection of movies and TV shows',
                  style: TextStyles.font14whiteRegular,
                ),
                verticalSpacing(30),
                const SignUpForm(),
                verticalSpacing(20),
                const AlreadyHaveAccountText(),
                verticalSpacing(30),
                const TermsAndConditionsText(),
                verticalSpacing(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/google.svg'),
                      SizedBox(
                        width: 32.w,
                      ),
                      const Icon(
                        Icons.facebook,
                        color: ColorManger.mainBlue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      const Icon(
                        Icons.apple,
                        size: 30,
                      ),
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
