import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_state.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspeccion_tile.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';

class ConfiguracionInspeccionPage extends StatefulWidget {
  const ConfiguracionInspeccionPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionInspeccionPage> createState() =>
      _ConfiguracionInspeccionPageState();
}

class _ConfiguracionInspeccionPageState
    extends State<ConfiguracionInspeccionPage> {
  List<String> lstInspecciones = [
    'Inspeccion 1',
    'Inspeccion 2',
    'Inspeccion 3',
  ];

  Future<void> refresh() async {
    setState(() {
      lstInspecciones.addAll(['Inspeccion 4', 'Inspeccion 5', 'Inspeccion 6']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración de Inspecciones',
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
    return BlocBuilder<RemoteInspeccionesBloc, RemoteInspeccionesState>(
      builder: (_, state) {
        if (state is RemoteInspeccionesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is RemoteInspeccionesFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No se pudo conectar al servidor.'),
                FilledButton(
                  onPressed: refresh,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        if (state is RemoteInspeccionesDone) {
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
                          return const CreateInspeccion();
                        },
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                    size: 16,
                  ),
                  label: const Text(
                    'Crear inspección',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Listado de Inspecciones',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Crea una inspección para agrupar las inspecciones de unidades.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return InspeccionTile(
                        inspeccion: state.inspecciones![index],
                      );
                    },
                    itemCount: state.inspecciones!.length, 
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
