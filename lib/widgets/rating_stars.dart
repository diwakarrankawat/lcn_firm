import 'package:flutter/material.dart';
import 'package:lcn_firm/extras/colors.dart';

class Rating extends StatelessWidget {
  final double rating;
  const Rating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        rating.toInt() + ((rating - rating.toInt()) > 0 ? 1 : 0),
        (index) => Icon(
          rating.toInt() < (index + 1) ? Icons.star_half : Icons.star,
          color: WidgetColors.startRating,
          size: 14,
        ),
      ),
    );
  }
}
