// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
// import 'package:eos_mobile/shared/shared_libraries.dart';

// class CategoriaItemTile extends StatefulWidget {
//   const CategoriaItemTile({Key? key, this.categoriaItem, this.inspeccionTipo, this.categoria, this.formulariosTipos}) : super(key : key);

//   final CategoriaItemEntity? categoriaItem;
//   final InspeccionTipoEntity? inspeccionTipo;
//   final CategoriaEntity? categoria;
//   final List<FormularioTipoEntity>? formulariosTipos;

//   @override
//   State<CategoriaItemTile> createState() => _CategoriaItemTileState();
// }

// class _CategoriaItemTileState extends State<CategoriaItemTile> {
//   /// CONTROLLERS
//   late final TextEditingController _nameController;
//   late final TextEditingController _formularioValorController;

//   /// PROPERTIES
//   late FormularioTipoEntity _selectedFormularioTipo;
//   late bool _isEditMode;

//   @override
//   void initState() {
//     super.initState();
//     _isEditMode = widget.categoriaItem?.isEdit ?? false;

//     _nameController             = TextEditingController(text: widget.categoriaItem?.name ?? '');
//     _formularioValorController  = TextEditingController(text: widget.categoriaItem?.formularioValor ?? '');

//     _selectedFormularioTipo = widget.formulariosTipos!.firstWhere((element) => element.name == widget.categoriaItem!.formularioTipoName);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _formularioValorController.dispose();
//     super.dispose();
//   }

//   /// METHODS
//   Future<void> _showFailureDialog(BuildContext context, RemoteCategoriaItemFailure state) {
//     return showDialog<void>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const SizedBox.shrink(),
//         content: Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             SizedBox(width: $styles.insets.xs + 2),
//             Flexible(
//               child: Text(
//                 state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar la pregunta de nuevo.',
//                 style: $styles.textStyles.title2.copyWith(
//                   height: 1.5,
//                   color: Theme.of(context).colorScheme.error,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => context.pop(),
//             child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _showFailedMessageDialog(BuildContext context, RemoteCategoriaItemFailedMessage state) {
//     return showDialog<void>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const SizedBox.shrink(),
//         content: Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             SizedBox(width: $styles.insets.xs + 2),
//             Flexible(
//               child: Text(
//                 state.errorMessage.toString(),
//                 style: $styles.textStyles.title2.copyWith(
//                   height: 1.5,
//                   color: Theme.of(context).colorScheme.error,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => context.pop(),
//             child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   void _editCategoriaItem(CategoriaItemEntity categoriaItem) {
//     setState(() {
//       _isEditMode = !_isEditMode;
//     });
//   }

//   void _handleUpdatePressed(BuildContext context, CategoriaItemEntity? categoriaItem) {
//     final CategoriaItemEntity objCategoriaItemData = CategoriaItemEntity(
//       idCategoriaItem     : categoriaItem?.idCategoriaItem ?? '',
//       name                : _nameController.text,
//       idCategoria         : categoriaItem?.idCategoria ?? '',
//       categoriaName       : categoriaItem?.categoriaName ?? '',
//       idFormularioTipo    : _selectedFormularioTipo.idFormularioTipo,
//       formularioTipoName  : _selectedFormularioTipo.name,
//       formularioValor     : _formularioValorController.text,
//     );

//     context.read<RemoteCategoriaItemBloc>().add(UpdateCategoriaItem(objCategoriaItemData));
//   }

//   void _handleDuplicateCategoriaItem(BuildContext context) {
//     final CategoriaItemDuplicateReqEntity duplicatedCategoriaItem = CategoriaItemDuplicateReqEntity(
//       name                  : widget.categoriaItem?.name ?? '',
//       idInspeccionTipo      : widget.inspeccionTipo?.idInspeccionTipo ?? '',
//       inspeccionTipoName    : widget.inspeccionTipo?.name ?? '',
//       idCategoria           : widget.categoria?.idCategoria ?? '',
//       categoriaName         : widget.categoria?.name ?? '',
//       idFormularioTipo      : widget.categoriaItem?.idFormularioTipo ?? '',
//       formularioTipoName    : widget.categoriaItem?.formularioTipoName ?? '',
//       formularioValor       : widget.categoriaItem?.formularioValor ?? '',
//     );

