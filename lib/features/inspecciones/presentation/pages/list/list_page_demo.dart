// import 'package:eos_mobile/core/common/widgets/controls/circle_buttons.dart';
// import 'package:eos_mobile/core/enums/app_icons_enums.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/inspecciones_search_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/search/search_data.dart';
// import 'package:eos_mobile/shared/shared.dart';

// part '../../widgets/_search_input.dart';

// class InspeccionListPage extends StatefulWidget {
//   const InspeccionListPage({super.key});

//   @override
//   State<InspeccionListPage> createState() => _InspeccionListPageState();
// }

// class _InspeccionListPageState extends State<InspeccionListPage> {
//   final List<Map<String, dynamic>> inspecciones = [
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//     {
//       'folio': 'INS-24-000001',
//       'requerimientoFolio': 'REQ-24-000001',
//       'unidadTipoName': 'Tractocamión',
//       'unidadNumeroEconomico': 'HL-PRB-10',
//       'fechaInspeccionFinal': '24 de Feb 2024',
//     },
//   ];

//   final List<SearchData> _searchResults = [];
//   final List<SearchData> _filteredResults = [];
//   String _query = '';

//   @override
//   Widget build(BuildContext context) {
//     Widget content = GestureDetector(
//       onTap: FocusManager.instance.primaryFocus?.unfocus,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
//             child: _SearchInput(onSubmit: _handleSearchSubmitted, inspecciones: inspecciones),
//           ),
//           Container(
//             padding: EdgeInsets.all($styles.insets.xs * 1.5),
//             child: _buildStatusText(context),
//           ),
//           Expanded(
//             child: RepaintBoundary(
//               child: _filteredResults.isEmpty
//                   ? _buildEmptyIndicator(context)
//                   : _ResultsGrid(
//                     searchResults: _filteredResults,
//                     onPressed: _handleResultPressed,
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(child: ColoredBox(color: Colors.grey, child: content)),
//           Positioned.fill(
//             child: RepaintBoundary(
//               child: ExpandingTimeRangeSele,
//             ),
//           ),
//         ],
//       ),
//       // body: ListView.builder(
//       //   padding: EdgeInsets.all($styles.insets.sm),
//       //   itemBuilder: (BuildContext context, int index) {
//       //     final inspeccion = inspecciones[index];
//       //     return InspeccionListTile(
//       //       onTap: (){},
//       //       title: inspeccion['folio'] as String,
//       //       subtitle1: '${inspeccion['requerimientoFolio']}',
//       //       subtitle3: '${inspeccion['unidadNumeroEconomico']}',
//       //       subtitle2: '${inspeccion['unidadTipoName']}',
//       //       publishedDate: '${inspeccion['fechaInspeccionFinal']}',
//       //       thumbnail: Container(
//       //         decoration: BoxDecoration(
//       //           color: Theme.of(context).focusColor,
//       //           border: Border.all(
//       //             color: Theme.of(context).highlightColor,
//       //             width: 1.5,
//       //           ),
//       //           borderRadius: BorderRadius.circular($styles.corners.md),
//       //         ),
//       //         child: Center(
//       //           child: Image.asset(
//       //             ImagePaths.crane,
//       //             fit: BoxFit.cover,
//       //             filterQuality: FilterQuality.high,
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //   },
//       // itemBuilder: (BuildContext context, int index) {
//       //   final inspeccion = inspecciones[index];
//       //   return Card(
//       //     shape: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.circular($styles.corners.md),
//       //     ),
//       //     clipBehavior: Clip.antiAliasWithSaveLayer,
//       //     child: Stack(
//       //       children: [
//       //         ListTile(
//       //           // dense: true,
//       //           leading: Image.asset(
//       //             ImagePaths.crane,
//       //             width: 90,
//       //             height: 90,
//       //             fit: BoxFit.cover,
//       //           ),
//       //           // titleTextStyle: MaterialStateTextStyle,
//       //           subtitle: Column(
//       //             crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: <Widget>[
//       //               Text(
//       //                 'Inspección: ${inspeccion['folio']}',
//       //                 style: $styles.textStyles.caption,
//       //               ),
//       //               Text(
//       //                 'Requerimiento: ${inspeccion['requerimientoFolio']}',
//       //               ),
//       //               Text(
//       //                 'Unidad: ${inspeccion['unidadTipoName']}',
//       //               ),
//       //               Text(
//       //                 'No. Económico: ${inspeccion['unidadNumeroEconomico']}',
//       //               ),
//       //               Text(
//       //                 'Fecha Inspección: ${inspeccion['fechaInspeccionFinal']}',
//       //               ),
//       //             ],
//       //           ),
//       //           onTap: () {},
//       //         ),
//       //         Positioned(
//       //           top: 0,
//       //           left: 4,
//       //           child: Container(
//       //             padding:
//       //                 EdgeInsets.symmetric(horizontal: $styles.insets.xs),
//       //             decoration: BoxDecoration(
//       //               color: Colors.green,
//       //               border: Border.all(
//       //                 color: Colors.green,
//       //               ),
//       //               borderRadius: BorderRadius.circular($styles.corners.md),
//       //             ),
//       //             child: Text(
//       //               'Hace 5 días',
//       //               style: $styles.textStyles.badge,
//       //             ),
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//       //   );
//       // },
//       //     itemCount: inspecciones.length,
//       //   ),
//     );
//   }
// }
