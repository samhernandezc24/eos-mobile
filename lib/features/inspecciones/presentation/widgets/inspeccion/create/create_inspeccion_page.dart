import 'package:eos_mobile/core/utils/data_source_utils.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class CreateInspeccionPage extends StatefulWidget {
  const CreateInspeccionPage({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionPage> createState() => _CreateInspeccionPageState();
}

class _CreateInspeccionPageState extends State<CreateInspeccionPage> {
  /// PROPERTIES
  /// FILTERS
  final List<dynamic> sltFilter = [];

  /// SEARCH FILTERS:
  late final List<Map<String, dynamic>> searchFilters = [];

  /// METHODS
  void _loadDataSource() {
    final Map<String, dynamic> objData = {
      'search'            : '',
      'searchFilters'     : DataSourceUtils.searchFilters(searchFilters),
      'filters'           : sltFilter,
      'filtersMultiple'   : sltFilter,
      'dateFrom'          : '',
      'dateTo'            : '',
      'dateOptions'       : [{'field': ''}],
      'strFields'         : '',
      'length'            : 25,
      'page'              : 1,
      'sort'              : {'column': '', 'direction': ''},
    };

    context.read<RemoteInspeccionBloc>().add(DataSourceInspeccion(objData));
  }

  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Text('¿Está seguro que desea salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar dialog
              Navigator.of(context).pop(); // Cerrar pagina
            },
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    ).then((_) {
      _loadDataSource();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleDidPopPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Nueva inspección', style: $styles.textStyles.h3)),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
          children: const <Widget>[
            // CAMPOS PARA CREAR LA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO
            CreateInspeccionForm(),
          ],
        ),
      ),
    );
  }
}
