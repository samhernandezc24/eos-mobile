class SearchData {
  const SearchData(
    this.year,
    this.id,
    this.title,
    this.keywords, [
    this.aspectRatio = 0,
  ]);

  final int year;
  final String id;
  final String keywords;
  final String title;
  final double aspectRatio;

  String write() => "SearchData($year, $id, '$title', '$keywords')";
}
