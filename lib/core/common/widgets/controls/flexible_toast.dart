import 'package:eos_mobile/core/enums/flexible_toast_type.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class FlexibleToast extends StatefulWidget {
  const FlexibleToast({required this.message, required this.type, required this.onClose, super.key});

  final String message;
  final FlexibleToastType type;
  final void Function()? onClose;

  @override
  State<FlexibleToast> createState() => _FlexibleToastState();
}

class _FlexibleToastState extends State<FlexibleToast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.sm),
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular($styles.corners.md)),
      ),
      child: Text(widget.message),
    );
  }
}
