import 'package:eos_mobile/shared/shared_libraries.dart';

class DateTextFormField extends StatelessWidget {
  const DateTextFormField({
    required this.controller,
    Key? key,
    this.hintText,
    this.focusNode,
    this.onPickDatePressed,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
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
      final day   = pickedDate.day.toString().padLeft(2, '0');
      final month = pickedDate.month.toString().padLeft(2, '0');
      controller.text = '$day/$month/${pickedDate.year}';
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
                  semanticLabel   : 'Borrar fecha',
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
              readOnly          : true,
              keyboardType      : TextInputType.text,
              textAlignVertical : TextAlignVertical.top,
            ),
          ),

          Gap($styles.insets.xs),

          IconButton(onPressed: () => _handleSelectDatePressed(context), icon: Icon(Icons.calendar_month, color: Theme.of(context).hintColor), tooltip: 'Seleccionar fecha'),
        ],
      ),
    );
  }
}
