import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_state.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categoria_tile.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionCategoriaPage extends StatefulWidget {
  const ConfiguracionCategoriaPage({
    this.idInspeccion,
    Key? key,
  }) : super(key: key);

  final String? idInspeccion;

  @override
  State<ConfiguracionCategoriaPage> createState() =>
      _ConfiguracionCategoriaPageState();
}

class _ConfiguracionCategoriaPageState
    extends State<ConfiguracionCategoriaPage> {
  List<CategoriaEntity> inspeccionCategorias = [];

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _closeCategorias();
  // }

  Future<void> _loadCategorias() async {
    if (widget.idInspeccion != null) {
      final idInspeccionData = InspeccionReqEntity(
        idInspeccion: widget.idInspeccion!,
      );
      BlocProvider.of<RemoteCategoriasBloc>(context)
          .add(GetCategoriasByIdInspeccion(idInspeccionData));
    }
  }

  // void _closeCategorias() {
  //   BlocProvider.of<RemoteCategoriasBloc>(context).close();
  // }

  Future<void> refresh() async {
    setState(() {
      //lstInspecciones.addAll(['Categoría 4', 'Categoría 5', 'Categoría 6']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración de Categorías',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteCategoriasBloc, RemoteCategoriasState>(
      builder: (_, state) {
        if (state is RemoteCategoriasLoading) {
          return Center(
            child: LoadingIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 2,
            ),
          );
        }

        if (state is RemoteCategoriasFailure) {
          final jsonResponse =
              state.failure?.response?.data as Map<String, dynamic>?;
          final errorMessage = jsonResponse != null
              ? jsonResponse['message']
              : 'Ha ocurrido un error inesperado.';
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$errorMessage'),
                const Gap(30),
                FilledButton(
                  onPressed: refresh,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 100,
              alignment: Alignment.center,
              color: Theme.of(context).highlightColor,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const BasicModal(
                          title: 'Nueva Inspección',
                          child: CreateInspeccionForm(),
                        );
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 16,
                ),
                label: const Text(
                  'Crear categoría',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Listado de Categorías',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: const TextSpan(
                      text: 'Inspección: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: const TextSpan(
                      text: 'No. Folio: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (state is RemoteCategoriasDone) ...[
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return CategoriaTile(
                        inspeccionCategoria:
                            state.inspeccionesCategorias![index],
                      );
                    },
                    itemCount: state.inspeccionesCategorias!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ),
            ] else if (state is RemoteCategoriasEmpty) ...[
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Aun no hay categorías'),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
