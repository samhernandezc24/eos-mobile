import 'package:eos_mobile/shared/shared_libraries.dart';

extension SizedContext on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  Size get sizePx => mq.size;
}
