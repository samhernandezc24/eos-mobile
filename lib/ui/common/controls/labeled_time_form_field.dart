import 'package:eos_mobile/shared/shared_libs.dart';

class LabeledTimeFormField extends StatelessWidget {
  const LabeledTimeFormField({
    required this.controller,
    Key? key,
    this.label,
    this.hintText,
    this.autoFocus        = false,
    this.isEnabled        = true,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool autoFocus;
  final bool isEnabled;
  final FocusNode? focusNode;

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

      controller.text = '$hour:$minute';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color? defaultInputColor = Theme.of(context).inputDecorationTheme.fillColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null && label!.isNotEmpty) ... [
          Text(label ?? '', style: $styles.textStyles.label),
          Gap($styles.insets.xs),
        ],
        Container(
          height: 54,
          decoration: BoxDecoration(
            color         : isEnabled ? defaultInputColor?.withOpacity(0.3) : defaultInputColor,
            border        : Border.all(color: Theme.of(context).primaryColor),
            borderRadius  : BorderRadius.circular($styles.insets.xxs),
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
                      backgroundColor : $styles.colors.caption,
                      color           : $styles.colors.white,
                      icon            : AppIcons.close,
                      onPressed       : () => controller.clear(),
                      semanticLabel   : AppStrings.inputDateTimeSemanticClear,
                      iconSize        : $styles.insets.sm,
                      size            : $styles.insets.md,
                    ),
                  );
                },
              ),

              Expanded(
                child: TextFormField(
                  controller        : controller,
                  style             : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  textAlignVertical : TextAlignVertical.top,
                  decoration        : InputDecoration(
                    isDense         : true,
                    contentPadding  : EdgeInsets.all($styles.insets.xs),
                    fillColor       : isEnabled ? defaultInputColor?.withOpacity(0) : defaultInputColor,
                    labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                    prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText        : hintText ?? '',
                  ),
                  focusNode         : focusNode,
                  readOnly          : true,
                  keyboardType      : TextInputType.text,
                ),
              ),

              Gap($styles.insets.xs),

              IconButton(onPressed: () => _handleSelecTimeOfDayPressed(context), icon: Icon(Icons.schedule, color: Theme.of(context).hintColor), tooltip: 'Seleccionar hora'),
            ],
          ),
        ),

        Gap($styles.insets.xs),

        ValueListenableBuilder(
          valueListenable : controller,
          builder         : (_, value, __) {
            return Visibility(
              visible : FormValidators.dateTimeValidator(controller.text) != null,
              child   : Text(
                FormValidators.timeValidator(controller.text) ?? '',
                style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.error, height: 1.3),
                softWrap  : true,
              ),
            );
          },
        ),
      ],
    );
  }
}
