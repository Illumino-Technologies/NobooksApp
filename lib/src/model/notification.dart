
import 'package:nobook/src/core/constants/assets.dart';

class Notification {
  final String title;
  final String time;
  final String logo;

  Notification(this.title, this.time, this.logo);
}

final List<Notification> notification = [
  Notification('Your english teacher just uploaded a new note on “Letter Writing” ', '30 mins ago', Assets.book),
  Notification('A new assignment has been dropped by your Chemistry teacher', '2 hours ago', Assets.book),
  Notification('You have a Maths test scheduled for tomorrow by 8:00am', '5 hours ago', Assets.book),
  Notification('The Test time-table for 2021/2022 academic session is out. Check your dashboard', '10 hours ago', Assets.book),
  Notification('Your Biology teacher just uploaded a new note on “Micro-organisms around us”', '1 days ago', Assets.mt),
  Notification('You have a Maths test scheduled for tomorrow by 8:00am', '2 days ago', Assets.book),
];

