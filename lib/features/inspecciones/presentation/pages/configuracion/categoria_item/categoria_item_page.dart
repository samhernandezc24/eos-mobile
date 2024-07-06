import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/categoria_item/remote_categoria_item_bloc.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part '../../../widgets/configuracion/categoria_item/_list_card.dart';

class InspeccionConfiguracionCategoriaItemPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriaItemPage({Key? key, this.objCategoria}) : super(key: key);

  final CategoriaEntity? objCategoria;

  @override
  State<InspeccionConfiguracionCategoriaItemPage> createState() => _InspeccionConfiguracionCategoriaItemPage();
}

class _InspeccionConfiguracionCategoriaItemPage extends State<InspeccionConfiguracionCategoriaItemPage> {
  // CONTROLLERS
  late final ScrollController _scrollController;

  // LIST
  List<CategoriaItemEntity> lstCategoriasItems  = [];
  List<FormularioTipo> lstFormulariosTipos      = [];

  // PROPERTIES
  bool _isLoading = false;

  // STATE
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _list();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleAddPressed() {
    _store();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: $styles.times.slow, curve: Curves.easeOut);
      }
    });
  }

  void _showProgressDialog(BuildContext context) {
    showDialog<void>(
      context             : context,
      barrierDismissible  : false,
      builder: (BuildContext context) {
        return Dialog(
          shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
          elevation : 0,
          child     : Container(
            padding : EdgeInsets.all($styles.insets.xs),
            child   : Column(
              mainAxisSize  : MainAxisSize.min,
              children      : <Widget>[
                Container(
                  margin  : EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  child   : const AppLoadingIndicator(),
                ),
                Container(
                  margin  : EdgeInsets.only(bottom: $styles.insets.xs),
                  child   : Text(AppStrings.appPageProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _list() async {
    final CategoriaIdParamEntity objPost = CategoriaIdParamEntity(idCategoria: widget.objCategoria?.idCategoria ?? '');
    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(objPost));
  }

  Future<void> _store() async {
    final String pregunta = _generarNombrePregunta();

    final CategoriaItemStoreReqEntity objPost = CategoriaItemStoreReqEntity(
      name          : pregunta,
      idCategoria   : widget.objCategoria?.idCategoria  ?? '',
      categoriaName : widget.objCategoria?.name         ?? '',
      orden         : lstCategoriasItems.length + 1,
    );

    context.read<RemoteCategoriaItemBloc>().add(StoreCategoriaItem(objPost));
  }

  String _generarNombrePregunta() {
    String pregunta = 'Pregunta';
    int contador = 1;
    while (lstCategoriasItems.any((e) => e.name == pregunta)) {
      pregunta = 'Pregunta ($contador)';
      contador++;
    }
    return pregunta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.categoriaItemAppBarTitle, style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.objCategoria?.inspeccionTipoName}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Categoría', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.objCategoria?.name}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: const <TextSpan>[
                      TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${AppStrings.categoriaItemBoxDescription}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _list,
              child: BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                listener: (BuildContext context, RemoteCategoriaItemState state) {
                  // LOADING
                  if (state is RemoteCategoriaItemLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaItemList) {
                    setState(() {
                      _isLoading          = false;
                      lstCategoriasItems  = state.objResponse?.categoriasItems  ?? [];
                      lstFormulariosTipos = state.objResponse?.formulariosTipos ?? [];
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemStore) {
                    // Actualizar listado
                    _list();
                  }
                },
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  // LOADING
                  if (state is RemoteCategoriaItemLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  // ERROR
                  if (state is RemoteCategoriaItemServerFailedMessageList) {
                    return ErrorServerMessage(onPressed: _list, message: state.error);
                  }

                  if (state is RemoteCategoriaItemServerExceptionMessageList) {
                    return ErrorServerMessage(onPressed: _list, message: state.error?.message);
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaItemList) {
                    if (lstCategoriasItems.isEmpty) {
                      return EmptyListMessage(
                        title         : AppStrings.categoriaItemEmptyListTitle,
                        message       : AppStrings.emptyListSyncMessage,
                        onRefresh     : _list,
                      );
                    }

                    return ListView.builder(
                      controller  : _scrollController,
                      itemCount   : lstCategoriasItems.length,
                      itemBuilder : (BuildContext context, int index) {
                        return _ListCategoriaItemCard(
                          objCategoriaItem  : lstCategoriasItems[index],
                          formulariosTipos  : lstFormulariosTipos,
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (BuildContext context, RemoteCategoriaItemState state) {
        // ERROR
        if (state is RemoteCategoriaItemServerFailedMessageStore) {
          _showServerErrorDialog(context, state.error);

          // Actualizar lista.
          _list();
        }

        if (state is RemoteCategoriaItemServerExceptionMessageStore) {
          _showServerErrorDialog(context, state.error?.message);

          // Actualizar lista.
          _list();
        }

        // SUCCESS
        if (state is RemoteCategoriaItemStore) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                state.objResponse?.message ?? 'Nueva pregunta',
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                softWrap  : true,
              ),
              backgroundColor : $styles.colors.success,
              elevation       : 0,
              behavior        : SnackBarBehavior.fixed,
            ),
          );

          // Actualizar lista.
          _list();
        }
      },
      builder: (BuildContext context, RemoteCategoriaItemState state) {
        return FloatingActionButton(
          onPressed : state is RemoteCategoriaItemStoreLoading ? null : _handleAddPressed,
          tooltip   : AppStrings.categoriaItemCreateTooltip,
          child     : state is RemoteCategoriaItemStoreLoading ? const AppLoadingIndicator(width: 20, height: 20,) : const Icon(Icons.add),
        );
      },
    );
  }
}
