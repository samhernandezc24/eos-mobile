// part of '../../pages/configuracion/categorias/categorias_page.dart';

// class _ListTile extends StatelessWidget {
//   const _ListTile({Key? key, this.categoria, this.inspeccionTipo, this.onCategoriaPressed}) : super(key: key);

//   final CategoriaEntity? categoria;
//   final InspeccionTipoEntity? inspeccionTipo;
//   final void Function(InspeccionTipoEntity inspeccionTipo, CategoriaEntity categoria)? onCategoriaPressed;

//   // METHODS
//   Future<void> _showFailedMessageDialog(BuildContext context, RemoteCategoriaServerFailedMessage state) {
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
//                 state.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar la categoría de nuevo.',
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

//   Future<void> _showFailureDialog(BuildContext context, RemoteCategoriaServerFailure state) {
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
//                 state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar la categoría de nuevo.',
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

//   void _handleDeletePressed(BuildContext context, CategoriaEntity? categoria) {
//     // Cerramos el modal bottom sheet.
//     Navigator.pop(context);

//     // Mostramos el AlertDialog.
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
//           listener: (BuildContext context, RemoteCategoriaState state) {
//             if (state is RemoteCategoriaServerFailedMessage) {
//               _showFailedMessageDialog(context, state);
//             }

//             if (state is RemoteCategoriaServerFailure) {
//                _showFailureDialog(context, state);
//             }

//             if (state is RemoteCategoriaDeleted) {
//               // Cerramos el AlertDialog.
//               Navigator.pop(context);

//               ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(
//                   content: Text(state.objResponse?.message ?? '', softWrap: true),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.fixed,
//                   elevation: 0,
//                 ),
//               );

//               context.read<RemoteCategoriaBloc>().add(ListCategorias(inspeccionTipo!));
//             }
//           },
//           builder: (BuildContext context, RemoteCategoriaState state) {
//             if (state is RemoteCategoriaDeleting) {
//               return AlertDialog(
//                 content: Row(
//                   children: <Widget>[
//                     const AppLoadingIndicator(width: 20, height: 20),
//                     SizedBox(width: $styles.insets.xs + 2),
//                     Flexible(
//                       child: Text('Espere por favor...', style: $styles.textStyles.title2.copyWith(height: 1.5)),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             return AlertDialog(
//               title: Text('¿Eliminar categoría?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
//               content: RichText(
//                 text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
//                   children: <InlineSpan>[
//                     const TextSpan(text: 'Se eliminará la categoría '),
//                     TextSpan(
//                       text: '"${categoria!.name.toProperCase()}". ',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const TextSpan(text: '¿Estás seguro de querer realizar esa acción?'),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => _onRemove(context),
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

//   void _handleModalBottomSheet(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all($styles.insets.sm),
//               child: Center(
//                 child: Text(
//                   categoria?.name.toProperCase() ?? '',
//                   style: $styles.textStyles.h3.copyWith(fontSize: 18),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//             ListTile(
//               onTap: _onTap,
//               leading: const Icon(Icons.add),
//               title: Text($strings.createCategoryItemButtonText),
//             ),
//             ListTile(
//               onTap: () => _handleEditPressed(context, categoria, inspeccionTipo),
//               leading: const Icon(Icons.edit),
//               title: Text($strings.editButtonText),
//             ),
//             ListTile(
//               onTap: () => _handleDeletePressed(context, categoria),
//               leading: const Icon(Icons.delete),
//               textColor: Theme.of(context).colorScheme.error,
//               iconColor: Theme.of(context).colorScheme.error,
//               title: Text($strings.deleteButtonText),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _handleEditPressed(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
//     // Cerramos el modal bottom sheet.
//     Navigator.pop(context);

//     // Mostramos el FormModal para la edición.
//     Navigator.push<void>(
//       context,
//       PageRouteBuilder<void>(
//         transitionDuration: $styles.times.pageTransition,
//         pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//           const Offset begin  = Offset(0, 1);
//           const Offset end    = Offset.zero;
//           const Cubic curve   = Curves.ease;

//           final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

//           return SlideTransition(
//             position: animation.drive<Offset>(tween),
//             child: FormModal(
//               title: 'Editar categoría',
//               child: _UpdateForm(categoria: categoria, inspeccionTipo: inspeccionTipo),
//             ),
//           );
//         },
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   void _onTap() {
//     if (onCategoriaPressed != null) return onCategoriaPressed!(inspeccionTipo!, categoria!);
//   }

//   void _onRemove(BuildContext context) {
//     BlocProvider.of<RemoteCategoriaBloc>(context).add(DeleteCategoria(categoria!));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap   : _onTap,
//       leading : CircleAvatar(
//         child : Text(categoria?.orden.toString() ?? '0', style: $styles.textStyles.h4),
//       ),
//       title   : Text(categoria?.name.toProperCase() ?? '', softWrap: true),
//       trailing: IconButton(
//         icon      : const Icon(Icons.more_vert),
//         onPressed : () => _handleModalBottomSheet(context, categoria, inspeccionTipo),
//       ),
//     );
//   }
// }
