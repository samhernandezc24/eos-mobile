import 'package:eos_mobile/core/extensions/panel_extension.dart';
import 'package:eos_mobile/core/utils/haptics_utils.dart';
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
    if (_query.isEmpty) {

    }
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
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: const Text('Elementos para filtrar el <InputSearch>'),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
    );
  }
}
