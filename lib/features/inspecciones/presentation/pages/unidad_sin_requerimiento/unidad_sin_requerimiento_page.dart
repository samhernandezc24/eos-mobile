import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() => _InspeccionUnidadSinRequerimientoPageState();
}

class _InspeccionUnidadSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  /// LIST
  late List<InspeccionTipoEntity>? lstInspeccionesTipos = <InspeccionTipoEntity>[];

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inspección de unidad sin req.', style: $styles.textStyles.h3)),
      body: BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
        builder: (BuildContext context, RemoteInspeccionState state) {
          if (state is RemoteInspeccionLoading) {
            return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
          }

          if (state is RemoteInspeccionCreateSuccess) {
            lstInspeccionesTipos = state.objInspeccion!.inspeccionesTipos;
            return _buildDropdownSelectInspeccionesTipos(lstInspeccionesTipos);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDropdownSelectInspeccionesTipos(List<InspeccionTipoEntity>? inspeccionesTipos){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Center(
            child: DropdownButtonFormField<InspeccionTipoEntity>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: $styles.insets.sm - 3,
                  horizontal: $styles.insets.xs + 2,
                ),
                hintText: 'Seleccione',
              ),
              menuMaxHeight: 280,
                value: null,
                items: inspeccionesTipos?.map((inspeccionTipo) {
                  return DropdownMenuItem<InspeccionTipoEntity>(value: inspeccionTipo, child: Text(inspeccionTipo.name));
                }).toList(),
              onChanged: (_){},
            ),
          ),
        ),
      ],
    );
  }
}
