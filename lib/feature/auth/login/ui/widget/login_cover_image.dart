import 'package:flutter/material.dart';

class LoginCoverImage extends StatelessWidget {
  const LoginCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 35, 35, 35),
            const Color.fromARGB(255, 56, 51, 51).withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.04, 0.2],
        ),
      ),
      child: Image.asset(
        'assets/images/login_background.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
