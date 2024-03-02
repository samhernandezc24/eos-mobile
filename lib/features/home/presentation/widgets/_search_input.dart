import 'package:eos_mobile/shared/shared.dart';

class _SearchInput extends StatelessWidget {
  const _SearchInput({super.key});

  final void Function(String) onSubmit;
  final InspeccionesData inspecciones;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        child: Autocomplete<String>(
          displayStringForOption: (data) => data,
          onSelected: onSubmit,
          optionsBuilder: _getSuggestions,
          optionsViewBuilder: (context, onSelected, results) =>
              _buildSuggestionsView(context, onSelected, results, constraints),
          fieldViewBuilder: _buildInput,
        ),
      ),
    );
  }

  Iterable<String> _getSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return inspecciones.searchSuggestions.getRange(0, 10);
    }

    return inspecciones.searchSuggestions.where((str) {
      return str.startsWith(textEditingValue.text.toLowerCase());
    }).toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  Widget _buildSuggestionsView(BuildContext context, onSelected, Iterable<String> results, BoxConstraints constraints) {
    List<Widget> items = results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList();
    items.insert(0, _buildSuggestionTitle(conttext));
    return Stack(
      children: [
        ExcludeSemantics(
          // child: ,
        )
      ],
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, _) {
    final Color? captionColor = Theme.of(context).textTheme.bodySmall!.color;
    return Container(
      height: $styles.insets.xl,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular($styles.insets.xs),
      ),
      child: Row(
        children: [
          Gap($styles.insets.xs * 1.5),
        ],
      ),
    );
  }
}
