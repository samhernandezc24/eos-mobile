part of '../../../pages/list/list_page.dart';

class _SearchInput extends StatelessWidget {
  const _SearchInput({required this.controller, required this.onSubmit, Key? key}) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder : (ctx, constraints) {
        return Center(
          child: _buildInput(context, controller),
        );
      },
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController controller) {
    return Container(
      height : $styles.insets.xl,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
        border        : Border.all(color: Theme.of(context).colorScheme.primary, width: 1.6),
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
            valueListenable   : controller,
            builder           : (_, value, __) {
              return Visibility(
                visible : controller.value.text.isNotEmpty,
                child   : Padding(
                  padding : EdgeInsets.only(right: $styles.insets.xs),
                  child   : CircleIconButton(
                    backgroundColor : Theme.of(context).disabledColor,
                    color           : Colors.white,
                    icon            : AppIcons.close,
                    semanticLabel   : $strings.searchInputSemanticClear,
                    size            : $styles.insets.md,
                    iconSize        : $styles.insets.sm,
                    onPressed       : () { controller.clear(); onSubmit(''); },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
