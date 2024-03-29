import 'package:eos_mobile/shared/shared.dart';

@immutable
class PageData {
  const PageData(
    this.title,
    this.content,
    this.image,
  );

  final String title;
  final String content;
  final String image;
}
