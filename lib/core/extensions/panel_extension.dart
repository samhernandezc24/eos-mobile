import 'package:eos_mobile/shared/shared_libraries.dart';

class PanelController extends ValueNotifier<bool> {
  PanelController(super.value);
  void toggle() => value = !value;
}
