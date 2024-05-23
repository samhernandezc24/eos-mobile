// import 'dart:io';

// import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/card_checklist.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/radio_group_checklist.dart';
// import 'package:eos_mobile/shared/shared_libraries.dart';
// import 'package:eos_mobile/ui/common/custom_box_container.dart';
// import 'package:intl/intl.dart';

// class ChecklistInspeccionPage extends StatefulWidget {
//   const ChecklistInspeccionPage({Key? key, this.inspeccionDataSource}) : super(key: key);

//   final InspeccionDataSourceEntity? inspeccionDataSource;

//   @override
//   State<ChecklistInspeccionPage> createState() => _ChecklistInspeccionPageState();
// }

// class _ChecklistInspeccionPageState extends State<ChecklistInspeccionPage> {
//   /// INSTANCES
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   /// CONTROLLERS
//   late final ScrollController _scrollController = ScrollController();

//   late final TextEditingController _fechaInspeccionController;

//   late final List<Map<String, dynamic>> arrInspeccionGeneralInfo;

//   /// PROPERTIES
//   final int maxImages = 10;

//   bool _showScrollToTopButton = false;

//   // final List<_Item> _data = generateItems([]);
//   final List<String> categoriesFromServer = ['Categoría 1', 'Categoría 2', 'Categoría 3']; // Ejemplo de categorías obtenidas del servidor

//   final List<File> _lstImages = <File>[];

//   @override
//   void initState() {
//     super.initState();

//     arrInspeccionGeneralInfo = getInspeccionGeneralInfoList();

//     _fechaInspeccionController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _fechaInspeccionController.dispose();
//     super.dispose();
//   }

//   /// METHODS
//   Future<DateTime?> _selectFechaInspeccion(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context     : context,
//       initialDate : DateTime.now(),
//       firstDate   : DateTime(2000),
//       lastDate    : DateTime(2100),
//     );

//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context     : context,
//         initialTime : TimeOfDay.fromDateTime(DateTime.now()),
//       );

//       if (pickedTime != null) {
//         return DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//       }
//     }
//     return null;
//   }

//   void _handleOnPopPage(BuildContext context) {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
//               child: Center(
//                 child: Text('¿Quieres terminar la inspección más tarde?', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//               ),
//             ),
//             ListTile(
//               onTap: (){},
//               leading: const Icon(Icons.bookmark),
//               title: const Text('Guardar como borrador'),
//               subtitle: const Text('Puedes retomar y responder esta inspección en otro momento.'),
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//               leading: const Icon(Icons.delete_forever),
//               textColor: Theme.of(context).colorScheme.error,
//               iconColor: Theme.of(context).colorScheme.error,
//               title: const Text('Descartar inspección'),
//             ),
//             ListTile(
//               onTap: () => context.pop(),
//               leading: const Icon(Icons.check),
//               textColor: Theme.of(context).colorScheme.primary,
//               iconColor: Theme.of(context).colorScheme.primary,
//               title: const Text('Continuar respondiendo'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _scrollToTop() {
//     _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
//   }

//   List<Map<String, dynamic>> getInspeccionGeneralInfoList() {
//     final String requerimientoFolio = widget.inspeccionDataSource!.hasRequerimiento == true
//         ? widget.inspeccionDataSource?.requerimientoFolio ?? ''
//         : 'SIN REQUERIMIENTO';

