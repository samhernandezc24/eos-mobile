import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/categoria/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categoria_item/categoria_item_page.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part '../../../widgets/configuracion/categoria/list/_list_tile.dart';
part '../../../widgets/configuracion/categoria/create/_create_form.dart';
part '../../../widgets/configuracion/categoria/edit/_edit_form.dart';

class InspeccionConfiguracionCategoriaPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriaPage({
    required this.objInspeccionTipo,
    required this.objData,
    Key? key,
  }) : super(key: key);

  final InspeccionTipoEntity objInspeccionTipo;
  final InspeccionTipoIdParamEntity objData;

  @override
  State<InspeccionConfiguracionCategoriaPage> createState() => _InspeccionConfiguracionCategoriaPage();
}

class _InspeccionConfiguracionCategoriaPage extends State<InspeccionConfiguracionCategoriaPage> {
  // LIST
  List<CategoriaEntity> lstCategorias = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _initialization();
  }

  // EVENTS
  void _handleCreatePressed(BuildContext context) {
    Navigator.push<void>(
      context,
      AppModalRoute(
        child: _CreateCategoriaForm(
          objInspeccionTipo : widget.objInspeccionTipo,
          onComplete        : _initialization,
          orden             : lstCategorias.length + 1,
        ),
      ),
    );
  }

  void _onCategoriaPressed(CategoriaEntity objCategoria) {
    Future.delayed($styles.times.pageTransition, () {
      Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (_) => const InspeccionConfiguracionCategoriaItemPage(),
        ),
      );
    });
  }

  // METHODS
  Future<void> _initialization() async {
    context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.objData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.categoriaAppBarTitle, style: $styles.textStyles.h3)),
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
                Text(AppStrings.categoriaBoxTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.objInspeccionTipo.name}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: const <TextSpan>[
                      TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${AppStrings.categoriaBoxDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment : Alignment.center,
                  child     : FilledButton.icon(
                    onPressed : () => _handleCreatePressed(context),
                    icon      : const Icon(Icons.add),
                    label     : Text(AppStrings.btnCreateCategoriaText, style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _initialization,
              child: BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  // LOADING
                  if (state is RemoteCategoriaLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  // ERROR
                  if (state is RemoteCategoriaServerFailedMessageList) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error);
                  }

                  if (state is RemoteCategoriaServerExceptionMessageList) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error?.message);
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaList) {
                    lstCategorias = state.objResponse ?? [];

                    if (lstCategorias.isEmpty) {
                      return EmptyListMessage(
                        title     : AppStrings.categoriaEmptyListTitle,
                        message   : AppStrings.emptyListSyncMessage,
                        onRefresh : _initialization,
                      );
                    }

                    return ListView.builder(
                      itemCount: lstCategorias.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _ListCategoriaTile(
                          objCategoria  : lstCategorias[index],
                          onPressed     : (objCategoria) => _onCategoriaPressed(objCategoria),
                          onComplete    : _initialization,
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
    );
  }
}
