import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/request_data_unavailable.dart';

part '../../../widgets/categoria_item/_list_tile.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  @override
  void initState() {
    super.initState();

    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
  }

  // METHODS
  void _handleCreateItemPressed(BuildContext context) {
    final CategoriaItemStoreReqEntity objData = CategoriaItemStoreReqEntity(
      idCategoria   : widget.categoria?.idCategoria ?? '',
      categoriaName : widget.categoria?.name        ?? '',
    );

    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreCategoriaItem(objData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text($strings.categoryItemAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.categoryItemTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoryItemDescription}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh : () async => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
              child     : BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                listener: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemSuccess) {

                  }
                },
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteCategoriaItemServerFailedMessage) {
                    return _buildServerFailedMessageCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemServerFailure) {
                    return _buildServerFailureCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    if (state.objResponse != null && state.objResponse!.isNotEmpty) {
                      return ListView.builder(
                        itemCount   : state.objResponse!.length,
                        itemBuilder : (BuildContext context, int index) {
                          return _ListTile(
                            categoria          : state.objResponse![index],
                            inspeccionTipo     : widget.inspeccionTipo,
                            // onCategoriaPressed : (inspeccionTipo) => _onCategoriaPressed(context, inspeccionTipo, categoria),
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.categoryEmptyTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!)),
                      );
                    }
                  }
                  return const SizedBox.shrink(); // No devolver nada, si el state no se completó
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailedMessageCategoriaItem(BuildContext context, RemoteCategoriaItemServerFailedMessage state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              $strings.error500Title,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailureCategoriaItem(BuildContext context, RemoteCategoriaItemServerFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              $strings.error500Title,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}

// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria_item/categoria_item_tile.dart';
// import 'package:eos_mobile/shared/shared_libraries.dart';

// class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
//   const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.inspeccionTipo, this.categoria}) : super(key: key);

//   final InspeccionTipoEntity? inspeccionTipo;
//   final CategoriaEntity? categoria;

//   @override
//   State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
// }

// class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
//   /// LIST
//   late List<CategoriaItemEntity> lstCategoriasItems     = <CategoriaItemEntity>[];
//   late List<FormularioTipoEntity> lstFormulariosTipos   = <FormularioTipoEntity>[];

//   /// PROPERTIES
//   bool _dataLoaded = false;

//   @override
//   void initState() {
//     super.initState();
//     context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
//   }

//   /// METHODS
//   void _handleCreateCategoriaItem(BuildContext context) {
//     final CategoriaItemReqEntity objCategoriaItemData = CategoriaItemReqEntity(
//       idInspeccionTipo    : widget.inspeccionTipo?.idInspeccionTipo ?? '',
//       inspeccionTipoName  : widget.inspeccionTipo?.name ?? '',
//       idCategoria         : widget.categoria?.idCategoria ?? '',
//       categoriaName       : widget.categoria?.name ?? '',
//     );

//     context.read<RemoteCategoriaItemBloc>().add(StoreCategoriaItem(objCategoriaItemData));
//   }

//   // void _scrollToNewCategoriaItem(int index) {
//   //   if (_scrollController.hasClients) {
//   //     _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: $styles.times.fast, curve: Curves.easeInOut);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Configuración de preguntas', style: $styles.textStyles.h3)),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // HEADER INFORMATIVO:
//           _buildHeaderContent(),

//           // LISTADO DE CATEGORIAS ITEMS:
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 return BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
//               },
//               child: BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
//                 listener: (BuildContext context, RemoteCategoriaItemState state) {
//                   if (state is RemoteCategoriaItemSuccess) {
//                     setState(() {
//                       lstCategoriasItems  = state.objCategoriaItem!.categoriasItems!;
//                       lstFormulariosTipos = state.objCategoriaItem!.formulariosTipos!;

//                       _dataLoaded = true;
//                     });
//                   }
//                 },
//                 builder: (BuildContext context, RemoteCategoriaItemState state) {
//                   if (state is RemoteCategoriaItemLoading) {
//                     return const Center(child: AppLoadingIndicator());
//                   }

//                   if (state is RemoteCategoriaItemFailure) {
//                     return _buildFailureCategoriaItem(context, state);
//                   }

//                   if (state is RemoteCategoriaItemFailedMessage) {
//                     return _buildFailedMessageCategoriaItem(context, state);
//                   }

//                   if (state is RemoteCategoriaItemSuccess) {
//                     if (lstCategoriasItems.isEmpty) {
//                       return _buildEmptyCategoriasItems(context);
//                     } else {
//                       return ListView.builder(
//                         itemCount: lstCategoriasItems.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final CategoriaItemEntity categoriaItem = lstCategoriasItems[index];

//                           return CategoriaItemTile(
//                             categoriaItem: categoriaItem,
//                             inspeccionTipo: widget.inspeccionTipo,
//                             categoria: widget.categoria,
//                             formulariosTipos: lstFormulariosTipos,
//                           );
//                         },
//                       );
//                     }
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       // AGREGAR NUEVA CATEGORÍA ITEM:
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: _dataLoaded ? _buildFloatingActionButton(context) : null,
//     );
//   }

//   Widget _buildHeaderContent() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all($styles.insets.sm),
//       color: Theme.of(context).colorScheme.background,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // TITULO:
//           Text($strings.categoryItemTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

//           RichText(
//             text: TextSpan(
//               style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: 'Tipo de inspección',
//                   style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(text: ': ${widget.inspeccionTipo?.name ?? ''}'),
//               ],
//             ),
//           ),

//           RichText(
//             text: TextSpan(
//               style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: 'Categoría',
//                   style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(text: ': ${widget.categoria?.name ?? ''}'),
//               ],
//             ),
//           ),

//           RichText(
//             text: TextSpan(
//               style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//               children: <InlineSpan>[
//                 TextSpan(
//                   text: $strings.settingsSuggestionsText,
//                   style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(text: ': ${$strings.categoryItemDescription}'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Center _buildEmptyCategoriasItems(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),

//           Gap($styles.insets.sm),

//           Text($strings.categoryItemEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

//           Container(
//             padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
//             child: Text(
//               $strings.emptyListMessage,
//               textAlign: TextAlign.center,
//             ),
//           ),

//           FilledButton.icon(
//             onPressed: () => BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFailureCategoriaItem(BuildContext context, RemoteCategoriaItemFailure state) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
//           Gap($styles.insets.sm),
//           Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
//             child: Text(
//               state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
//               overflow: TextOverflow.ellipsis,
//               maxLines: 10,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           FilledButton.icon(
//             onPressed: () => BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.retryButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFailedMessageCategoriaItem(BuildContext context, RemoteCategoriaItemFailedMessage state) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
//           Gap($styles.insets.sm),
//           Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
//             child: Text(
//               state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
//               overflow: TextOverflow.ellipsis,
//               maxLines: 10,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           FilledButton.icon(
//             onPressed: () => BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.retryButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFloatingActionButton(BuildContext context) {
//     return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
//       listener: (BuildContext context, RemoteCategoriaItemState state) {
//         if (state is RemoteCategoriaItemFailure) {
//           _buildFailureCategoriaItem(context, state);
//         }

//         if (state is RemoteCategoriaItemFailedMessage) {
//           _buildFailedMessageCategoriaItem(context, state);
//         }

//         if (state is RemoteCategoriaItemResponseSuccess) {
//           ScaffoldMessenger.of(context)
//           ..hideCurrentSnackBar()
//           ..showSnackBar(
//             SnackBar(
//               content: Text(state.apiResponse.message, softWrap: true),
//               backgroundColor: Colors.green,
//               behavior: SnackBarBehavior.fixed,
//               elevation: 0,
//             ),
//           );
//         }
//       },
//       builder: (BuildContext context, RemoteCategoriaItemState state) {
//         return FloatingActionButton(
//           onPressed: state is RemoteCategoriaItemLoading ? null : () => _handleCreateCategoriaItem(context),
//           tooltip: 'Agregar pregunta',
//           child: const Icon(Icons.add),
//         );
//       },
//     );
//   }
// }
