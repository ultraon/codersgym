import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codersgym/features/profile/domain/model/user_profile.dart';
import 'package:flutter/material.dart';

class BadgeCarousel extends StatelessWidget {
  const BadgeCarousel({super.key, required this.badges});
  final List<LeetCodeBadge> badges;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: false,
        pauseAutoPlayOnTouch: true,
        height: 70,
        viewportFraction: 0.2,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        enlargeFactor: 0.2,
      ),
      items: badges
          .map(
            (e) => CachedNetworkImage(imageUrl: e.icon!),
          )
          .toList(),
    );
  }
}
