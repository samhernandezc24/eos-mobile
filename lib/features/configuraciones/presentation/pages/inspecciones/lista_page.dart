import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_state.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/cupertino.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

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
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteInspeccionesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container();
            },
            itemCount: state.inspecciones!.length,
          );
        }
        return const SizedBox();
      },
    );
  }
}