//     context.read<RemoteCategoriaItemBloc>().add(StoreDuplicateCategoriaItem(duplicatedCategoriaItem));
//   }

//   void _handleDeletePressed(BuildContext context, CategoriaItemEntity? categoriaItem) {
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
//           listener: (BuildContext context, RemoteCategoriaItemState state) {
//             if (state is RemoteCategoriaItemFailure) {
//                _showFailureDialog(context, state);
//               context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
//             }

//             if (state is RemoteCategoriaItemFailedMessage) {
//               _showFailedMessageDialog(context, state);
//               context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
//             }

//             if (state is RemoteCategoriaItemResponseSuccess) {
//               Navigator.pop(context);

//               ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(
//                   content: Text(state.apiResponse.message, softWrap: true),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.fixed,
//                   elevation: 0,
//                 ),
//               );

//               context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
//             }
//           },
//           builder: (BuildContext context, RemoteCategoriaItemState state) {
//             if (state is RemoteCategoriaItemLoading) {}

//             return AlertDialog(
//               title: Text('¿Eliminar pregunta?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
//               content: RichText(
//                 text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
//                   children: <InlineSpan>[
//                     const TextSpan(text: 'Se eliminará la pregunta '),
//                     TextSpan(
//                       text: '"${categoriaItem!.name}". ',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const TextSpan(text: '¿Estás seguro de querer realizar esa acción?'),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => context.read<RemoteCategoriaItemBloc>().add(DeleteCategoriaItem(categoriaItem)),
//                   child: Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
//       margin: EdgeInsets.only(bottom: $styles.insets.lg),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // PREGUNTA (EDITABLE):
//           ListTile(
//             onTap: () =>  _editCategoriaItem(widget.categoriaItem!),
//             leading: _isEditMode
//                 ? null
//                 : CircleAvatar(
//                     radius: 14,
//                     child: Text(widget.categoriaItem!.orden.toString(), style: $styles.textStyles.h4),
//                   ),
//             title: _isEditMode
//                 ? TextFormField(
//                   controller: _nameController,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: $styles.insets.sm - 3,
//                         horizontal: $styles.insets.xs + 2,
//                       ),
//                       hintText: 'Pregunta',
//                     ),
//                   )
//                 : Text(widget.categoriaItem?.name ?? ''),
//           ),

//           // VALORES DEL FORMULARIO (EDITABLE):
//           _buildFormularioValues(widget.categoriaItem!),

//           const Divider(),

