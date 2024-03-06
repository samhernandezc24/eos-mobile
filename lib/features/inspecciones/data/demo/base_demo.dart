import 'package:eos_mobile/shared/shared.dart';

class BaseData extends Equatable {
  const BaseData({
    required this.idBase,
    required this.name,
  });

  factory BaseData.defaultBaseData() {
    return const BaseData(idBase: 'dd6ccebe-beb6-46a3-b1a6-5e97cda296f7', name: 'VILLAHERMOSA');
  }

  final String idBase;
  final String name;

  @override
  List<Object?> get props => [idBase, name];
}
