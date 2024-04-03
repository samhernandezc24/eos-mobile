import 'package:eos_mobile/shared/shared.dart';

@immutable
class ModuleData {
  const ModuleData(this.name, this.icon);
  final String name;
  final IconData icon;
}
