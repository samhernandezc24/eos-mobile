part of '../../../../pages/list/list_page.dart';

class _SearchInputUnidadTemporal extends StatefulWidget {
  const _SearchInputUnidadTemporal({
    required this.controller,
    required this.onSelected,
    required this.clearTextFields,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(UnidadPredictiveListEntity) onSelected;
  final VoidCallback clearTextFields;

  @override
  State<_SearchInputUnidadTemporal> createState() => __SearchInputUnidadTemporalState();
}

class __SearchInputUnidadTemporalState extends State<_SearchInputUnidadTemporal> {
  // PROPERTIES
  bool _isBoolSearch = false;

  // LIST
  List<UnidadPredictiveListEntity> lstRows = [];

  // EVENTS
  void _handleSearchSubmitted(String query) {
    lstRows = [];

    if (!Globals.isValidStringValue(widget.controller.text)) {
      return;
    }

    _isBoolSearch = true;

    final List<SearchFilter> lstSearchFilters = [];

    lstSearchFilters.add(const SearchFilter(field: ''));
    lstSearchFilters.add(const SearchFilter(field: ''));
    lstSearchFilters.add(const SearchFilter(field: ''));
    lstSearchFilters.add(const SearchFilter(field: ''));

    final Predictive varArgs = Predictive(
      search          : widget.controller.text,
      searchFilters   : lstSearchFilters,
      filters         : const {},
      columns         : const {},
      // dateFilters     : DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadBloc>(context).add(PredictiveUnidades(varArgs));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        child: Column(
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
                  _buildInput(context, widget.controller),
                  Gap($styles.insets.xs),
                  ValueListenableBuilder(
                    valueListenable : widget.controller,
                    builder         : (_, value, __) => Visibility(
                      visible : widget.controller.value.text.isNotEmpty,
                      child   : Padding(
                        padding : EdgeInsets.only(right: $styles.insets.xs),
                        child   : CircleIconButton(
                          backgroundColor : const Color(0xFF7D7873),
                          color           : Colors.white,
                          icon            : AppIcons.close,
                          iconSize        : $styles.insets.md,
                          onPressed       : () {
                            widget.controller.clear();  // Limpia el campo de texto
                            widget.clearTextFields();   // Limpia los resultados seleccionados
                          },
                          semanticLabel   : $strings.searchInputSemanticClear,
                          size            : $styles.insets.md,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // _buildSuggestionsView(context, (p0) { }, constraints),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsView(
    BuildContext context,
    void Function(UnidadPredictiveListEntity) onSelected,
    Iterable<UnidadPredictiveListEntity> results,
    BoxConstraints constraints,
  ) {
    final List<Widget> lstItems = results.map((item) => _buildSuggestion(context, item, () => onSelected(item))).toList();
    lstItems.insert(0, _buildSuggestionTitle(context));

    return Stack(
      children: <Widget>[
        ExcludeSemantics(child: AppBtn.basic(onPressed: FocusManager.instance.primaryFocus!.unfocus, semanticLabel: '', child: const SizedBox.expand())),
        TopLeft(
          child: Container(
            margin      : EdgeInsets.only(top: $styles.insets.xxs),
            width       : constraints.maxWidth,
            decoration  : BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all($styles.insets.xs),
              decoration: BoxDecoration(
                color         : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.92),
                border        : Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
                borderRadius  : BorderRadius.circular($styles.insets.xs),
              ),
              child: ConstrainedBox(
                constraints : const BoxConstraints(maxHeight: 200),
                child       : ListView(
                  padding     : EdgeInsets.all($styles.insets.xs),
                  shrinkWrap  : true,
                  children    : [],
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
      child       : CenterLeft(
        child: DefaultTextStyle(
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

  Widget _buildSuggestion(BuildContext, UnidadPredictiveListEntity suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      onPressed     : onPressed,
      semanticLabel : suggestion.numeroEconomico,
      child         : Padding(
        padding : EdgeInsets.all($styles.insets.xs),
        child   : CenterLeft(
          child: DefaultTextStyle(
            style : $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            child : Text(
              suggestion.numeroEconomico,
              overflow            : TextOverflow.ellipsis,
              textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController) {
    return Expanded(
      child: TextField(
        onSubmitted       : _handleSearchSubmitted,
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
    );
  }
}
