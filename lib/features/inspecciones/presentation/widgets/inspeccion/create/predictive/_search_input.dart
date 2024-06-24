part of '../../../../pages/list/list_page.dart';

class _SearchInputUnidadTemporal extends StatefulWidget {
  const _SearchInputUnidadTemporal({Key? key}) : super(key: key);

  @override
  State<_SearchInputUnidadTemporal> createState() => __SearchInputUnidadTemporalState();
}

class __SearchInputUnidadTemporalState extends State<_SearchInputUnidadTemporal> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        // child: Autocomplete(
        //   displayStringForOption: (data) => data,
        //   optionsBuilder: _getSuggestions,
        //   optionsViewBuilder: (context, onSelected, results) =>
        //       _buildSuggestionsView,
        //   fieldViewBuilder: _buildInput,
        // ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3),
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
        border        : Border.all(color: Theme.of(context).colorScheme.primary, width: 1.6),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),

          const Icon(Icons.search),

          Expanded(
            child: TextField(
              controller  : textController,
              focusNode   : focusNode,
              style       : TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
