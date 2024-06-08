part of '../../../pages/list/list_page.dart';

/// Campo de texto para buscar inspecciones.
class _SearchInputInspeccion extends StatelessWidget {
  const _SearchInputInspeccion({
    required this.controller,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onSubmit;

  // EVENTS
  void _handleClearTextPressed() {
    controller.clear();
    onSubmit('');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        child: Container(
          height: $styles.insets.xl,
          decoration: BoxDecoration(
            color         : Theme.of(context).inputDecorationTheme.fillColor,
            border        : Border.all(color: Theme.of(context).primaryColor, width: 1.6),
            borderRadius  : BorderRadius.circular($styles.insets.xxs),
          ),
          child: Row(
            children: <Widget>[
              Gap($styles.insets.xs * 1.5),
              GestureDetector(
                onTap: (){},
                child: const Icon(Icons.search),
              ),
              _buildInput(context, controller),
              Gap($styles.insets.xs),
              ValueListenableBuilder(
                valueListenable : controller,
                builder         : (_, value, __) => Visibility(
                  visible : controller.value.text.isNotEmpty,
                  child   : Padding(
                    padding : EdgeInsets.only(right: $styles.insets.xs),
                    child   : CircleIconButton(
                      backgroundColor : const Color(0xFF7D7873),
                      color           : Colors.white,
                      icon          : AppIcons.close,
                      onPressed     : _handleClearTextPressed,
                      semanticLabel : $strings.searchInputSemanticClear,
                      size          : $styles.insets.md,
                      iconSize      : $styles.insets.sm,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController) {
    return Expanded(
      child: TextField(
        onSubmitted       : onSubmit,
        controller        : textController,
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
    );
  }
}
