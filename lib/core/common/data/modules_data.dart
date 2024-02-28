import 'package:eos_mobile/shared/shared.dart';

@immutable
class ModulesData {
  const ModulesData(
    this.name,
    this.icon,
  );

  final String name;
  final Icon icon;
}
