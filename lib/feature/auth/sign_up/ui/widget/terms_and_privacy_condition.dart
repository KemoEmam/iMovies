import 'package:flutter/material.dart';

import '../../../../../core/theming/style.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our',
            style: TextStyles.font13WhiteRegular,
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: TextStyles.font14AmberMedium,
          ),
          TextSpan(
            text: ' and',
            style: TextStyles.font13WhiteRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: TextStyles.font14AmberMedium,
          ),
        ],
      ),
    );
  }
}
