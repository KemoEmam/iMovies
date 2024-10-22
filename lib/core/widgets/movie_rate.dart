import 'package:flutter/material.dart';

import '../helper/spacing.dart';
import '../theming/style.dart';

class MovieRate extends StatelessWidget {
  const MovieRate({super.key, required this.rate, required this.review});
  final String rate;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        rate,
        style: TextStyles.font12WhiteSemiBold,
      ),
      horizentalSpacing(15),
      Text(
        review,
        style: TextStyles.font12WhiteSemiBold,
      )
    ]);
  }
}
