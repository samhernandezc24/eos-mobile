import 'package:eos_mobile/core/common/data/catalogos/base_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_marca_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_tipo_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateUnidadPage extends StatefulWidget {
  const CreateUnidadPage({Key? key}) : super(key: key);

  @override
  State<CreateUnidadPage> createState() => _CreateUnidadPageState();
}

class _CreateUnidadPageState extends State<CreateUnidadPage> {
  /// LIST
  late List<BaseDataEntity> lstBases                  = <BaseDataEntity>[];
  late List<UnidadMarcaDataEntity> lstUnidadesMarcas  = <UnidadMarcaDataEntity>[];
  late List<UnidadTipoDataEntity> lstUnidadesTipos    =  <UnidadTipoDataEntity>[];

  @override
  void initState() {
    super.initState();
    context.read<RemoteUnidadBloc>().add(CreateUnidad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nueva unidad', style: $styles.textStyles.h3)),
      body: BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
        builder: (BuildContext context, RemoteUnidadState state) {
          if (state is RemoteUnidadLoading) {
            return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
          }

          if (state is RemoteUnidadCreateSuccess) {
            lstBases            = state.unidadData?.bases ?? [];
            lstUnidadesMarcas   = state.unidadData?.unidadesMarcas ?? [];
            lstUnidadesTipos    = state.unidadData?.unidadesTipos ?? [];

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
              children: <Widget>[
                // CAMPOS PARA CREAR LA UNIDAD TEMPORAL
                CreateUnidadForm(
                  bases: lstBases,
                  unidadesMarcas: lstUnidadesMarcas,
                  unidadesTipos: lstUnidadesTipos,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
