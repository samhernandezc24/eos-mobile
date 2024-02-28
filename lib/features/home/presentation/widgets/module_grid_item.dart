import 'package:eos_mobile/core/common/widgets/card_view.dart';
import 'package:eos_mobile/shared/shared.dart';

class ModuleGridItem extends StatelessWidget {
  const ModuleGridItem({
    required this.moduleTitle,
    required this.moduleIcon,
    required this.onTap,
    this.moduleColor,
    Key? key,
  }) : super(key: key);

  final String moduleTitle;
  final Icon moduleIcon;
  final Color? moduleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CardViewIcon(
        icon: moduleIcon,
        color: moduleColor ?? Theme.of(context).cardColor,
        title: moduleTitle,
      ),
    );
  }
}
