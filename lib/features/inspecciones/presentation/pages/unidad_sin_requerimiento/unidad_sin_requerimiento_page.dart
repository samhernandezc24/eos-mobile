import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
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
  /// CONTROLLERS
  final ScrollController _scrollController = ScrollController();

  /// LIST
  late List<InspeccionTipoEntity> lstInspeccionesTipos = <InspeccionTipoEntity>[];

  /// PROPERTIES
  bool _showScrollTopButton = false;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());
  }

  /// METHODS

  @override
  Widget build(BuildContext context) {
    final Widget scrollToTopButton = AnimatedOpacity(
      opacity: _showScrollTopButton ? 1.0 : 0.0,
      duration: $styles.times.fast,
      child: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.arrow_upward),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Inspección de unidad sin req.', style: $styles.textStyles.h3)),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _showScrollTopButton = _scrollController.offset > 100;
            });
          }
          return true;
        },
        child: BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
          builder: (BuildContext context, RemoteInspeccionState state) {
            if (state is RemoteInspeccionLoading) {
              return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
            }

            if (state is RemoteInspeccionCreateSuccess) {
              lstInspeccionesTipos = state.objInspeccion?.inspeccionesTipos ?? [];
              return ListView(
                controller: _scrollController,
                padding: EdgeInsets.all($styles.insets.sm),
                children: <Widget>[
                  LabeledDropdownFormField<InspeccionTipoEntity>(
                    label: '* Seleccione el tipo de inspección:',
                    hintText: 'Seleccionar',
                    items: lstInspeccionesTipos,
                    itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
                    value: lstInspeccionesTipos.isNotEmpty ? lstInspeccionesTipos.first : null,
                    onChanged: (_) {},
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: scrollToTopButton,
    );
  }
}
