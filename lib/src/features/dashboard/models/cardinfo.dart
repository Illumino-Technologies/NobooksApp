class CardInfo {
  final String? pngSrc, pngSrc2, title, description, datetime, dateTime2;

  CardInfo({
    this.pngSrc,
    this.pngSrc2,
    this.title,
    this.description,
    this.datetime,
    this.dateTime2,
  });
}

List demoMyFiles = [
  CardInfo(
      title: "Economics",
      pngSrc: "assets/ec.png",
      pngSrc2: "assets/undone.png",
      description: "Demand and Supply",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am"),
  CardInfo(
      title: "Biology",
      pngSrc: "assets/bi.png",
      pngSrc2: "assets/undone.png",
      description: "Cell Theory",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am"),
  CardInfo(
      title: "Further Maths",
      pngSrc: "assets/fm.png",
      pngSrc2: "assets/submitted.png",
      description: "Differentiation",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am"),
  CardInfo(
      title: "English",
      pngSrc: "assets/en.png",
      pngSrc2: "assets/expired.png",
      description: "Phrases and Clauses",
      datetime: "18th April, 2022 . 09:31am",
      dateTime2: "Expires 19th April, 8:00am"),
];
