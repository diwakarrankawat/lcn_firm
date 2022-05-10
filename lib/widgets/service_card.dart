import 'package:flutter/material.dart';
import 'package:lcn_firm/extras/colors.dart';
import 'package:lcn_firm/extras/texts.dart';
import 'package:lcn_firm/widgets/rating_stars.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String thumbnail;
  final String location;
  final String distance;
  final double rating;
  final bool isThumbnailAsset;
  const ServiceCard({
    Key? key,
    required this.name,
    required this.thumbnail,
    required this.location,
    required this.distance,
    required this.rating,
    this.isThumbnailAsset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 207,
      height: 175,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: WidgetColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black26,
              image: DecorationImage(
                image: AssetImage(thumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: TextStyles.name),
          Text(location, style: TextStyles.location),
          Row(
            children: [
              Rating(rating: rating),
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.location_on_outlined,
                color: TextColors.location,
                size: 16,
              ),
              Text(distance, style: TextStyles.location),
            ],
          ),
        ],
      ),
    );
  }
}
