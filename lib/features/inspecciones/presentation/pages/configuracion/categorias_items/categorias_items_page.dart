import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/error_server_failure.dart';
import 'package:eos_mobile/ui/common/request_data_unavailable.dart';

part '../../../widgets/categoria_item/_list_card.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  // LIST
  List<CategoriaItemEntity> lstCategoriasItems   = <CategoriaItemEntity>[];
  List<FormularioTipo> lstFormulariosTipos       = <FormularioTipo>[];

  // PROPERTIES
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
  }

  // METHODS
  void _handleStoreCategoriaItem() {
    final CategoriaItemStoreReqEntity objData = CategoriaItemStoreReqEntity(
      idCategoria   : widget.categoria?.idCategoria ?? '',
      categoriaName : widget.categoria?.name        ?? '',
    );

    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreCategoriaItem(objData));
  }

  void _onCategoriaItemDeletePressed() {

  }

  void _onCategoriaItemUpdatePressed() {

  }

  void _onCategoriaItemStoreDuplicatePressed(CategoriaItemStoreDuplicateReqEntity objData) {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreDuplicateCategoriaItem(objData));
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

  void _hideProgressDialog() {
    Navigator.of(context).pop();
  }

  Future<void> _showServerFailedMessage(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            errorMessage ?? 'Se produjo un error inesperado.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerFailure(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            errorMessage ?? 'Se produjo un error inesperado.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text($strings.categoryItemAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        children: <Widget>[
          _buildHeaderContent(),

          // LISTADO DE CATEGORIAS ITEMS:
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

                  // ERRORS:
                  if (state is RemoteCategoriaItemServerFailedMessageDuplicate) {
                    _hideProgressDialog();

                    _showServerFailedMessage(context, state.errorMessage);

                    // Actualizar listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemServerFailureDuplicate) {
                    _hideProgressDialog();

                    _showServerFailure(context, state.failure?.errorMessage);

                    // Actualizar listado de preguntas.
                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
                  }

                  // SUCCESS:
                  if (state is RemoteCategoriaItemSuccess) {
                    lstCategoriasItems  = state.objResponse?.categoriasItems  ?? [];
                    lstFormulariosTipos = state.objResponse?.formulariosTipos ?? [];
                    setState(() {
                      _isLoading = false;
                    });
                  }

                  if (state is RemoteCategoriaItemStoredDuplicate) {
                    _hideProgressDialog();

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

                    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

                    setState(() {
                      _isLoading = false;
                    });
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
                    if (lstCategoriasItems.isNotEmpty) {
                      return ListView.builder(
                        itemCount   : lstCategoriasItems.length,
                        itemBuilder : (BuildContext context, int index) {
                          final CategoriaItemEntity categoriaItem = lstCategoriasItems[index];

                          return _ListCard(
                            categoriaItem       : categoriaItem,
                            categoria           : widget.categoria,
                            formulariosTipos    : lstFormulariosTipos,
                            onDuplicatePressed  : _onCategoriaItemStoreDuplicatePressed,
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.categoryItemEmptyTitle,
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

  Widget _buildHeaderContent() {
    return Container(
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
                TextSpan(text: ': ${$strings.categoryItemDescription}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (BuildContext context, RemoteCategoriaItemState state) {
        // ERRORS:
        if (state is RemoteCategoriaItemServerFailedMessageStore) {
          _showServerFailedMessage(context, state.errorMessage);

          // Actualizar listado de preguntas.
          context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));

          setState(() {
            _isLoading = false;
          });
        }

        if (state is RemoteCategoriaItemServerFailureStore) {
          _showServerFailure(context, state.failure?.errorMessage);

          // Actualizar listado de preguntas.
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
              behavior        : SnackBarBehavior.fixed,
              elevation       : 0,
            ),
          );

          // Actualizar listado de preguntas.
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
