import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledDateTimeTextFormField extends StatelessWidget {
  const LabeledDateTimeTextFormField({
    required this.controller,
    required this.label,
    Key? key,
    this.hintText,
    this.textInputAction  = TextInputAction.next,
    this.autoFocus        = false,
    this.focusNode,
    this.onPickDatePressed,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final VoidCallback? onPickDatePressed;
  final FocusNode? focusNode;

    Future<DateTime?> _handleSelectDatePressed(BuildContext context) async {
    final DateTime currentDate = DateTime.now();

    // Mostrar el selector de fecha.
    final DateTime? pickedDate = await showDatePicker(
      context     : context,
      initialDate : currentDate,
      firstDate   : DateTime(2000),
      lastDate    : DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        final String day     = pickedDate.day.toString().padLeft(2, '0');
        final String month   = pickedDate.month.toString().padLeft(2, '0');
        final String hour    = pickedTime.hour.toString().padLeft(2, '0');
        final String minute  = pickedTime.minute.toString().padLeft(2, '0');

        controller.text = '$day/$month/${pickedDate.year} $hour:$minute';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),

        Gap($styles.insets.xs),

        Container(
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
                      backgroundColor : const Color(0xFF7D7873),
                      color           : Colors.white,
                      icon            : AppIcons.close,
                      onPressed       : () { controller.clear(); },
                      semanticLabel   : 'Borrar fecha',
                      size            : $styles.insets.md,
                      iconSize        : $styles.insets.sm,
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
                  readOnly          : true,
                  keyboardType      : TextInputType.text,
                  textAlignVertical : TextAlignVertical.top,
                  textInputAction   : textInputAction,
                ),
              ),

              Gap($styles.insets.xs),

              IconButton(onPressed: () => _handleSelectDatePressed(context), icon: Icon(Icons.calendar_month, color: Theme.of(context).hintColor), tooltip: 'Seleccionar fecha'),
            ],
          ),
        ),

        Gap($styles.insets.xs),

        ValueListenableBuilder(
          valueListenable : controller,
          builder         : (_, value, __) {
            return Visibility(
              visible : FormValidators.dateTimeTextValidator(controller.text) != null,
              child   : Text(
                '* ${FormValidators.dateTimeTextValidator(controller.text) ?? ''}',
                style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.error),
                softWrap  : true,
              ),
            );
          },
        ),
      ],
    );
  }
}
