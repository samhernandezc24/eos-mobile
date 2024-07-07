import 'package:eos_mobile/shared/shared_libs.dart';

class SearchInputFormField extends StatelessWidget {
  const SearchInputFormField({
    required this.controller,
    required this.onSubmit,
    Key? key,
    this.onSearchFiltersPressed,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String) onSubmit;
  final void Function()? onSearchFiltersPressed;

  // EVENTS
  void _handleSearchFiltersPressed() {
    if (onSearchFiltersPressed != null) {
      return onSearchFiltersPressed!();
    }
  }

  void _handleClearPressed() {
    controller.clear();
    onSubmit('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3),
        border        : Border.all(color: Theme.of(context).primaryColor, width: 1.3),
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),

          IconButton(
            onPressed     : _handleSearchFiltersPressed,
            visualDensity : VisualDensity.compact,
            icon          : const Icon(Icons.search),
            tooltip       : AppStrings.searchFiltersTooltip,
          ),

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
                fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0),
                labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                hintText        : AppStrings.searchInputHintText,
              ),
            ),
          ),

          Gap($styles.insets.xs),

          ValueListenableBuilder(
            valueListenable : controller,
            builder         : (_, value, __) {
              return Visibility(
                visible : controller.value.text.isNotEmpty,
                child   : Padding(
                  padding: EdgeInsets.only(right: $styles.insets.xs),
                  child: CircleIconButton(
                    backgroundColor   : $styles.colors.caption,
                    color             : $styles.colors.white,
                    icon              : AppIcons.close,
                    onPressed         : _handleClearPressed,
                    semanticLabel     : AppStrings.searchInputSemanticClear,
                    iconSize          : $styles.insets.sm,
                    size              : $styles.insets.md,
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
