import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class InspeccionSinRequerimientosPage extends StatefulWidget {
  const InspeccionSinRequerimientosPage({super.key});

  @override
  State<InspeccionSinRequerimientosPage> createState() => _InspeccionSinRequerimientosPageState();
}

class _InspeccionSinRequerimientosPageState extends State<InspeccionSinRequerimientosPage> {
  bool isChecked = false;

  final List<String> _items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inspección de Unidad Sin Req.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
          onPressed: () => context.go('/inspecciones'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Text('Unidad Temporal'),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            DropdownSearch<String>(
              items: _items,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Buscar por No. Económico o Folio',
                  isDense: true,
                ),
              ),
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
              ),
            ),
            const Gap(10),
            const Divider(thickness: 1),
            const Text('Seleccionar inspección *'),
            const Gap(10),
            DropdownSearch<String>(
              items: _items,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Seleccionar',
                  isDense: true,
                ),
              ),
              popupProps: const PopupPropsMultiSelection.menu(
                showSearchBox: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
