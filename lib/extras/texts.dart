import 'package:flutter/material.dart';
import 'package:lcn_firm/extras/colors.dart';

class TextStyles {
  static const TextStyle name = TextStyle(
    fontSize: 14,
    color: TextColors.name,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle location = TextStyle(fontSize: 12, color: TextColors.location);

  static const TextStyle sectionName = TextStyle(fontSize: 20, color: TextColors.section, fontWeight: FontWeight.w400);

  static const TextStyle categoryName = TextStyle(fontSize: 10, color: TextColors.categoryName);

  static const TextStyle btnText = TextStyle(fontSize: 20, color: Colors.white);
}