//           // ACCIONES (BOTONES):
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 if (_isEditMode) ...{
//                   TextButton.icon(
//                     onPressed: () {
//                       _handleUpdatePressed(context, widget.categoriaItem);
//                       _editCategoriaItem(widget.categoriaItem!);
//                     },
//                     icon: const Icon(Icons.check_circle),
//                     label: Text($strings.saveButtonText, style: $styles.textStyles.button),
//                   ),
//                   TextButton(
//                     onPressed: () => _editCategoriaItem(widget.categoriaItem!),
//                     child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
//                   ),
//                 },
//                 IconButton(
//                   onPressed: () => _handleDuplicateCategoriaItem(context),
//                   icon: const Icon(Icons.content_copy),
//                   tooltip: 'Duplicar elemento',
//                 ),
//                 IconButton(
//                   onPressed: () => _handleDeletePressed(context, widget.categoriaItem),
//                   color: Theme.of(context).colorScheme.error,
//                   icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
//                   tooltip: 'Eliminar',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormularioValues(CategoriaItemEntity categoriaItem) {
//     return ListTile(
//       onTap: () => _editCategoriaItem(categoriaItem),
//       title: _isEditMode
//           ? _buildFormularioTiposSelect()
//           : _buildFormularioValuesContent(categoriaItem),
//     );
//   }

//   Widget _buildFormularioTiposSelect() {
//     final bool isMultipleOption = _selectedFormularioTipo.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32';
//     final bool isDropdownList   = _selectedFormularioTipo.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33';

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         DropdownButtonFormField<FormularioTipoEntity>(
//           decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//             hintText: 'Seleccione',
//           ),
//           menuMaxHeight: 280,
//           value: _selectedFormularioTipo,
//           items: widget.formulariosTipos!.map((formularioTipo) {
//             return DropdownMenuItem<FormularioTipoEntity>(value: formularioTipo, child: Text(formularioTipo.name));
//           }).toList(),
//           onChanged: (newValue) {
//             setState(() {
//               _selectedFormularioTipo = newValue!;
//             });

//             if (newValue!.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31' ||
//                 newValue.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34' ||
//                 newValue.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35' ||
//                 newValue.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36' ||
//                 newValue.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37') {
//               _formularioValorController.clear();
//             } else {
//               _formularioValorController.text = 'Sí,No';
//             }
//           },
//         ),

//         Gap($styles.insets.sm),

//         if (isMultipleOption || isDropdownList)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               RichText(
//                 text: TextSpan(
//                   style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//                   children: <InlineSpan>[
//                     TextSpan(
//                       text: 'Sugerencia',
//                       style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     const TextSpan(text: ': Para agregar opciones intenta seguir el formato separando las opciones por comas y sin espacios.'),
//                   ],
//                 ),
//               ),
//               Gap($styles.insets.xs),
//               TextFormField(
//                 controller: _formularioValorController,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: $styles.insets.sm - 3,
//                     horizontal: $styles.insets.xs + 2,
//                   ),
//                   hintText: 'Opción 1,Opción 2,...',
//                 ),
//               ),
//             ],
//           )
//         else
//           Text('Tipo de pregunta: ${_selectedFormularioTipo.name}'),
//       ],
//     );
//   }

//   Widget _buildFormularioValuesContent(CategoriaItemEntity categoriaItem) {
//     switch (categoriaItem.idFormularioTipo) {
//       // PREGUNTA ABIERTA:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
//         return Text('Texto de respuesta abierta', style: $styles.textStyles.title2);
//       // OPCIÓN MÚLTIPLE:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
//         final List<String> options = categoriaItem.formularioValor!.split(',');
//         return Row(
//           children: <Widget>[
//             Container(
//               constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
//               child: Wrap(
//                 spacing: 8,
//                 runSpacing: 4,
//                 children: options.map((opt) {
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Radio<String>(
//                         value: opt,
//                         groupValue: null,
//                         onChanged: null,
//                       ),
//                       Text(opt),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         );
//       // LISTA DESPLEGABLE:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
//         final List<String> options = categoriaItem.formularioValor!.split(',');
//         return DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//           ),
//           value: options.isNotEmpty ? options.first : null,
//           items: options.map((option) {
//             return DropdownMenuItem<String>(value: option, child: Text(option));
//           }).toList(),
//           onChanged: null,
//         );
//       // FECHA:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
//         return TextField(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//             hintText: 'dd/mm/aaaa',
//             suffixIcon: const Icon(Icons.calendar_month),
//           ),
//           readOnly: true,
//         );
//       // HORA:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
//         return TextField(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//             hintText: 'hh:mm:ss',
//             suffixIcon: const Icon(Icons.schedule),
//           ),
//           readOnly: true,
//         );
//       // NÚMERO ENTERO:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
//         return TextField(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//             hintText: '1, 2, 3, 4, 5, 6,...',
//             suffixIcon: const Icon(Icons.numbers),
//           ),
//           readOnly: true,
//         );
//       // NÚMERO DECIMAL:
//       case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
//         return TextField(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//               vertical: $styles.insets.sm - 3,
//               horizontal: $styles.insets.xs + 2,
//             ),
//             hintText: '1.2, 1.4, 2.6, 3.6,...',
//             suffixIcon: const Icon(Icons.numbers),
//           ),
//           readOnly: true,
//         );
//       // DESCONOCIDO:
//       default:
//         return Text('Tipo de formulario desconocido', style: $styles.textStyles.title2);
//     }
//   }
// }
