import 'package:eos_mobile/core/constants/constants.dart';
import 'package:eos_mobile/shared/shared.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.onPressed,
    required this.child,
    required this.semanticLabel,    
    super.key,
    this.borderSide,
    this.backgroundColor,
    this.size,
  });

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget child;
  final double? size;
  final String semanticLabel;
  
  @override
  Widget build(BuildContext context) {
    final double sz = size ?? Constants.kDefaultSize;
    return CircleAvatar();
  }
}
