import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeDashboardData {
  static final List<Notification> notification = [
    Notification(
      'Your english teacher just uploaded a new note on “Letter Writing” ',
      '30 mins ago',
      Assets.book,
    ),
    Notification(
      'A new assignment has been dropped by your Chemistry teacher',
      '2 hours ago',
      Assets.book,
    ),
    Notification(
      'You have a Maths test scheduled for tomorrow by 8:00am',
      '5 hours ago',
      Assets.book,
    ),
    Notification(
      'The Test time-table for 2021/2022 academic session is out. Check your dashboard',
      '10 hours ago',
      Assets.book,
    ),
    Notification(
      'Your Biology teacher just uploaded a new note on “Micro-organisms around us”',
      '1 days ago',
      Assets.mt,
    ),
    Notification(
      'You have a Maths test scheduled for tomorrow by 8:00am',
      '2 days ago',
      Assets.book,
    ),
  ];

  static final List<DashboardNoteModel> dashBoard = [
    DashboardNoteModel(
      title: 'Math',
      subTitle: 'Set Theory',
      bottomtitle: '18th April, 2022 . 09:31am',
      bottomsubTitle: '',
      firstImage: 'assets/subjects/mt.png',
      secondImage: 'assets/new.png',
    ),
    DashboardNoteModel(
      title: 'Biology',
      subTitle: 'Cell Theory',
      bottomtitle: '18th April, 2022 . 09:31am',
      bottomsubTitle: '',
      firstImage: 'assets/subjects/bi.png',
      secondImage: 'assets/new.png',
    ),
    DashboardNoteModel(
      title: 'Further Maths',
      subTitle: 'Differentiation',
      bottomtitle: '18th April, 2022 . 09:31am',
      bottomsubTitle: '',
      firstImage: 'assets/subjects/fm.png',
      secondImage: 'assets/new.png',
    ),
    DashboardNoteModel(
      title: 'Economics',
      subTitle: 'Demand and Supply',
      bottomtitle: '18th April, 2022 . 09:31am',
      bottomsubTitle: 'Expires 19th April, 8:00am',
      firstImage: 'assets/subjects/ec.png',
      secondImage: 'assets/undone.png',
    ),
  ];

  static final List demoMyFiles = [
    CardInfo(
      title: "Economics",
      pngSrc: "assets/ec.png",
      pngSrc2: "assets/undone.png",
      description: "Demand and Supply",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am",
    ),
    CardInfo(
      title: "Biology",
      pngSrc: "assets/bi.png",
      pngSrc2: "assets/undone.png",
      description: "Cell Theory",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am",
    ),
    CardInfo(
      title: "Further Maths",
      pngSrc: "assets/fm.png",
      pngSrc2: "assets/submitted.png",
      description: "Differentiation",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am",
    ),
    CardInfo(
      title: "English",
      pngSrc: "assets/en.png",
      pngSrc2: "assets/expired.png",
      description: "Phrases and Clauses",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am",
    ),
  ];
}
