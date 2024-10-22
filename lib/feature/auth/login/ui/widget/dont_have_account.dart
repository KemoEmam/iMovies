import 'package:clean_architecture_app/core/helper/extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/style.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account ?',
              style: TextStyles.font12WhiteBold,
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyles.font14SemiAmberBold,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamed(Routes.signUpScreen);
                },
            ),
          ],
        ),
      ),
    );
  }
}
