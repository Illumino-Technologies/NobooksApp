class DashboardNoteModel {
  final String title;
  final String subTitle;
  final String bottomtitle;
  final String bottomsubTitle;
  final String firstImage;
  final String secondImage;

  DashboardNoteModel({
    required this.title,
    required this.subTitle,
    required this.bottomtitle,
    required this.bottomsubTitle,
    required this.firstImage,
    required this.secondImage,
  });
}

List<DashboardNoteModel> dashBoard = [
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
