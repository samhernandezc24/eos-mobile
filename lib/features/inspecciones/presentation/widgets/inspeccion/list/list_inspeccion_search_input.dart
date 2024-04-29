import 'package:eos_mobile/shared/shared_libraries.dart';

class ListInspeccionSearchInput extends StatelessWidget {
  const ListInspeccionSearchInput({required this.onSubmit, Key? key}) : super(key: key);

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Center(
        child: Autocomplete<String>(
          displayStringForOption: (data) => data,
          onSelected: onSubmit,
          optionsBuilder: _getSuggestions,
          optionsViewBuilder: (BuildContext context, void Function(String) onSelected, Iterable<String> results) =>
              _buildSuggestionsView(context, onSelected, results, constraints),
          fieldViewBuilder: _buildInput,
        ),
      ),
    );
  }

  Iterable<String> _getSuggestions(TextEditingValue textEditingValue) {
     final List<String> fakeData = <String>[
      'Inspección 1',
      'Inspección 2',
      'Inspección 3',
      'Inspección 4',
      'Inspección 5',
      'Inspección 6',
      'Inspección 7',
      'Inspección 8',
      'Inspección 9',
      'Inspección 10',
      'Inspección 11',
    ];

    if (textEditingValue.text == '') {
      return fakeData.getRange(0, 10);
    }

    return fakeData.where((element) => element.toLowerCase().contains(textEditingValue.text.toLowerCase()));
  }

  Widget _buildSuggestionsView(BuildContext context, void Function(String) onSelected, Iterable<String> results, BoxConstraints constraints) {
    final List<Widget> items = results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList();
    items.insert(0, _buildSuggestionTitle(context));
    return Stack(
      children: <Widget>[
        ExcludeSemantics(
          child: AppBtn.basic(onPressed: FocusManager.instance.primaryFocus!.unfocus, semanticLabel: '', child: const SizedBox.expand()),
        ),
        TopLeft(
          child: Container(
            margin: EdgeInsets.only(top: $styles.insets.xxs),
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              boxShadow: [
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
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.92),
                borderRadius: BorderRadius.circular($styles.insets.xxs),
                border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  padding: EdgeInsets.all($styles.insets.xs),
                  shrinkWrap: true,
                  children: items,
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
          style: $styles.textStyles.title2.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          child: Text(
            $strings.searchInputSuggestionsTitle.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      onPressed: onPressed,
      semanticLabel: suggestion,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: CenterLeft(
          child: DefaultTextStyle(
            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            child: Text(suggestion),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
    return Container(
      height: $styles.insets.xl,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular($styles.insets.xxs),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1.6),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),
          const Icon(Icons.search),
          Expanded(
            child: TextField(
              onSubmitted: onSubmit,
              controller: textController,
              focusNode: focusNode,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all($styles.insets.xs),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                prefixStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: $strings.searchInputHintText,
              ),
            ),
          ),
          Gap($styles.insets.xs),
          ValueListenableBuilder(
            valueListenable: textController,
            builder: (_, value, __) => Visibility(
              visible: textController.value.text.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(right: $styles.insets.xs),
                child: CircleIconButton(
                  backgroundColor: Theme.of(context).disabledColor,
                  color: Colors.white,
                  icon: AppIcons.close,
                  semanticLabel: $strings.searchInputSemanticClear,
                  size: $styles.insets.md,
                  iconSize: $styles.insets.sm,
                  onPressed: () {
                    textController.clear();
                    onSubmit('');
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
