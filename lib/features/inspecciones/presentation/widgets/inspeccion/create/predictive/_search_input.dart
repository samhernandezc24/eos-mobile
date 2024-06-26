part of '../../../../pages/list/list_page.dart';

class _SearchUnidadInput extends StatelessWidget {
  const _SearchUnidadInput({
    required this.controller,
    required this.onSubmit,
    required this.onClearField,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onSubmit;
  final VoidCallback onClearField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3),
        border        : Border.all(color: Theme.of(context).primaryColor),
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),
          const Icon(Icons.search),
          Expanded(
            child: TextField(
              onSubmitted       : onSubmit,
              controller        : controller,
              style             : TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlignVertical : TextAlignVertical.top,
              textInputAction   : TextInputAction.search,
              decoration        : InputDecoration(
                isDense         : true,
                fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0),
                filled          : true,
                contentPadding  : EdgeInsets.all($styles.insets.xs),
                labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                hintText        : $strings.searchInputHintText,
              ),
            ),
          ),
          Gap($styles.insets.xs),
          ValueListenableBuilder(
            valueListenable : controller,
            builder         : (_, value, __) => Visibility(
              visible : controller.value.text.isNotEmpty,
              child   : Padding(
                padding: EdgeInsets.only(right: $styles.insets.xs),
                child: CircleIconButton(
                  backgroundColor : const Color(0xFF7D7873),
                  color           : Colors.white,
                  icon            : AppIcons.close,
                  iconSize        : $styles.insets.sm,
                  semanticLabel   : $strings.searchInputSemanticClear,
                  size            : $styles.insets.md,
                  onPressed       : () {
                    controller.clear();   // Limpia el campo de búsqueda
                    onSubmit('');         // Limpia la consulta
                    onClearField();       // Limpia los elementos de control
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
