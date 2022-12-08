import 'package:flutter/rendering.dart';

class Holiday {
  Holiday(
    this.Name,
    this.from,
    this.to,
    this.background,
    this.isDay,
  );
  String Name;
  DateTime from;
  DateTime to;
  Color background;
  bool isDay;
}
