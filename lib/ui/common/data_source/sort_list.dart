import 'package:eos_mobile/core/data/sort.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class SortList extends StatefulWidget {
  const SortList({
    required this.sortOptions,
    required this.onChange,
    Key? key,
    this.selectedSort,
  }) : super(key: key);

  final List<Sort> sortOptions;
  final void Function(Sort?) onChange;
  final Sort? selectedSort;

  @override
  State<SortList> createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  // LIST
  late List<Sort> lstSortOptions;
  late List<String> sortTitles;

  // SELECTION
  late Sort? selectedSort;

  // STATE
  @override
  void initState() {
    super.initState();
    lstSortOptions  = List.from(widget.sortOptions);
    sortTitles      = _getSortTitles();
    selectedSort    = widget.selectedSort;
  }

  // EVENTS
  void _handleSortOptionChange(Sort? value) {
    setState(() {
      selectedSort = value;
    });
    widget.onChange(value);
  }

  // METHODS
  List<String> _getSortTitles() {
    return [
      'Folio: (A - Z)',
      'Folio: (Z - A)',
      'Fecha programada: más recientes',
      'Fecha programada: más antiguos',
      'Fecha creación: más recientes',
      'Fecha creación: más antiguos',
    ];
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
              'Ordenar por:',
              style: $styles.textStyles.h3.copyWith(fontSize: 18),
            ),
          ),
        ),
        ...lstSortOptions.asMap().entries.map((entry) {
          final Sort item       = entry.value;
          final String title    = sortTitles[entry.key];
          final bool isSelected = item == selectedSort;
          return RadioListTile(
            title           : Text(title),
            value           : item,
            groupValue      : selectedSort,
            onChanged       : isSelected ? null : _handleSortOptionChange,
            controlAffinity : ListTileControlAffinity.trailing,
          );
        }),
      ],
    );
  }
}
