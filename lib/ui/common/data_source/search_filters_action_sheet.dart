import 'package:eos_mobile/core/data/data_source/search_filter.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class SearchFiltersActionSheet extends StatefulWidget {
  const SearchFiltersActionSheet({
    required this.searchFilters,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final List<SearchFilter>? searchFilters;
  final void Function(List<SearchFilter>) onChange;

  @override
  State<SearchFiltersActionSheet> createState() => _SearchFiltersActionSheetState();
}

class _SearchFiltersActionSheetState extends State<SearchFiltersActionSheet> {
  // LIST
  late List<SearchFilter> lstSearchFilters;

  // STATE
  @override
  void initState() {
    super.initState();
    lstSearchFilters = List.from(widget.searchFilters ?? []);
  }

  // EVENTS
  void _handleChange(bool? value, int index) {
    setState(() {
      lstSearchFilters[index] = SearchFilter(
        field: lstSearchFilters[index].field,
        isChecked: value,
        title: lstSearchFilters[index].title,
      );
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
            child: Text(AppStrings.searchFiltersModalBottomTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          ),
        ),
        ...lstSearchFilters.asMap().entries.map((entry) {
          final int index           = entry.key;
          final SearchFilter item   = entry.value;

          return CheckboxListTile(
            controlAffinity : ListTileControlAffinity.leading,
            title           : Text(item.title ?? ''),
            value           : item.isChecked,
            onChanged       : (bool? value) => _handleChange(value, index),
          );
        }),
      ],
    );
  }
}
