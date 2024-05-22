// part of '../../../pages/list/list_page.dart';

// class _ResultsList extends StatefulWidget {
//   const _ResultsList({Key? key}) : super(key: key);

//   @override
//   State<_ResultsList> createState() => __ResultsListState();
// }

// class __ResultsListState extends State<_ResultsList> {
//   final _scrollController = ScrollController();
//   final _list = List.generate(20, (index) => 'Item ${index + 1}');
//   int _currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_loadMore);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _loadMore() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       setState(() {
//         _currentPage++;
//         _list.addAll(List.generate(
//             20, (index) => 'Item ${index + 1 + _currentPage * 20}'));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: _list.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(_list[index]),
//         );
//       },
//     );
//   }
// }

// // class _ResultsList extends StatefulWidget {
// //   const _ResultsList({required this.onPressed, Key? key, this.lstRows}) : super(key: key);

// //   final void Function(String?) onPressed;
// //   final List<InspeccionDataSourceEntity>? lstRows;

// //   @override
// //   State<_ResultsList> createState() => _ResultsListState();
// // }

// // class _ResultsListState extends State<_ResultsList> {
// //   /// CONTROLLERS
// //   late ScrollController _controller;

// //   /// PROPERTIES
// //   double _prevVelocity = -1;

// //   // AnimationStyle? _animationMenuStyle;

// //   /// METHODS
// //   void _handleResultsScrolled() {
// //     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
// //     final velocity = _controller.position.activity?.velocity;
// //     if (velocity == 0 && _prevVelocity == 0) {
// //       FocusManager.instance.primaryFocus?.unfocus();
// //     }
// //     _prevVelocity = velocity ?? _prevVelocity;
// //   }

// //   void _handleChecklistInspeccionPressed(BuildContext context, InspeccionDataSourceEntity inspeccion) {
// //     Navigator.push<void>(
// //       context,
// //       PageRouteBuilder<void>(
// //         transitionDuration: $styles.times.pageTransition,
// //         pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
// //           const Offset begin    = Offset(0, 1);
// //           const Offset end      = Offset.zero;
// //           const Cubic curve     = Curves.ease;

// //           final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

// //           return SlideTransition(
// //             position: animation.drive<Offset>(tween),
// //             child: ChecklistInspeccionPage(inspeccionDataSource: inspeccion),
// //           );
// //         },
// //         fullscreenDialog: true,
// //       ),
// //     );
// //   }

