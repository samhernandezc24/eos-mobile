import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionPage extends StatefulWidget {
  const CreateInspeccionPage({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionPage> createState() => _CreateInspeccionPageState();
}

class _CreateInspeccionPageState extends State<CreateInspeccionPage> {
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
