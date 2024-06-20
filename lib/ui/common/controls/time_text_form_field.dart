import 'package:eos_mobile/shared/shared_libraries.dart';

class TimeTextFormField extends StatelessWidget {
  const TimeTextFormField({
    required this.controller,
    required this.onChanged,
    Key? key,
    this.hintText,
    this.focusNode,
    this.onPickTimePressed,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final VoidCallback? onPickTimePressed;
  final FocusNode? focusNode;
  final void Function(String) onChanged;

  Future<TimeOfDay?> _handleSelecTimeOfDayPressed(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();

    // Mostrar el selector de hora.
    final TimeOfDay? pickedTime = await showTimePicker(
      context     : context,
      initialTime : currentTime,
    );

    if (pickedTime != null) {
      final hour   = pickedTime.hour.toString().padLeft(2, '0');
      final minute = pickedTime.minute.toString().padLeft(2, '0');
      final formattedTime = '$hour:$minute';

      controller.text = formattedTime;

      onChanged(formattedTime);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
        border        : Border.all(color: Theme.of(context).colorScheme.primary, width: 1.6),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),

          ValueListenableBuilder(
            valueListenable : controller,
            builder         : (_, value, __) {
              return Padding(
                padding : EdgeInsets.only(left: $styles.insets.xxs, right: $styles.insets.sm),
                child   : CircleIconButton(
                  backgroundColor : Theme.of(context).disabledColor,
                  color           : Colors.white,
                  icon            : AppIcons.close,
                  iconSize        : $styles.insets.sm,
                  onPressed       : () { controller.clear(); },
                  semanticLabel   : 'Borrar tiempo',
                  size            : $styles.insets.md,
                ),
              );
            },
          ),

          Expanded(
            child: TextFormField(
              controller        : controller,
              decoration        : InputDecoration(
                isDense         : true,
                contentPadding  : EdgeInsets.all($styles.insets.xs),
                hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                hintText        : hintText ?? '',
              ),
              focusNode         : focusNode,
              onChanged         : onChanged,
              readOnly          : true,
              keyboardType      : TextInputType.text,
              textAlignVertical : TextAlignVertical.top,
            ),
          ),

          Gap($styles.insets.xs),

          IconButton(onPressed: () => _handleSelecTimeOfDayPressed(context), icon: Icon(Icons.schedule, color: Theme.of(context).hintColor), tooltip: 'Seleccionar tiempo'),
        ],
      ),
    );
  }
}
