import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({required this.onChange, Key? key, this.searchFilters}) : super(key: key);

  final List<SearchFilter>? searchFilters;
  final void Function(List<SearchFilter>) onChange;

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  // LIST
  late List<SearchFilter> lstSearchFilters;

  // STATE
  @override
  void initState() {
    super.initState();
    lstSearchFilters = List.from(widget.searchFilters ?? []);
  }

  // EVENTS
  void _handleCheckboxChange(bool? value, int index) {
    setState(() {
      lstSearchFilters[index] = lstSearchFilters[index].copyWith(isChecked: value ?? false);
    });
    widget.onChange(lstSearchFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Center(
            child: Text(
              'Buscar resultados en:',
              style: $styles.textStyles.h3.copyWith(fontSize: 18),
            ),
          ),
        ),
        ...lstSearchFilters.asMap().entries.map((entry) {
          final int index = entry.key;
          final SearchFilter item = entry.value;
          return CheckboxListTile(
            title           : Text(item.title ?? ''),
            value           : item.isChecked,
            onChanged       : (bool? value) => _handleCheckboxChange(value, index),
            controlAffinity : ListTileControlAffinity.leading,
          );
        }),
      ],
    );
  }
}
