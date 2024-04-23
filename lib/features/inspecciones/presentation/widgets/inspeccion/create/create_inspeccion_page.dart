import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionPage extends StatefulWidget {
  const CreateInspeccionPage({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionPage> createState() => _CreateInspeccionPageState();
}

class _CreateInspeccionPageState extends State<CreateInspeccionPage> {
  /// CONTROLLERS
  late final ScrollController _scrollController = ScrollController();

  /// PROPERTIES
  bool _showScrollToTopButton = false;

  /// METHODS
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
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar el boton para scrollear al top de la página, cuando se encuentre navegando a un nivel
    // de bottom bajo.
    final Widget scrollToTopButton = AnimatedOpacity(
      opacity: _showScrollToTopButton ? 1.0 : 0.0,
      duration: $styles.times.fast,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleDidPopPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Nueva inspección', style: $styles.textStyles.h3)),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _showScrollToTopButton = _scrollController.offset > 100;
              });
            }
            return true;
          },
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
            children: const <Widget>[
              // CAMPOS PARA CREAR LA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO
              CreateInspeccionForm(),
            ],
          ),
        ),
        floatingActionButton: scrollToTopButton,
      ),
    );
  }
}
