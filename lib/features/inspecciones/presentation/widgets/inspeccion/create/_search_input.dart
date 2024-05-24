part of '../../../pages/list/list_page.dart';

class _SearchInputUnidad extends StatelessWidget {
  const _SearchInputUnidad({required this.onSelected, required this.unidades, Key? key}) : super(key: key);

  final void Function(UnidadEntity) onSelected;
  final List<UnidadEntity> unidades;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Center(
          child: Autocomplete<UnidadEntity>(
            displayStringForOption  : (option) => option.numeroEconomico,
            optionsBuilder          : _getSuggestions,
            onSelected              : onSelected,
            optionsViewBuilder      : (context, onSelected, results) => _buildSuggestionsView(context, onSelected, results, constraints),
            fieldViewBuilder        : _buildInput,
          ),
        );
      },
    );
  }

  Iterable<UnidadEntity> _getSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return unidades.take(10);
    }

    return unidades.where((UnidadEntity option) {
      return option.numeroEconomico.toLowerCase().contains(textEditingValue.text.toLowerCase());
    });
  }

  Widget _buildSuggestionsView(BuildContext context, void Function(UnidadEntity) onSelected, Iterable<UnidadEntity> results, BoxConstraints constraints) {
    final List<Widget> lstItems = results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList();
    lstItems.insert(0, _buildSuggestionTitle(context));

    return Stack(
      children: <Widget>[
        ExcludeSemantics(
          child: AppBtn.basic(onPressed: FocusManager.instance.primaryFocus!.unfocus, semanticLabel: '', child: const SizedBox.expand()),
        ),

        TopLeft(
          child: Container(
            margin  : EdgeInsets.only(top: $styles.insets.xxs),
            width   : constraints.maxWidth,
            decoration  : BoxDecoration(
              boxShadow : <BoxShadow>[
                BoxShadow(
                  color       : Colors.black.withOpacity(0.25),
                  blurRadius  : 4,
                  offset      : const Offset(0, 4),
                ),
              ],
            ),
            child : Container(
              padding     : EdgeInsets.all($styles.insets.xs),
              decoration  : BoxDecoration(
                color         : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.92),
                border        : Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
                borderRadius  : BorderRadius.circular($styles.insets.xs),
              ),
              child : ConstrainedBox(
                constraints : const BoxConstraints(maxHeight: 200),
                child       : ListView(
                  padding     : EdgeInsets.all($styles.insets.xs),
                  shrinkWrap  : true,
                  children    : lstItems,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionTitle(BuildContext context) {
    return Container(
      padding     : EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
      margin      : EdgeInsets.only(bottom: $styles.insets.xxs),
      decoration  : BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)))),
      child : CenterLeft(
        child : DefaultTextStyle(
          style : $styles.textStyles.title2.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          child : Text(
            $strings.searchInputSuggestionsTitle.toUpperCase(),
            overflow            : TextOverflow.ellipsis,
            textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, UnidadEntity suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      onPressed     : onPressed,
      semanticLabel : suggestion.value,
      child         : Padding(
        padding : EdgeInsets.all($styles.insets.xs),
        child   : CenterLeft(
          child : DefaultTextStyle(
            style : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            child : Text(
              suggestion.value,
              overflow            : TextOverflow.ellipsis,
              textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController controller, FocusNode focusNode, _) {
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

          const Icon(Icons.search),

          Expanded(
            child: TextField(
              controller        : controller,
              focusNode         : focusNode,
              style             : TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlignVertical : TextAlignVertical.top,
              decoration        : InputDecoration(
                isDense         : true,
                contentPadding  : EdgeInsets.all($styles.insets.xs),
                labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                hintText        : $strings.unidadSearchInputHintText,
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
                    // onPressed       : () { controller.clear(); onSubmit(''); },
                    onPressed       : () { controller.clear(); },
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
