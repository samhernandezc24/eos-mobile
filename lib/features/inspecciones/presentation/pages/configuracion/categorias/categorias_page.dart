import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias_items/categorias_items_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria/categoria_tile.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria/create_categoria_form.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionConfiguracionCategoriasPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasPage({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<InspeccionConfiguracionCategoriasPage> createState() =>  _InspeccionConfiguracionCategoriasPageState();
}

class _InspeccionConfiguracionCategoriasPageState extends State<InspeccionConfiguracionCategoriasPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!));
  }

  /// METHODS
  // void _handleCreatePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
  //   Navigator.push<void>(
  //     context,
  //     PageRouteBuilder<void>(
  //       transitionDuration: $styles.times.pageTransition,
  //       pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
  //         const Offset begin  = Offset(0, 1);
  //         const Offset end    = Offset.zero;
  //         const Cubic curve   = Curves.ease;

  //         final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

  //         return SlideTransition(
  //           position: animation.drive<Offset>(tween),
  //           child: FormModal(
  //             title: 'Nueva categoría',
  //             child: CreateCategoriaForm(inspeccionTipo: inspeccionTipo),
  //           ),
  //         );
  //       },
  //       fullscreenDialog: true,
  //     ),
  //   );
  // }

  // void _onCategoriaPressed(BuildContext context, InspeccionTipoEntity inspeccionTipo, CategoriaEntity categoria) {
  //   Future.delayed($styles.times.pageTransition, () {
  //     Navigator.push<void>(context, MaterialPageRoute(builder: (_) => InspeccionConfiguracionCategoriasItemsPage(inspeccionTipo: inspeccionTipo, categoria: categoria)));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de categorías', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all($styles.insets.sm),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.categoryTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Tipo de inspección',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${widget.inspeccionTipo?.name ?? ''}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Código tipo de inspección',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${widget.inspeccionTipo?.codigo ?? ''}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoryDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    onPressed: () {},
                    // onPressed: () => _handleCreatePressed(context, widget.inspeccionTipo),
                    icon: const Icon(Icons.add),
                    label: Text('Crear categoría', style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!));
              },
              child: BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  if (state is RemoteCategoriaLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteCategoriaServerFailedMessage) {
                    _buildFailedMessageCategoria(context, state);
                  }

                  if (state is RemoteCategoriaServerFailure) {
                    _buildFailureCategoria(context, state);
                  }

                  if (state is RemoteCategoriaSuccess) {
                    if (state.categorias != null && state.categorias!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.categorias!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriaTile(
                            categoria: state.categorias![index],
                            inspeccionTipo: widget.inspeccionTipo,
                            // onCategoriaPressed: (inspeccionTipo, categoria) => _onCategoriaPressed(context, inspeccionTipo, categoria),
                          );
                        },
                      );
                    } else {
                      return _buildEmptyCategoria(context);
                    }
                  }

                  return const SizedBox.shrink(); // No devolver nada
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedMessageCategoria(BuildContext context, RemoteCategoriaServerFailedMessage state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureCategoria(BuildContext context, RemoteCategoriaServerFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Center _buildEmptyCategoria(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),
          Gap($styles.insets.sm),
          Text($strings.categoryEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              $strings.emptyListMessage,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
            icon: const Icon(Icons.refresh),
            label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}

// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
// import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias_items/categorias_items_page.dart';

// import 'package:eos_mobile/shared/shared_libraries.dart';

// part '../../../widgets/categoria/_list_tile.dart';
// part '../../../widgets/categoria/_create_form.dart';
// part '../../../widgets/categoria/_update_form.dart';

// class InspeccionConfiguracionCategoriasPage extends StatefulWidget {
//   const InspeccionConfiguracionCategoriasPage({Key? key,this.inspeccionTipo}) : super(key: key);

//   final InspeccionTipoEntity? inspeccionTipo;

//   @override
//   State<InspeccionConfiguracionCategoriasPage> createState() =>  _InspeccionConfiguracionCategoriasPageState();
// }

// class _InspeccionConfiguracionCategoriasPageState extends State<InspeccionConfiguracionCategoriasPage> {

//   @override
//   void initState() {
//     super.initState();
//     context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
//   }

//   /// METHODS
//   void _handleCreatePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
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
//               title: 'Nueva categoría',
//               child: _CreateForm(inspeccionTipo: inspeccionTipo),
//             ),
//           );
//         },
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   void _onCategoriaPressed(BuildContext context, InspeccionTipoEntity inspeccionTipo, CategoriaEntity categoria) {
//     Future.delayed($styles.times.pageTransition, () {
//       // Navigator.push<void>(context, MaterialPageRoute(builder: (_) => InspeccionConfiguracionCategoriasItemsPage(inspeccionTipo: inspeccionTipo, categoria: categoria)));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Configuración de categorías', style: $styles.textStyles.h3)),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all($styles.insets.sm),
//             color: Theme.of(context).colorScheme.background,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text($strings.categoryTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//                 Gap($styles.insets.xxs),
//                 RichText(
//                   text: TextSpan(
//                     style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//                     children: [
//                       const TextSpan(
//                         text: 'Tipo de inspección',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: ': ${widget.inspeccionTipo?.name ?? ''}'),
//                     ],
//                   ),
//                 ),
//                 Gap($styles.insets.xxs),
//                 RichText(
//                   text: TextSpan(
//                     style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//                     children: [
//                       const TextSpan(
//                         text: 'Código tipo de inspección',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: ': ${widget.inspeccionTipo?.codigo ?? ''}'),
//                     ],
//                   ),
//                 ),
//                 Gap($styles.insets.xxs),
//                 RichText(
//                   text: TextSpan(
//                     style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
//                     children: <TextSpan>[
//                       TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
//                       TextSpan(text: ': ${$strings.categoryDescription}'),
//                     ],
//                   ),
//                 ),
//                 Gap($styles.insets.sm),
//                 Container(
//                   alignment: Alignment.center,
//                   child: FilledButton.icon(
//                     onPressed: () => _handleCreatePressed(context, widget.inspeccionTipo),
//                     icon: const Icon(Icons.add),
//                     label: Text('Crear categoría', style: $styles.textStyles.button),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!));
//               },
//               child: BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
//                 builder: (BuildContext context, RemoteCategoriaState state) {
//                   if (state is RemoteCategoriaLoading) {
//                     return const Center(child: AppLoadingIndicator());
//                   }

//                   if (state is RemoteCategoriaServerFailedMessage) {
//                     _buildFailedMessageCategoria(context, state);
//                   }

//                   if (state is RemoteCategoriaServerFailure) {
//                     _buildFailureCategoria(context, state);
//                   }

//                   if (state is RemoteCategoriaSuccess) {
//                     if (state.categorias != null && state.categorias!.isNotEmpty) {
//                       return ListView.builder(
//                         itemCount   : state.categorias!.length,
//                         itemBuilder : (BuildContext context, int index) {
//                           return _ListTile(
//                             categoria           : state.categorias![index],
//                             inspeccionTipo      : widget.inspeccionTipo,
//                             onCategoriaPressed  : (inspeccionTipo, categoria) => _onCategoriaPressed(context, inspeccionTipo, categoria),
//                           );
//                         },
//                       );
//                     } else {
//                       return _buildEmptyCategoria(context);
//                     }
//                   }
//                   return const SizedBox.shrink(); // No devolver nada
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFailedMessageCategoria(BuildContext context, RemoteCategoriaServerFailedMessage state) {
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
//             onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.retryButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFailureCategoria(BuildContext context, RemoteCategoriaServerFailure state) {
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
//             onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.retryButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }

//   Center _buildEmptyCategoria(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),
//           Gap($styles.insets.sm),
//           Text($strings.categoryEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
//             child: Text(
//               $strings.emptyListMessage,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           FilledButton.icon(
//             onPressed: () => BlocProvider.of<RemoteCategoriaBloc>(context).add(ListCategorias(widget.inspeccionTipo!)),
//             icon: const Icon(Icons.refresh),
//             label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
//           ),
//         ],
//       ),
//     );
//   }
// }
