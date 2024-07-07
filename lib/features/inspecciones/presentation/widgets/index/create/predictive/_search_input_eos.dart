part of '../../../../pages/index/index_page.dart';

class _SearchUnidadEOSInput extends StatelessWidget {
  const _SearchUnidadEOSInput({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    final List<String> _allOptions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
  ];

  Future<List<String>> _fetchOptions(String query) async {
    // Simular un retraso en la búsqueda
    await Future.delayed(Duration(milliseconds: 300));
    // Filtrar las opciones que contienen la consulta
    return _allOptions.where((option) => option.toLowerCase().contains(query.toLowerCase())).toList();
  }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Center(
          child: PredictiveSearchFormField<String>(
            fetchOptions: _fetchOptions,
            displayStringForOption: (data) => data,
            // fieldViewBuilder: _buildInput,
          ),
        );
      },
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, _) {
    return Container(
      height: 54,
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
              controller        : textController,
              onSubmitted       : onSubmit,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlignVertical : TextAlignVertical.top,
              textInputAction   : TextInputAction.search,
              decoration: InputDecoration(
                isDense         : true,
                fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0),
                contentPadding  : EdgeInsets.all($styles.insets.xs),
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
            valueListenable : textController,
            builder         : (_, value, __) {
              return Visibility(
                visible : textController.value.text.isNotEmpty,
                child   : Padding(
                  padding : EdgeInsets.only(right: $styles.insets.xs),
                  child   : CircleIconButton(
                    backgroundColor : $styles.colors.caption,
                    color           : $styles.colors.white,
                    icon            : AppIcons.close,
                    semanticLabel   : AppStrings.searchInputSemanticClear,
                    iconSize        : $styles.insets.sm,
                    size            : $styles.insets.md,
                    onPressed       : () {
                      textController.clear();
                    },
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
