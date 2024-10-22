import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomMovieBanner extends StatelessWidget {
  const CustomMovieBanner({super.key, required this.bannerImgae});

  final String bannerImgae;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: double.maxFinite,
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 35, 35, 35),
              const Color.fromARGB(255, 56, 51, 51).withOpacity(0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.04, 0.25],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  bannerImgae,
                ))));
  }
}
