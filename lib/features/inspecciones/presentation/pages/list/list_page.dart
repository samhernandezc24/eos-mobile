import 'package:eos_mobile/core/extensions/panel_extension.dart';
import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/list_inspeccion_search_input.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionListPage extends StatefulWidget {
  const InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage>  {
  /// CONTROLLERS
  late final PanelController _panelController = PanelController(
    settingsLogic.isSearchPanelOpen.value,
  )..addListener(_handlePanelControllerChanged);

  /// PROPERTIES
  String _query = '';

  @override
  void initState() {
    _panelController.addListener(() {
      HapticsUtils.lightImpact();
    });
    super.initState();
  }

  @override
  void dispose() {
    _panelController.dispose();
    super.dispose();
  }

  /// METHODS
  void _handleSearchSubmitted(String query) {
    _query = query;
    _updateResults();
  }

  void _handlePanelControllerChanged() {
    settingsLogic.isSearchPanelOpen.value = _panelController.value;
  }

  void _updateResults() {
    if (_query.isEmpty) {}
  }

  void _handleCreateInspeccionPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: const CreateInspeccionPage(),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: ListInspeccionSearchInput(onSubmit: _handleSearchSubmitted),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs * 1.5),
            child: _buildStatusBar(context),
          ),
          const Divider(),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Lista de inspecciones', style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
      // NUEVA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO:
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return MergeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Gap($styles.insets.xs),
              Text('498 coincidencias', style: $styles.textStyles.body),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.format_line_spacing), tooltip: 'Ordenar por'),
              IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list), tooltip: 'Filtrar por'),
              Gap($styles.insets.xs),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _handleCreateInspeccionPressed(context),
      tooltip: 'Nueva inspección',
      child: const Icon(Icons.add),
    );
  }
}
