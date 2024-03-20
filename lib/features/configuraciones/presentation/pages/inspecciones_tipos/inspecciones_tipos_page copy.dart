// import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
// import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
// import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias/categorias_page.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion_tipo_form.dart';
// import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspeccion_tipo_tile.dart';
// import 'package:eos_mobile/shared/shared.dart';

// class ConfiguracionesInspeccionesTiposPage extends StatefulWidget {
//   const ConfiguracionesInspeccionesTiposPage({super.key});

//   @override
//   State<ConfiguracionesInspeccionesTiposPage> createState() =>
//       _ConfiguracionesInspeccionesTiposPageState();
// }

// class _ConfiguracionesInspeccionesTiposPageState
//     extends State<ConfiguracionesInspeccionesTiposPage> {
//   Future<void> _onInspeccionTipoPressed(
//       BuildContext context, InspeccionTipoReqEntity inspeccionTipoReq) async {
//     Future.delayed($styles.times.pageTransition, () {
//       Navigator.of(context).push<void>(
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => ConfiguracionesCategoriasPage(
//             inspeccionTipoReq: inspeccionTipoReq,
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Configuración de Inspecciones',
//           style: $styles.textStyles.h3,
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Container(
//             height: 100,
//             alignment: Alignment.center,
//             color: Theme.of(context).colorScheme.background,
//             child: FilledButton.icon(
//               onPressed: () {
//                 Navigator.of(context).push<void>(
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) {
//                       return const BasicModal(
//                         title: 'Nuevo Tipo de Inspección',
//                         child: CreateInspeccionTipoForm(),
//                       );
//                     },
//                     fullscreenDialog: true,
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.add),
//               label: Text(
//                 'Crear Tipo Inspección',
//                 style: $styles.textStyles.button,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all($styles.insets.sm),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Listado de Tipos de Inspecciones',
//                   style: $styles.textStyles.title1
//                       .copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 Gap($styles.insets.xxs),
//                 Text(
//                   'Crear un tipo de inspección para agrupar los formularios de las inspecciones.',
//                   style: $styles.textStyles.bodySmall.copyWith(height: 1.5),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 BlocProvider.of<RemoteInspeccionTipoBloc>(context)
//                     .add(FetcInspeccionesTipos());
//               },
//               child: BlocBuilder<RemoteInspeccionTipoBloc,
//                   RemoteInspeccionTipoState>(
//                 builder:
//                     (BuildContext context, RemoteInspeccionTipoState state) {
//                   if (state is RemoteInspeccionTipoLoading) {
//                     return Center(
//                       child: LoadingIndicator(
//                         color: Theme.of(context).primaryColor,
//                         strokeWidth: 2,
//                       ),
//                     );
//                   }

//                   if (state is RemoteInspeccionTipoFailure) {
//                     return Center(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: $styles.insets.lg),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(
//                               Icons.error_outline,
//                               color: Theme.of(context).colorScheme.error,
//                               size: 64,
//                             ),
//                             Gap($styles.insets.xxs),
//                             Text('Oops, algo salió mal...',
//                                 style: $styles.textStyles.h4),
//                             Gap($styles.insets.xxs),
//                             Text(
//                               '${state.failure!.message}',
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 6,
//                               style: $styles.textStyles.bodySmall,
//                             ),
//                             Gap($styles.insets.md),
//                             FilledButton(
//                               onPressed: () {
//                                 BlocProvider.of<RemoteInspeccionTipoBloc>(
//                                   context,
//                                 ).add(FetcInspeccionesTipos());
//                               },
//                               child: Text(
//                                 'Volver a intentar',
//                                 style: $styles.textStyles.button,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }

//                   if (state is RemoteInspeccionTipoDone) {
//                     if (state.inspeccionesTipos!.isEmpty) {
//                       return Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: $styles.insets.lg),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.info_outline,
//                                 color: Theme.of(context).colorScheme.secondary,
//                                 size: 64,
//                               ),
//                               Gap($styles.insets.sm),
//                               Text(
//                                 'Aún no hay tipos de inspecciones registrados.',
//                                 textAlign: TextAlign.center,
//                                 style: $styles.textStyles.h4,
//                               ),
//                               Gap($styles.insets.md),
//                               FilledButton(
//                                 onPressed: () {
//                                   BlocProvider.of<RemoteInspeccionTipoBloc>(
//                                     context,
//                                   ).add(FetcInspeccionesTipos());
//                                 },
//                                 child: Text(
//                                   'Actualizar página',
//                                   style: $styles.textStyles.button,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       return ListView.separated(
//                         itemBuilder: (BuildContext context, int index) {
//                           return InspeccionTipoTile(
//                             inspeccionTipo: state.inspeccionesTipos![index],
//                             onInspeccionTipoPressed: (inspeccionTipoReq) =>
//                                 _onInspeccionTipoPressed(
//                               context,
//                               inspeccionTipoReq,
//                             ),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) =>
//                             const Divider(),
//                         itemCount: state.inspeccionesTipos!.length,
//                       );
//                     }
//                   }

//                   return const SizedBox();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
