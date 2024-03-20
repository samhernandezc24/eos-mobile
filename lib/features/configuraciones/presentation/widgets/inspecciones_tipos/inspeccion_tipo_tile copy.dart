// import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
// import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
// import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/widgets/update_inspeccion_tipo_form.dart';
// import 'package:eos_mobile/shared/shared.dart';

// class InspeccionTipoTile extends StatelessWidget {
//   const InspeccionTipoTile({
//     Key? key,
//     this.inspeccionTipo,
//     this.inspeccionTipoReq,
//     this.onInspeccionTipoPressed,
//     this.isRemovable = false,
//     this.onRemove,
//   }) : super(key: key);

//   final InspeccionTipoEntity? inspeccionTipo;
//   final InspeccionTipoReqEntity? inspeccionTipoReq;
//   final bool? isRemovable;
//   final void Function(InspeccionTipoEntity inspeccionTipo)? onRemove;
//   final void Function(InspeccionTipoReqEntity inspeccionTipoReq)? onInspeccionTipoPressed;

//   void _onTap() {
//     if (onInspeccionTipoPressed != null) {
//       if (onInspeccionTipoPressed != null) {
//         // ignore: prefer_null_aware_method_calls
//         onInspeccionTipoPressed!(const InspeccionTipoReqEntity());
//       }
//     }
//   }

//   void _onRemoveInspeccionTipo(
//       BuildContext context, InspeccionTipoReqEntity inspeccionTipoReq) {
//     BlocProvider.of<RemoteInspeccionTipoBloc>(context)
//         .add(DeleteInspeccionTipo(inspeccionTipoReq));
//     BlocProvider.of<RemoteInspeccionTipoBloc>(context)
//         .add(const FetcInspeccionesTipos());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.transparent,
//         child: Image.asset(
//           ImagePaths.circleVehicle,
//         ),
//       ),
//       title: Text(
//         inspeccionTipo!.name.toProperCase(),
//         overflow: TextOverflow.ellipsis,
//       ),
//       subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
//       onTap: _onTap,
//       trailing: IconButton(
//         icon: const Icon(Icons.more_vert),
//         onPressed: () {
//           showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return Container(
//                 padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
//                 height: 250,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       'Folio: ${inspeccionTipo!.folio}',
//                       textAlign: TextAlign.center,
//                       style: $styles.textStyles.h3,
//                     ),
//                     Gap($styles.insets.sm),
//                     ListTile(
//                       leading: const Icon(Icons.add),
//                       title: const Text('Crear categoría'),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.edit),
//                       title: const Text('Editar'),
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push<void>(
//                           MaterialPageRoute<void>(
//                             builder: (BuildContext context) {
//                               return BasicModal(
//                                 title: 'Editar: ${inspeccionTipo!.folio}',
//                                 child: UpdateInspeccionTipoForm(
//                                     inspeccionTipo: inspeccionTipo),
//                               );
//                             },
//                             fullscreenDialog: true,
//                           ),
//                         );
//                       },
//                     ),
//                     BlocConsumer<RemoteInspeccionTipoBloc,
//                         RemoteInspeccionTipoState>(
//                       listener: (context, state) {
//                         if (state is RemoteInspeccionTipoFailure &&
//                             state is DeleteInspeccionTipo) {
//                           ScaffoldMessenger.of(context)
//                             ..hideCurrentSnackBar()
//                             ..showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   state.failure?.response?.data.toString() ??
//                                       'Ha ocurrido un error al eliminar el tipo de inspección.',
//                                 ),
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.error,
//                               ),
//                             );

//                           context
//                               .read<RemoteInspeccionTipoBloc>()
//                               .add(const FetcInspeccionesTipos());
//                         }

//                         if (state is RemiteInspeccionTipoFailedMessage &&
//                             state is DeleteInspeccionTipo) {
//                           ScaffoldMessenger.of(context)
//                             ..hideCurrentSnackBar()
//                             ..showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   state.errorMessage.toString(),
//                                 ),
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.error,
//                               ),
//                             );

//                           context
//                               .read<RemoteInspeccionTipoBloc>()
//                               .add(const FetcInspeccionesTipos());
//                         }

//                         if (state is RemoteInspeccionResponseDone &&
//                             state is DeleteInspeccionTipo) {
//                           ScaffoldMessenger.of(context)
//                             ..hideCurrentSnackBar()
//                             ..showSnackBar(
//                               SnackBar(
//                                 content: Text(state.apiResponse.message),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );

//                           // Emitir un evento para actualizar el listado
//                           context
//                               .read<RemoteInspeccionTipoBloc>()
//                               .add(const FetcInspeccionesTipos());
//                         }
//                       },
//                       builder: (context, state) {
//                         return ListTile(
//                           textColor: Theme.of(context).colorScheme.error,
//                           iconColor: Theme.of(context).colorScheme.error,
//                           leading: const Icon(Icons.delete),
//                           title: const Text('Eliminar'),
//                           onTap: () {
//                             Navigator.pop(context);
//                             showDialog<void>(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text(
//                                     'Confirmar eliminación',
//                                     style: $styles.textStyles.h3,
//                                   ),
//                                   content: Text(
//                                     '¿Estás seguro de que deseas eliminar este tipo de inspección?',
//                                     style: $styles.textStyles.body,
//                                   ),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text(
//                                         'Cancelar',
//                                         style: $styles.textStyles.button,
//                                       ),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         _onRemoveInspeccionTipo(
//                                           context,
//                                           InspeccionTipoReqEntity(
//                                             idInspeccionTipo: inspeccionTipo!
//                                                 .idInspeccionTipo,
//                                           ),
//                                         );
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text(
//                                         'Eliminar',
//                                         style: $styles.textStyles.button,
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