// //   void _handleInspeccionDetailsPressed(BuildContext context, InspeccionDataSourceEntity inspeccion) {
// //     showDialog<void>(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: <Widget>[
// //               Text('Folio inspección:', style: $styles.textStyles.label),
// //               Text(inspeccion.folio, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600, height: 1.3)),
// //               Divider(color: Theme.of(context).dividerColor, thickness: 1.5),
// //             ],
// //           ),
// //           titlePadding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
// //           content: SizedBox(
// //             height: 200,
// //             width: 400,
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: <Widget>[
// //                   _buildInspeccionInfoText(
// //                     'Requerimiento:',
// //                     inspeccion.hasRequerimiento == false
// //                         ? 'SIN REQUERIMIENTO'
// //                         : inspeccion.requerimientoFolio ?? '',
// //                   ),
// //                   _buildInspeccionInfoText('No. económico:', inspeccion.unidadNumeroEconomico),
// //                   _buildInspeccionInfoText('Tipo de unidad:', inspeccion.unidadTipoName),
// //                   _buildInspeccionInfoText('Tipo de inspección:', inspeccion.inspeccionTipoName),
// //                   _buildInspeccionInfoText('Base:', inspeccion.baseName),
// //                   _buildInspeccionInfoText('Lugar de inspección:', inspeccion.locacion),
// //                   _buildInspeccionInfoText('Fecha programada:', inspeccion.fechaNatural),
// //                   _buildInspeccionInfoText('Estatus:', inspeccion.inspeccionEstatusName),
// //                   _buildInspeccionInfoText('Creado por:', inspeccion.createdUserName),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           contentPadding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
// //           actions: <Widget>[
// //             TextButton.icon(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 _handleChecklistInspeccionPressed(context, inspeccion);
// //               },
// //               icon: const Icon(Icons.assignment_turned_in_outlined),
// //               label: Text('Evaluar', style: $styles.textStyles.button),
// //             ),

// //             TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cerrar', style: $styles.textStyles.button)),
// //           ],
// //           actionsPadding: EdgeInsets.fromLTRB(0, 0, $styles.insets.sm, $styles.insets.xs),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ScrollDecorator.shadow(
// //       onInit: (controller) => controller.addListener(_handleResultsScrolled),
// //       builder: (controller) {
// //         _controller = controller;
// //         return CustomScrollView(
// //           controller: controller,
// //           scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
// //           slivers: <Widget>[
// //             SliverPadding(
// //               padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
// //               sliver: _buildInspeccionesList(widget.lstRows ?? []),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildInspeccionesList(List<InspeccionDataSourceEntity> lstRows) {
// //     return SliverList(
// //       delegate: SliverChildBuilderDelegate(
// //         (BuildContext context, int index) {
// //           final InspeccionDataSourceEntity inspeccion = lstRows[index];
// //           return _buildInspeccionCard(inspeccion);
// //         },
// //         childCount: lstRows.length,
// //       ),
// //     );
// //   }

// //    Widget _buildInspeccionCard(InspeccionDataSourceEntity inspeccion) {
// //     return Card(
// //       elevation: 3,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
// //       margin: EdgeInsets.only(bottom: $styles.insets.lg),
// //       child: Stack(
// //         children: <Widget>[
// //           Container(
// //             padding: EdgeInsets.all($styles.insets.xs),
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 _buildInspeccionFechaSection(inspeccion, inspeccion.fecha),

// //                 Gap($styles.insets.sm),

// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       _buildInspeccionInfoText('Folio inspección: ', inspeccion.folio),
// //                       _buildInspeccionInfoText(
// //                         'Requerimiento: ',
// //                         inspeccion.hasRequerimiento == false
// //                             ? 'SIN REQUERIMIENTO'
// //                             : inspeccion.requerimientoFolio ?? '',
// //                       ),
// //                       _buildInspeccionInfoText('No. económico: ', inspeccion.unidadNumeroEconomico),
// //                       _buildInspeccionInfoText('Tipo de unidad: ', inspeccion.unidadTipoName),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           Positioned(
// //             top: 0,
// //             right: $styles.insets.xxs,
// //             child: PopupMenuButton<InspeccionMenu>(
// //               // popUpAnimationStyle: _animationMenuStyle,
// //               icon: const Icon(Icons.more_vert),
// //               onSelected: (InspeccionMenu item) {
// //                 switch (item) {
// //                   case InspeccionMenu.details:
// //                     _handleInspeccionDetailsPressed(context, inspeccion);
// //                   case InspeccionMenu.edit:
// //                   case InspeccionMenu.cancel:
// //                 }
// //               },
// //               itemBuilder: (BuildContext context) {
// //                 return <PopupMenuEntry<InspeccionMenu>>[
// //                   const PopupMenuItem<InspeccionMenu>(
// //                     value: InspeccionMenu.details,
// //                     child: ListTile(
// //                       leading: Icon(Icons.info),
// //                       title: Text('Detalles'),
// //                       // onTap: (){},
// //                     ),
// //                   ),
// //                   const PopupMenuItem<InspeccionMenu>(
// //                     value: InspeccionMenu.edit,
// //                     child: ListTile(
// //                       leading: Icon(Icons.edit),
// //                       title: Text('Editar'),
// //                       // onTap: (){},
// //                     ),
// //                   ),
// //                   PopupMenuItem<InspeccionMenu>(
// //                     value: InspeccionMenu.cancel,
// //                     child: ListTile(
// //                       leading: const Icon(Icons.delete_forever),
// //                       textColor: Theme.of(context).colorScheme.error,
// //                       iconColor: Theme.of(context).colorScheme.error,
// //                       title: const Text('Cancelar'),
// //                       // onTap: (){},
// //                     ),
// //                   ),
// //                 ];
// //               },
// //             ),
// //           ),

// //           if (inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35')
// //             const SizedBox.shrink()
// //           else if (inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34')
// //             Positioned(
// //               bottom: 0,
// //               right: $styles.insets.xxs,
// //               child: TextButton.icon(
// //                 onPressed: (){},
// //                 icon: const Icon(Icons.print),
// //                 label: const Text('Reporte'),
// //                 style: ButtonStyle(
// //                   foregroundColor: Theme.of(context).brightness == Brightness.dark
// //                       ? MaterialStateProperty.all<Color>(Colors.green[100]!)
// //                       : MaterialStateProperty.all<Color>(Colors.green[600]!),
// //                 ),
// //               ),
// //             )
// //           else
// //             Positioned(
// //               bottom: 0,
// //               right: $styles.insets.xxs,
// //               child: TextButton.icon(
// //                 onPressed: () => _handleChecklistInspeccionPressed(context, inspeccion),
// //                 icon: const Icon(Icons.assignment_turned_in_outlined),
// //                 label: const Text('Evaluar'),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInspeccionInfoText(String label, String value) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: <Widget>[
// //         Text(label, style: $styles.textStyles.label),
// //         Text(value, style: $styles.textStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3), overflow: TextOverflow.ellipsis),
// //         Gap($styles.insets.xxs),
// //       ],
// //     );
// //   }
// // }
