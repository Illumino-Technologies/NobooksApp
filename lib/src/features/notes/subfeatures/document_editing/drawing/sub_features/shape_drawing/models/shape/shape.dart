import 'package:flutter/material.dart';

enum Shape {
  rectangle(Icons.rectangle_outlined),
  circle(Icons.circle_outlined),
  triangle(Icons.change_history),
  star(Icons.star_border);

  final IconData iconData;

  const Shape(this.iconData);
}
