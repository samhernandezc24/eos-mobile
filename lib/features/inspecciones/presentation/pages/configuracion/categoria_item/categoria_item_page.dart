import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';
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
  bool _isLoading       = false;
  bool _hasServerError  = false;

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

  Future<void> _handleDeletePressed(BuildContext context, CategoriaItemEntity objCategoriaItem, CategoriaItemParamsEntity objPost) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text(AppStrings.categoriaItemDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(
              style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
              children  : <InlineSpan>[
                const TextSpan(text: AppStrings.categoriaItemDeleteAlertFirstText),
                TextSpan(
                  text: '"${objCategoriaItem.name}"\n',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: AppStrings.categoriaItemDeleteAlertSecondText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => context.read<RemoteCategoriaItemBloc>().add(DeleteCategoriaItem(objPost)),
              child     : Text(AppStrings.btnDeleteText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
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

  Future<void> _storeDuplicate(CategoriaItemStoreDuplicateReqEntity objPost) async {
    context.read<RemoteCategoriaItemBloc>().add(StoreDuplicateCategoriaItem(objPost));
  }

  Future<void> _update(CategoriaItemUpdateReqEntity objPost) async {
    context.read<RemoteCategoriaItemBloc>().add(UpdateCategoriaItem(objPost));
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

                  if (state is RemoteCategoriaItemStoreDuplicateLoading) {
                    _showProgressDialog(context);
                  }

                  if (state is RemoteCategoriaItemUpdateLoading) {
                    _showProgressDialog(context);
                  }

                  if (state is RemoteCategoriaItemDeleteLoading) {
                    _showProgressDialog(context);
                  }

                  // ERROR
                  if (state is RemoteCategoriaItemServerFailedMessageList || state is RemoteCategoriaItemServerExceptionMessageList) {
                    setState(() {
                      _hasServerError = true;
                      _isLoading      = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageStoreDuplicate) {
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error);

                    // Actualizamos la lista.
                    _list();
                  }

                  if (state is RemoteCategoriaItemServerExceptionMessageStoreDuplicate) {
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error?.message);

                    // Actualizamos la lista.
                    _list();
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageUpdate) {
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error);

                    // Actualizamos la lista.
                    _list();
                  }

                  if (state is RemoteCategoriaItemServerExceptionMessageUpdate) {
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error?.message);

                    // Actualizamos la lista.
                    _list();
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageDelete) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error);

                    // Actualizamos la lista.
                    _list();
                  }

                  if (state is RemoteCategoriaItemServerExceptionMessageDelete) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    _showServerErrorDialog(context, state.error?.message);

                    // Actualizamos la lista.
                    _list();
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaItemList) {
                    setState(() {
                      _hasServerError   = false;
                      _isLoading        = false;

                      // LISTAS DE COMBOBOX
                      lstCategoriasItems  = state.objResponse?.categoriasItems  ?? [];
                      lstFormulariosTipos = state.objResponse?.formulariosTipos ?? [];
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemStoreDuplicate) {
                    Navigator.of(context).pop(); // Cerramos el dialog

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          state.objResponse?.message ?? 'Pregunta duplicada',
                          style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                          softWrap  : true,
                        ),
                        backgroundColor : $styles.colors.success,
                        elevation       : 0,
                        behavior        : SnackBarBehavior.fixed,
                      ),
                    );

                    // Actualizamos la lista.
                    _list();

                    setState(() {
                      _isLoading          = false;
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemUpdate) {
                    Navigator.of(context).pop(); // Cerramos el dialog

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          state.objResponse?.message ?? 'Actualizado',
                          style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                          softWrap  : true,
                        ),
                        backgroundColor : $styles.colors.success,
                        elevation       : 0,
                        behavior        : SnackBarBehavior.fixed,
                      ),
                    );

                    // Actualizamos la lista.
                    _list();

                    setState(() {
                      _isLoading          = false;
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemDelete) {
                    Navigator.of(context).pop(); // Cerramos el dialog
                    Navigator.of(context).pop(); // Cerramos el dialog

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          state.objResponse?.message ?? 'Eliminado',
                          style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                          softWrap  : true,
                        ),
                        backgroundColor : $styles.colors.success,
                        elevation       : 0,
                        behavior        : SnackBarBehavior.fixed,
                      ),
                    );

                    // Actualizamos la lista.
                    _list();

                    setState(() {
                      _isLoading          = false;
                    });

                    _scrollToEnd();
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
                        final CategoriaItemEntity objCategoriaItem = lstCategoriasItems[index];
                        return _ListCategoriaItemCard(
                          objCategoriaItem    : objCategoriaItem,
                          formulariosTipos    : lstFormulariosTipos,
                          onDuplicatePressed  : (CategoriaItemStoreDuplicateReqEntity objPost)      => _storeDuplicate(objPost),
                          onUpdatePressed     : (CategoriaItemUpdateReqEntity objPost)              => _update(objPost),
                          onDeletePressed     : (CategoriaItemParamsEntity objCategoriaItemParams)  => _handleDeletePressed(context, objCategoriaItem, objCategoriaItemParams),
                          orden               : lstCategoriasItems.length + 1,
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
      floatingActionButton: !_hasServerError && !_isLoading ? _buildFloatingActionButton(context) : null,
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
