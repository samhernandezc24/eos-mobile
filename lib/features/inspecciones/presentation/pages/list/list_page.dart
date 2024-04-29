import 'package:eos_mobile/core/extensions/panel_extension.dart';
import 'package:eos_mobile/core/utils/data_source_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_page.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/themed_text.dart';
import 'package:eos_mobile/ui/common/utils/app_haptics_utils.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

part '../../widgets/inspeccion/list/_results_list.dart';
part '../../widgets/inspeccion/list/_data_source.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/filter/filter_inspeccion.dart';

class InspeccionListPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> with GetItStateMixin  {
  /// METHODS
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
      child: const _DataSource(),
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _handleCreateInspeccionPressed(context),
      tooltip: 'Nueva inspección',
      child: const Icon(Icons.add),
    );
  }
}
