// part of '../../../pages/list/list_page.dart';

// class FilterInspeccion extends StatefulWidget {
//   const FilterInspeccion({Key? key}) : super(key: key);

//   @override
//   State<FilterInspeccion> createState() => _FilterInspeccionState();
// }

// class _FilterInspeccionState extends State<FilterInspeccion> {
//   final List<dynamic> lstInspeccionesEstatus = ['Todos', 'Evaluación', 'Finalizado', 'Cancelado'];
//   Map<String, bool> _selectedEstatusOptions = {};

//   @override
//   void initState() {
//     super.initState();
//     for (final element in lstInspeccionesEstatus) {
//         _selectedEstatusOptions[element as String] = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Buscar por filtros', style: $styles.textStyles.h3)),
//       body: Padding(
//         padding: EdgeInsets.all($styles.insets.sm),
//         child: Column(
//           children: <Widget>[
//             MultiSelectDialogField(
//               items: lstInspeccionesEstatus.map((e) => MultiSelectItem(e, e.toString())).toList(),
//               listType: MultiSelectListType.CHIP,
//               onConfirm: (values) {

//               },
//             ),

//             // LabeledDropdownFormField(
//             //   label: 'Estatus',
//             //   items: lstInspeccionesEstatus,
//             //   onChanged: (newValue) {
//             //     setState(() {
//             //       _selectedFilterEstatus = newValue;
//             //     });
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
