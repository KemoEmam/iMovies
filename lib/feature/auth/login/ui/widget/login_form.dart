import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:clean_architecture_app/core/routing/routes.dart';
import 'package:clean_architecture_app/feature/auth/login/logic/login_cubit.dart';
import 'package:clean_architecture_app/feature/auth/login/logic/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/get_start_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formkey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Email',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            controller: emailController,
          ),
          verticalSpacing(18),
          AppTextFormField(
            controller: passwordController,
            hintText: 'Password',
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpacing(30.h),
          BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
            if (state is LoginSuccess) {
              Fluttertoast.showToast(
                  msg: 'Login Success',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: const Color.fromARGB(255, 14, 85, 1),
                  textColor: Colors.white,
                  fontSize: 16.0);
              context.pushNamed(Routes.homeScreen);
            }
            if (state is LoginError) {
              Fluttertoast.showToast(
                  msg: 'Server Error',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: const Color.fromARGB(255, 85, 1, 1),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }, builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Align(
              alignment: Alignment.center,
              child: GetStartedButton(
                  onPressed: () {
                    if (context
                        .read<LoginCubit>()
                        .formkey
                        .currentState!
                        .validate()) {
                      context.read<LoginCubit>().loginAccount(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                  text: 'Login'),
            );
          }),
        ],
      ),
    );
  }
}
