import 'package:flutter/material.dart';

class OptionModel {
  String name;
  String imagePath;
  Color boxColor;
  final VoidCallback action;

  OptionModel({
    required this.name,
    required this.imagePath,
    required this.boxColor,
    required this.action,
  });
}
