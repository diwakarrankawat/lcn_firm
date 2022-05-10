import 'package:flutter/material.dart';
import 'package:lcn_firm/extras/colors.dart';
import 'package:lcn_firm/extras/texts.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String icon;
  final Color color;
  const CategoryCard({
    Key? key,
    required this.name,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: WidgetColors.catShadow, offset: Offset(3, 3), blurRadius: 12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.network(icon, fit: BoxFit.contain),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            maxLines: 2,
            style: TextStyles.categoryName,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
