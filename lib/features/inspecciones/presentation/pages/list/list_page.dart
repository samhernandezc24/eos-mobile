import 'package:eos_mobile/core/common/widgets/controls/scroll_decorator.dart';
import 'package:eos_mobile/core/common/widgets/themed_text.dart';
import 'package:eos_mobile/core/extensions/panel_extension.dart';
import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/list/list_inspeccion_search_input.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

part '../../widgets/inspeccion/list/list_inspecciones_results.dart';
part '../../widgets/inspeccion/filter/filter_inspeccion.dart';

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
  List<String> options = ['Opcion 1', 'Opcion 2', 'Opcion 3'];

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

  void _handleFilterModal(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(1, 0);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: const FilterInspeccion(),
          );
        },
        fullscreenDialog: true,
      ),
    );
    // showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Padding(
    //           padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
    //           child: Center(
    //             child: Text(
    //               'Filtros de inspecciones',
    //               style: $styles.textStyles.h3.copyWith(fontSize: 18),
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           onTap: (){},
    //           title: const Text('Estatus:'),
    //           trailing: DropdownMenu(
    //             initialSelection: options.first,
    //             onSelected: (String? value) {
    //               setState(() {
    //                 options.first = value!;
    //               });
    //             },
    //             dropdownMenuEntries: options.map((String value) {
    //               return DropdownMenuEntry(value: value, label: value);
    //             }).toList(),
    //           )
    //         ),
    //         ListTile(
    //           onTap: (){},
    //           title: const Text('Tipo de inspección:'),
    //         ),
    //         ListTile(
    //           onTap: (){},
    //           title: const Text('Tipo de unidad:'),
    //         ),
    //         ListTile(
    //           onTap: (){},
    //           title: const Text('Creado por:'),
    //         ),
    //         ListTile(
    //           onTap: (){},
    //           title: const Text('Actualizado por:'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _handleSortModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text(
                  'Ordenar por',
                  style: $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              title: const Text('Predeterminado'),
              trailing: Radio<bool>(
                value: true, // Aquí debes establecer el valor correspondiente al radio button
                groupValue: null, // Aquí debes establecer el valor seleccionado del grupo de radio buttons
                onChanged: (bool? value) {
                  // Aquí puedes manejar la lógica cuando se selecciona este radio button
                },
              ),
            ),
            ListTile(
              onTap: (){},
              title: const Text('Fecha: más recientes'),
              trailing: Radio<bool>(
                value: true, // Aquí debes establecer el valor correspondiente al radio button
                groupValue: null, // Aquí debes establecer el valor seleccionado del grupo de radio buttons
                onChanged: (bool? value) {
                  // Aquí puedes manejar la lógica cuando se selecciona este radio button
                },
              ),
            ),
            ListTile(
              onTap: (){},
              title: const Text('Fecha: más antiguos'),
              trailing: Radio<bool>(
                value: true, // Aquí debes establecer el valor correspondiente al radio button
                groupValue: null, // Aquí debes establecer el valor seleccionado del grupo de radio buttons
                onChanged: (bool? value) {
                  // Aquí puedes manejar la lógica cuando se selecciona este radio button
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleResultPressed(String? o) => context.go(ScreenPaths.home);

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
          Expanded(
            child: RepaintBoundary(
              child: _ListInspeccionesResults(
                onPressed: _handleResultPressed,
              ),
            ),
          ),
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
              Text('498 resultados', style: $styles.textStyles.body),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _handleFilterModal(context),
                icon: const Icon(Icons.filter_list),
                tooltip: 'Filtros',
              ),
              IconButton(
                onPressed: () => _handleSortModal(context),
                icon: const Icon(Icons.format_line_spacing),
                tooltip: 'Ordenar',
              ),
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
