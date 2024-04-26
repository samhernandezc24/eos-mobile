import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class LabeledDropdownFormSearchField<T> extends StatelessWidget {
  const LabeledDropdownFormSearchField({
    required this.label,
    required this.searchController,
    required this.onChanged,
    required this.searchMatchFn,
    Key? key,
    this.hintText,
    this.hintSearchText,
    this.items,
    this.value,
    this.itemBuilder,
    this.onMenuStateChange,
    this.validator,
  }) : super(key: key);

  final String label;
  final TextEditingController searchController;
  final String? hintText;
  final String? hintSearchText;
  final List<T>? items;
  final T? value;
  final void Function(T?) onChanged;
  final Widget Function(T)? itemBuilder;
  final bool Function(DropdownMenuItem<T>, String) searchMatchFn;
  final void Function(bool)? onMenuStateChange;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),
        Gap($styles.insets.xs),
        DropdownButtonFormField2<T>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 3,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: hintText,
          ),
          hint: Row(
            children: <Widget>[
              const Icon(Icons.search),
              Gap($styles.insets.xs),
              Expanded(
                child: Text(hintText ?? 'Seleccionar', overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          items: items?.map<DropdownMenuItem<T>>((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: itemBuilder != null ? itemBuilder!(item) : Text(item.toString()),
            );
          }).toList(),
          value: value,
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 280,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular($styles.insets.xxs)),
          ),
          menuItemStyleData: MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm)),
          dropdownSearchData: DropdownSearchData<T>(
            searchController: searchController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: searchController,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: hintSearchText ?? 'Buscar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular($styles.insets.xs),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            searchMatchFn: searchMatchFn,
          ),
          onMenuStateChange: onMenuStateChange,
          validator: validator,
        ),
      ],
    );
  }
}
