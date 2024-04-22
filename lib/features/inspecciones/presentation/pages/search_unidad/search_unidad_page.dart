import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad_inventario/remote/remote_unidad_inventario_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionSearchUnidadPage extends StatefulWidget {
  const InspeccionSearchUnidadPage({Key? key}) : super(key: key);

  @override
  State<InspeccionSearchUnidadPage> createState() => _InspeccionSearchUnidadPageState();
}

class _InspeccionSearchUnidadPageState extends State<InspeccionSearchUnidadPage> {
  late TextEditingController _searchController = TextEditingController();

  late List<UnidadInventarioEntity> lstRows = <UnidadInventarioEntity>[];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadPredictiveSearch('');
  }

  /// METHODS
  void _handleSearchSubmitted(String search) {

  }

  void _loadPredictiveSearch(String search) {
    final predictiveSearch = PredictiveSearchReqEntity(search: search);
    context.read<RemoteUnidadInventarioBloc>().add(PredictiveUnidadInventario(predictiveSearch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final predictiveSearch = PredictiveSearchReqEntity(
                      search: _searchController.text,
                      // Agrega aquí cualquier otro filtro que desees enviar al servidor
                    );
                    context.read<RemoteUnidadInventarioBloc>().add(
                          PredictiveUnidadInventario(predictiveSearch),
                        );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<RemoteUnidadInventarioBloc, RemoteUnidadInventarioState>(
                builder: (context, state) {
                  if (state is RemoteUnidadInventarioLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RemoteUnidadInventarioSuccess) {
                    final unidades = state.unidades;
                    // Muestra aquí los resultados de la búsqueda predictiva en una lista o cualquier otro widget
                    return ListView.builder(
                      itemCount: unidades!.rows!.length,
                      itemBuilder: (context, index) {
                        final unidad = unidades.rows![index];
                        return ListTile(
                          title: Text(unidad.numeroEconomico ?? ''),
                          // Agrega aquí cualquier otra información que desees mostrar sobre la unidad
                        );
                      },
                    );
                  } else if (state is RemoteUnidadFailure ||
                      state is RemoteUnidadFailedMessage) {
                    final errorMessage = state is RemoteUnidadFailure
                        ? 'Error: ${state.failure?.errorMessage}'
                        : state is RemoteUnidadFailedMessage
                            ? 'Error: ${state.errorMessage}'
                            : 'Error desconocido';
                    return Center(child: Text(errorMessage));
                  } else {
                    return Container(); // Maneja otros estados aquí si es necesario
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
