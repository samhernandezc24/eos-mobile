import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class SortActionSheet extends StatefulWidget {
  const SortActionSheet({
    required this.sortOptions,
    required this.onChange,
    Key? key,
    this.sortTitles,
    this.onSelect,
  }) : super(key: key);

  final List<Sort>? sortOptions;
  final List<String>? sortTitles;
  final void Function(Sort?) onChange;
  final Sort? onSelect;

  @override
  State<SortActionSheet> createState() => _SortActionSheetState();
}

class _SortActionSheetState extends State<SortActionSheet> {
  // LIST
  late List<Sort> lstSortOptions;
  late List<String> sortTitles;

  // PROPERTIES
  late Sort? selectSort;

  // STATE
  @override
  void initState() {
    super.initState();
    lstSortOptions  = List.from(widget.sortOptions ?? []);
    sortTitles      = List.from(widget.sortTitles ?? []);
    selectSort      = widget.onSelect;
  }

  // EVENTS
  void _handleChange(Sort? value) {
    setState(() {
      selectSort = value;
    });
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Center(
            child: Text(AppStrings.sortModalBottomTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          ),
        ),
        ...lstSortOptions.asMap().entries.map((entry) {
          final Sort item         = entry.value;
          final String title      = sortTitles[entry.key];
          final bool isSelected   = item == selectSort;

          return RadioListTile(
            controlAffinity : ListTileControlAffinity.trailing,
            title           : Text(title),
            value           : item,
            groupValue      : selectSort,
            onChanged       : isSelected ? null : _handleChange,
          );
        }),
      ],
    );
  }
}