//     return [
//       { 'title': 'Folio inspección:',             'subtitle': widget.inspeccionDataSource?.folio ?? ''                  },
//       { 'title': 'Requerimiento:',                'subtitle': requerimientoFolio                                        },
//       { 'title': 'Fecha programada:',             'subtitle': widget.inspeccionDataSource?.fechaNatural ?? ''           },
//       { 'title': 'No. económico:',                'subtitle': widget.inspeccionDataSource?.unidadNumeroEconomico ?? ''  },
//       { 'title': 'Tipo de unidad:',               'subtitle': widget.inspeccionDataSource?.unidadTipoName ?? ''         },
//       { 'title': 'Tipo de inspección:',           'subtitle': widget.inspeccionDataSource?.inspeccionTipoName ?? ''     },
//       { 'title': 'Lugar de inspección:',          'subtitle': widget.inspeccionDataSource?.locacion ?? ''               },
//       { 'title': 'Base unidad:',                  'subtitle': widget.inspeccionDataSource?.baseName ?? ''               },
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Widget scrollToTopButton = AnimatedOpacity(
//       opacity   : _showScrollToTopButton ? 1.0 : 0.0,
//       duration  : $styles.times.fast,
//       child     : FloatingActionButton(onPressed: _scrollToTop, child: const Icon(Icons.arrow_upward)),
//     );

//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) {
//         if (didPop) return;
//         _handleOnPopPage(context);
//       },
//       child: Scaffold(
//         appBar: AppBar(title: Text('Evaluar unidad', style: $styles.textStyles.h3)),
//         body: NotificationListener<ScrollNotification>(
//           onNotification: (ScrollNotification notification) {
//             if (notification is ScrollUpdateNotification) {
//               setState(() {
//                 _showScrollToTopButton = _scrollController.offset > 100;
//               });
//             }
//             return true;
//           },
//           child: ListView(
//             controller: _scrollController,
//             padding: EdgeInsets.only(top: $styles.insets.sm),
//             children: <Widget>[
//
//               Gap($styles.insets.xs),

//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       // FECHA DE LA INSPECCIÓN:
//                       LabeledTextFormField(
//                         controller  : _fechaInspeccionController,
//                         isReadOnly  : true,
//                         label       : '* Fecha de inspección inicial:',
//                         hintText    : 'dd/mm/aaaa',
//                         textAlign   : TextAlign.end,
//                         onTap       : () async {
//                           final DateTime? pickedDate = await _selectFechaInspeccion(context);
//                           if (pickedDate != null) {
//                             setState(() {
//                               _fechaInspeccionController.text = DateFormat('dd/MM/yyyy HH:mm a').format(pickedDate);
//                             });
//                           }
//                         },
//                         validator   : FormValidators.textValidator,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               Gap($styles.insets.sm),

//               // FORMULARIO DE PREGUNTAS:
//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Gap($styles.insets.xs),

//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Gap($styles.insets.xs),

//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Gap($styles.insets.xs),

//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Gap($styles.insets.xs),

//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Gap($styles.insets.xs),

//               Card(
//                 elevation: 2,
//                 shape: const RoundedRectangleBorder(),
//                 child: ExpansionTile(
//                   leading: const Icon(Icons.check_circle),
//                   title: Text('GENERALES', style: $styles.textStyles.h4),
//                   children: <Widget>[
//                     SizedBox(
//                       height: 250,
//                       child: ListView.builder(
//                         itemCount: arrInspeccionGeneralInfo.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final item = arrInspeccionGeneralInfo[index];
//                           return ListTile(
//                             dense: true,
//                             title: Text(item['title'].toString(), style: $styles.textStyles.label),
//                             subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // CardCheckList(
//               //   title: 'Niveles Y Motor',
//               //   children: <Widget>[
//               //     RadioGroupChecklist(
//               //       label: '1. Tanque de Combustible',
//               //       options: ['wef','wefwef','wefewf'],
//               //       selectedValue: '',
//               //       onChanged: (_){},
//               //     ),
//               //   ],
//               // ),

//               Gap($styles.insets.sm),

//               // EVIDENCIA FOTOGRÁFICA:
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm).copyWith(bottom: $styles.insets.offset * 1.5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('* Evidencia fotográfica:', style: $styles.textStyles.label),

//                     Gap($styles.insets.xs),

//                     if (_lstImages.isNotEmpty)...[
//                         _buildImagesGrid(context),
//                         Gap($styles.insets.xs),
//                         _buildImageCountRow(context),
//                       ]
//                     else
//                       const CustomBoxContainer(
//                         title: 'Aún no hay fotografías',
//                         content: 'Toma fotografías dando clic en el ícono de la cámara para visualizarlas en esta sección.',
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             children: <Widget>[
//               IconButton(
//                 onPressed: () async {
//                   final picture = await imageHelper.takePhoto();
//                   if (picture != null) {
//                     setState(() {
//                       _lstImages.add(File(picture.path));
//                     });
//                   }
//                 },
//                 icon: const Icon(Icons.camera_alt),
//                 tooltip: 'Tomar fotografía',
//               ),
//               // IconButton(onPressed: (){}, icon: const Icon(Icons.sync), tooltip: 'Sincronizar información'),
//               const Spacer(),
//               FilledButton(onPressed: (){}, child: Text('Guardar evaluación', style: $styles.textStyles.button)),
//             ],
//           ),
//         ),
//         floatingActionButton: scrollToTopButton,
//       ),
//     );
//   }

//   Widget _buildExpansionTileList(List<String> categories) {
//     return Column(
//       children: categories.map<Widget>((category) {
//       return Card(
//         elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular($styles.insets.xs),
//           ),
//           child: ExpansionTile(
//             initiallyExpanded: true,
//             tilePadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
//             leading: Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: $styles.insets.xxs,
//                 horizontal: $styles.insets.xs,
//               ),
//               decoration: BoxDecoration(
//                 color:
//                     Theme.of(context).colorScheme.errorContainer.withOpacity(0.85),
//                 borderRadius: BorderRadius.circular($styles.corners.md),
//               ),
//               child: Text(
//                 '1 / 10',
//                 style: $styles.textStyles.label.copyWith(fontSize: 12),
//               ),
//             ),
//             title: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Pregunta 1',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: $styles.textStyles.h4,
//                   ),
//                 ),
//                 IconButton.filledTonal(
//                   onPressed: () {},
//                   icon: const Icon(Icons.save),
//                 ),
//               ],
//             ),
//             children: <Widget>[
//               SizedBox(
//                 height: 280,
//                 child: Container(),
//               ),
//             ],
//           ),
//         );
//         // return ExpansionTile(
//         //   title: Text(category),
//         //   children: const <Widget>[
//         //     ListTile(
//         //       title: Text('Pregunta 1'),
//         //     ),
//         //     ListTile(
//         //       title: Text('Pregunta 2'),
//         //     ),
//         //     ListTile(
//         //       title: Text('Pregunta 3'),
//         //     ),
//         //     // Agrega más ListTile según sea necesario para representar las preguntas para cada categoría
//         //   ],
//         // );
//       }).toList(),
//     );
//   }

//   Widget _buildImagesGrid(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all($styles.insets.xxs),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surfaceVariant,
//         border: Border.all(color: Theme.of(context).primaryColor, width: 1.2),
//         borderRadius: BorderRadius.circular($styles.corners.md),
//       ),
//       height: 250,
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: $styles.insets.sm,
//           mainAxisSpacing: $styles.insets.sm,
//         ),
//         itemCount: _lstImages.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: (){},
//             child: Card(
//               // elevation: 2,
//               child: Stack(
//                 children: <Widget>[
//                   Positioned.fill(child: Image.file(_lstImages[index], fit: BoxFit.cover)),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: IconButton(
//                       color: Theme.of(context).colorScheme.error,
//                       icon: const Icon(Icons.delete),
//                       onPressed: () {
//                         setState(() {
//                           _lstImages.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//         shrinkWrap: true,
//       ),
//     );
//   }

//   Widget _buildImageCountRow(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
//           decoration: BoxDecoration(
//             color: Theme.of(context).highlightColor,
//             borderRadius: BorderRadius.circular($styles.corners.md),
//           ),
//           child: Row(
//             children: <Widget>[
//               Icon(Icons.photo_camera, color: Theme.of(context).hintColor, size: 20),
//               Gap($styles.insets.xs),
//               RichText(
//                 text: TextSpan(
//                   style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onSurface),
//                   children: <InlineSpan>[
//                     TextSpan(text: 'Fotografías', style: $styles.textStyles.label),
//                     TextSpan(text: ': ${_lstImages.length} / $maxImages'),
//                   ],
//                 ),
//                 textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _Item {
//   _Item({
//     required this.expandedValue,
//     required this.headerValue,
//     this.isExpanded = false,
//   });

//   String expandedValue;
//   String headerValue;
//   bool isExpanded;
// }
