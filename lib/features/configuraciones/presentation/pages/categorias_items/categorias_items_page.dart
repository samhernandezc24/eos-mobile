import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias/create_categoria_form.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias_items/create_categoria_item_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasItemsPage extends StatefulWidget {
  const ConfiguracionesCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<ConfiguracionesCategoriasItemsPage> createState() => _ConfiguracionesCategoriasItemsPageState();
}

class _ConfiguracionesCategoriasItemsPageState extends State<ConfiguracionesCategoriasItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Preguntas', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: FilledButton.icon(
              onPressed: () {
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
                        child: BasicModal(
                          title: 'Nueva Pregunta Dinámica',
                          child: CreateCategoriaItemForm(),
                        ),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Crear Pregunta', style: $styles.textStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
