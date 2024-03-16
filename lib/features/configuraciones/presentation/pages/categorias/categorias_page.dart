import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categoria_tile.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasPage extends StatefulWidget {
  const ConfiguracionesCategoriasPage({Key? key, this.idInspeccionTipo}) : super(key: key);

  final InspeccionTipoReqEntity? idInspeccionTipo;

  @override
  State<ConfiguracionesCategoriasPage> createState() => _ConfiguracionesCategoriasPageState();
}

class _ConfiguracionesCategoriasPageState extends State<ConfiguracionesCategoriasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración de Categorías',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const BasicModal(
                        title: 'Nueva Categoría',
                        child: CreateInspeccionTipoForm(),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Crear Categoría',
                style: $styles.textStyles.button,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Listado de Categorías',
                  style: $styles.textStyles.title1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Gap($styles.insets.xxs),
                Text(
                  'Crear categorías para agrupar los formularios de las inspecciones.',
                  style: $styles.textStyles.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteCategoriaBloc>(context)
                  .add(
                      FetchCategoriasByIdInspeccionTipo(
                      InspeccionTipoReqEntity(idInspeccionTipo: '40be6681-6b71-4b3f-9ce6-7c02f37009b8'),
                    ),
                  );
              },
              child: BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  if (state is RemoteCategoriaInitial) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 64,
                            ),
                            Gap($styles.insets.sm),
                            Text(
                              'Aún no hay categorías registradas.',
                              textAlign: TextAlign.center,
                              style: $styles.textStyles.h4,
                            ),
                            Gap($styles.insets.md),
                            FilledButton(
                              onPressed: () {
                                BlocProvider.of<RemoteCategoriaBloc>(context)
                                  .add(FetchCategoriasByIdInspeccionTipo(
                                    InspeccionTipoReqEntity(idInspeccionTipo: '40be6681-6b71-4b3f-9ce6-7c02f37009b8'),
                                  ),
                                );
                              },
                              child: Text(
                                'Actualizar página',
                                style: $styles.textStyles.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is RemoteInspeccionTipoLoading) {
                    return Center(
                      child: LoadingIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 2,
                      ),
                    );
                  }

                  if (state is RemoteCategoriaFailure) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Theme.of(context).colorScheme.error,
                              size: 64,
                            ),
                            Gap($styles.insets.xxs),
                            Text('Oops, algo salió mal...', style: $styles.textStyles.h4),
                            Gap($styles.insets.xxs),
                            Text(
                              '${state.failure!.message}',
                              textAlign: TextAlign.center,
                              style: $styles.textStyles.bodySmall,
                            ),
                            Gap($styles.insets.md),
                            FilledButton(
                              onPressed: () {
                                BlocProvider.of<RemoteCategoriaBloc>(context)
                                  .add(FetchCategoriasByIdInspeccionTipo(
                                    InspeccionTipoReqEntity(idInspeccionTipo: '40be6681-6b71-4b3f-9ce6-7c02f37009b8'),
                                  ),
                                );
                              },
                              child: Text(
                                'Volver a intentar',
                                style: $styles.textStyles.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is RemoteCategoriaDone) {
                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return CategoriaTile(categoria: state.categorias![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: state.categorias!.length,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
