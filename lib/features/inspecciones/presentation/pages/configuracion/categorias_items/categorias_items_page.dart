import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part '../../../widgets/categoria_item/list/_list_card.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  // CONTROLLERS
  late final ScrollController _scrollController;

  // LIST
  List<CategoriaItemEntity> lstCategoriasItems   = <CategoriaItemEntity>[];
  List<FormularioTipo> lstFormulariosTipos       = <FormularioTipo>[];

  // PROPERTIES
  bool _isLoading = true;

  // STATE
  @override
  void initState() {
    super.initState();
    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleStoreCategoriaItem() {
    _store();
  }

  Future<void> _handleDeletePressed(BuildContext context, CategoriaItemEntity categoriaItem) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text($strings.categoriaItemDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(
              style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
              children  : <InlineSpan>[
                TextSpan(text: $strings.categoriaItemDeleteAlertContent1),
                TextSpan(
                  text: '"${categoriaItem.name}."\n',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: $strings.categoriaItemDeleteAlertContent2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
              child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => context.read<RemoteCategoriaItemBloc>().add(DeleteCategoriaItem(categoriaItem)),
              child     : Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  void _handleStoreDuplicatePressed(CategoriaItemStoreDuplicateReqEntity objData) {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreDuplicateCategoriaItem(objData));
  }

  void _handleUpdatePressed(CategoriaItemEntity categoriaItem) {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(UpdateCategoriaItem(categoriaItem));
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: $styles.times.slow, curve: Curves.easeOut);
      }
    });
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado.',
      ),
    );
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
                  child   : const AppLoadingIndicator(width: 30, height: 30),
                ),
                Container(
                  margin  : EdgeInsets.only(bottom: $styles.insets.xs),
                  child   : Text($strings.appProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _generateNombrePregunta() {
    String pregunta = 'Pregunta';
    int contador = 1;
    while (lstCategoriasItems.any((item) => item.name == pregunta)) {
      pregunta = 'Pregunta ($contador)';
      contador++;
    }
    return pregunta;
  }

  // METHODS
  void _store() {
    final String pregunta = _generateNombrePregunta();

    final CategoriaItemStoreReqEntity objPost = CategoriaItemStoreReqEntity(
      name          : pregunta,
      idCategoria   : widget.categoria?.idCategoria ?? '',
      categoriaName : widget.categoria?.name        ?? '',
    );

    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreCategoriaItem(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text($strings.categoriaItemAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        crossAxisAlignment  : CrossAxisAlignment.start,
        children            : <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                Text($strings.categoriaItemBoxTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.categoria?.inspeccionTipoName ?? ''}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Categoría', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.categoria?.name ?? ''}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoriaItemBoxDescription}'),
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
                  // LOADING
                  if (state is RemoteCategoriaItemLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  }

                  if (state is RemoteCategoriaItemStoringDuplicate) {
                    _showProgressDialog(context);
                  }

                  if (state is RemoteCategoriaItemUpdating) {
                    _showProgressDialog(context);
                  }

                  if (state is RemoteCategoriaItemDeleting) {
                    _showProgressDialog(context);
                  }

                  // ERRORS:
                  if (state is RemoteCategoriaItemServerFailedMessageDuplicate) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailureDuplicate) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.failure?.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageUpdate) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailureUpdate) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.failure?.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageDelete) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailureDelete) {
                    Navigator.of(context).pop();

                    _showServerFailedDialog(context, state.failure?.errorMessage);

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  // SUCCESS:
                  if (state is RemoteCategoriaItemSuccess) {
                    setState(() {
                      _isLoading = false;
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemStoredDuplicate) {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(state.objResponse?.message ?? 'Pregunta duplicada', softWrap: true),
                        backgroundColor : Colors.green,
                        behavior        : SnackBarBehavior.fixed,
                        elevation       : 0,
                      ),
                    );

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemUpdated) {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(state.objResponse?.message ?? 'Pregunta actualizada', softWrap: true),
                        backgroundColor : Colors.green,
                        behavior        : SnackBarBehavior.fixed,
                        elevation       : 0,
                      ),
                    );

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });

                    _scrollToEnd();
                  }

                  if (state is RemoteCategoriaItemDeleted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(state.objResponse?.message ?? 'Pregunta eliminada', softWrap: true),
                        backgroundColor : Colors.green,
                        behavior        : SnackBarBehavior.fixed,
                        elevation       : 0,
                      ),
                    );

                    // Actualizando el listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });

                    _scrollToEnd();
                  }
                },
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteCategoriaItemServerFailedMessageList) {
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
                      errorMessage  : state.errorMessage,
                    );
                  }

                  if (state is RemoteCategoriaItemServerFailureList) {
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
                      errorMessage  : state.failure?.errorMessage,
                    );
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    lstCategoriasItems  = state.objResponse?.categoriasItems  ?? [];
                    lstFormulariosTipos = state.objResponse?.formulariosTipos ?? [];

                    if (lstCategoriasItems.isNotEmpty) {
                      return ListView.builder(
                        controller  : _scrollController,
                        itemCount   : lstCategoriasItems.length,
                        itemBuilder : (BuildContext context, int index) {
                          final CategoriaItemEntity categoriaItem = lstCategoriasItems[index];
                          return _ListCard(
                            categoriaItem       : categoriaItem,
                            categoria           : widget.categoria,
                            formulariosTipos    : lstFormulariosTipos,
                            onDuplicatePressed  : (CategoriaItemStoreDuplicateReqEntity objData) => _handleStoreDuplicatePressed(objData),
                            onUpdatePressed     : (CategoriaItemEntity categoriaItem) => _handleUpdatePressed(categoriaItem),
                            onDeletePressed     : (CategoriaItemEntity categoriaItem) => _handleDeletePressed(context, categoriaItem),
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.categoriaItemEmptyListTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation  : FloatingActionButtonLocation.startFloat,
      floatingActionButton          : _isLoading ? null : _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (BuildContext context, RemoteCategoriaItemState state) {
        // ERRORS:
        if (state is RemoteCategoriaItemServerFailedMessageStore) {
          _showServerFailedDialog(context, state.errorMessage);

          // Actualizando el listado de preguntas.
          context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

          setState(() {
            _isLoading = false;
          });
        }

        if (state is RemoteCategoriaItemServerFailureStore) {
          _showServerFailedDialog(context, state.failure?.errorMessage);

          // Actualizando el listado de preguntas.
          context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

          setState(() {
            _isLoading = false;
          });
        }

        // SUCCESS:
        if (state is RemoteCategoriaItemStored) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content         : Text(state.objResponse?.message ?? 'Nueva pregunta', softWrap: true),
              backgroundColor : Colors.green,
              elevation       : 0,
              behavior        : SnackBarBehavior.fixed,
            ),
          );

          // Actualizando el listado de preguntas.
          context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
        }
      },
      builder: (BuildContext context, RemoteCategoriaItemState state) {
        return FloatingActionButton(
          onPressed : state is RemoteCategoriaItemStoring ? null : _handleStoreCategoriaItem,
          tooltip   : 'Agregar pregunta',
          child     : state is RemoteCategoriaItemStoring
                        ? const AppLoadingIndicator(width: 20, height: 20)
                        : const Icon(Icons.add),
        );
      },
    );
  }
}
