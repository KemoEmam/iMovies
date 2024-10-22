import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/get_start_button.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formkey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            controller: nameController,
          ),
          verticalSpacing(18),
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
          verticalSpacing(18),
          AppTextFormField(
            controller: confirmPasswordController,
            hintText: 'Confirmation Password',
            isObscureText: isConfirmPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isConfirmPasswordObscureText = !isConfirmPasswordObscureText;
                });
              },
              child: Icon(
                isConfirmPasswordObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          verticalSpacing(40),
          BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
            if (state is SignUpSuccess) {
              Fluttertoast.showToast(
                  msg: 'Sign Up Success',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: const Color.fromARGB(255, 14, 85, 1),
                  textColor: Colors.white,
                  fontSize: 16.0);
              context.pushNamed(Routes.loginScreen);
            }
            if (state is SignUpError) {
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
            if (state is SignUpLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Align(
              alignment: Alignment.center,
              child: GetStartedButton(
                  onPressed: () {
                    if (context
                        .read<SignUpCubit>()
                        .formkey
                        .currentState!
                        .validate()) {
                      context.read<SignUpCubit>().createAccount(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text);
                    }
                  },
                  text: 'Sign Up'),
            );
          }),
        ],
      ),
    );
  }
}
