import 'package:eos_mobile/shared/shared_libraries.dart';

@immutable
class WelcomeData {
  const WelcomeData(this.title, this.content, this.image);

  final String title;
  final String content;
  final String image;
}
