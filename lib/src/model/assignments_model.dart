import 'package:nobook/src/core/constants/assets.dart';

class Assignments {
  String image;
  String subject;
  String topic;
  String date;
  String expire;
  String status;
  Assignments(
    this.image,
    this.subject,
    this.topic,
    this.date,
    this.expire,
    this.status
  );
}

final List<Assignments> assignments = [
  Assignments(Assets.mt, 'Economics', 'Demand and Supply',
      '18th April, 2022, 09:31am', 'Expires 19th April, 8:00am', 'Submitted'),
  Assignments(Assets.mt, 'Economics', 'Demand and Supply',
      '18th April, 2022, 09:31am', 'Expires 19th April, 8:00am','Undone'),
  Assignments(Assets.mt, 'Economics', 'Demand and Supply',
      '18th April, 2022, 09:31am', 'Expires 19th April, 8:00am','Submitted'),
  Assignments(Assets.mt, 'Economics', 'Demand and Supply',
      '18th April, 2022, 09:31am', 'Expires 19th April, 8:00am','Submitted'),
];
