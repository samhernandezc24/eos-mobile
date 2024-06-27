part of '../../../../pages/list/list_page.dart';

class _SearchUnidadInput extends StatelessWidget {
  const _SearchUnidadInput({
    required this.lstRows,
    required this.onSubmit,
    required this.onSelected,
    required this.onClearField,
    required this.boolError,
    Key? key,
    this.boolSearch,
    this.errorMessage,
  }) : super(key: key);

  final Iterable<UnidadPredictiveListEntity> lstRows;
  final void Function(UnidadPredictiveListEntity) onSelected;
  final void Function(String) onSubmit;
  final VoidCallback onClearField;
  final bool? boolSearch;
  final bool boolError;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        child: PredictiveSearchField<UnidadPredictiveListEntity>(
          displayStringForOption  : (data) => data.numeroEconomico,
          onSelected              : onSelected,
          optionsViewBuilder      : (context, onSelected, results) =>
              _buildSuggestionsView(context, onSelected, lstRows, constraints),
          fieldViewBuilder        : _buildInput,
          lstRows                 : lstRows,
          boolError               : boolError,
        ),
      ),
    );
  }

  Widget _buildSuggestionsView(BuildContext context, void Function(UnidadPredictiveListEntity) onSelected, Iterable<UnidadPredictiveListEntity> results, BoxConstraints constraints) {
    final List<Widget> items = results.map((item) => _buildSuggestion(context, item, () => onSelected(item))).toList();
    items.insert(0, _buildSuggestionTitle(context));
    return Stack(
      children: <Widget>[
        ExcludeSemantics(
          child: AppBtn.basic(
            onPressed     : FocusManager.instance.primaryFocus!.unfocus,
            semanticLabel : '',
            child         : const SizedBox.expand(),
          ),
        ),
        TopLeft(
          child: Container(
            margin: EdgeInsets.only(top: $styles.insets.xxs),
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color       : Colors.black.withOpacity(0.25),
                  blurRadius  : 4,
                  offset      : const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all($styles.insets.xs),
              decoration: BoxDecoration(
                color         : Theme.of(context).colorScheme.surface.withOpacity(0.92),
                border        : Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                borderRadius  : BorderRadius.circular($styles.insets.xs),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  padding     : EdgeInsets.all($styles.insets.xs),
                  shrinkWrap  : true,
                  children    : items,
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
      padding: EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
      margin: EdgeInsets.only(bottom: $styles.insets.xxs),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)))),
      child: CenterLeft(
        child: DefaultTextStyle(
          style: $styles.textStyles.title2.copyWith(color: Theme.of(context).colorScheme.onSurface),
          child: Text(
            $strings.searchInputResultsTitle.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, UnidadPredictiveListEntity suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      onPressed: onPressed,
      semanticLabel: suggestion.numeroEconomico,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: CenterLeft(
          child: DefaultTextStyle(
            style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface),
            child: Text(
              suggestion.numeroEconomico,
              overflow: TextOverflow.ellipsis,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
    return Column(
      children: <Widget>[
        Container(
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
                  controller        : textController,
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
                valueListenable : textController,
                builder         : (_, value, __) => Visibility(
                  visible : textController.value.text.isNotEmpty,
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
                        textController.clear();   // Limpia el campo de búsqueda
                        onSubmit('');             // Limpia la consulta
                        onClearField();           // Limpia los elementos de control
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (boolSearch ?? false) const AppLinearIndicator(),
      ],
    );
  }
}
