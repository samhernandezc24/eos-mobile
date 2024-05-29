import 'package:eos_mobile/core/data/search_filter.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({
    required this.searchFilters,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final List<SearchFilter> searchFilters;
  final void Function(List<SearchFilter>) onChange;

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  late List<SearchFilter> lstSearchFilters;

  @override
  void initState() {
    super.initState();
    lstSearchFilters = List.from(widget.searchFilters);
  }

  @override
  void didUpdateWidget(covariant SearchFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchFilters != oldWidget.searchFilters) {
      setState(() {
        lstSearchFilters = List.from(widget.searchFilters);
      });
    }
  }

  void _onCheckboxChanged(bool? value, int index) {
    setState(() {
      lstSearchFilters[index] = lstSearchFilters[index].copyWith(isChecked: value ?? false);
    });
    widget.onChange(lstSearchFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize  : MainAxisSize.min,
      children      : <Widget>[
        Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Center(
            child: Text('Buscar resultados en:', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          ),
        ),
        ...lstSearchFilters.asMap().entries.map((entry) {
          final int index         = entry.key;
          final SearchFilter item = entry.value;
          return CheckboxListTile(
            title           : Text(item.title ?? ''),
            value           : item.isChecked,
            onChanged       : (bool? value) => _onCheckboxChanged(value, index),
            controlAffinity : ListTileControlAffinity.leading,
          );
        }),
      ],
    );
  }
}
