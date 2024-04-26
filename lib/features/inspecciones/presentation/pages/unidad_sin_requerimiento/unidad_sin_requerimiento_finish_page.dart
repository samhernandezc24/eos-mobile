import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/draw_signature.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionUnidadSinRequerimientoFinishPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoFinishPage({Key? key})
      : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoFinishPage> createState() =>
      _InspeccionSinRequerimientoFinishPageState();
}

class _InspeccionSinRequerimientoFinishPageState
    extends State<InspeccionUnidadSinRequerimientoFinishPage> {
  // Definir controladores para los campos de texto
  final TextEditingController _observacionesController =
      TextEditingController();

  @override
  void dispose() {
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _showDialogFirma() {
    return showGeneralDialog<void>(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final double scale = Curves.easeInOut.transform(animation.value);
        final double opacity = Curves.easeInOut.transform(animation.value);
        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      transitionDuration: $styles.times.fast,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            child: DrawSignature(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Finalizar Inspección de Unidad',
          style: $styles.textStyles.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all($styles.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // OBSERVACIONES
                  LabeledTextareaFormField(
                    controller: _observacionesController,
                    labelText: 'Observaciones de la Unidad (opcional)',
                    validator: FormValidators.textValidator,
                    hintText: 'Ingresar la observación...',
                    maxLines: 3,
                    maxCharacters: 300,
                  ),

                  Gap($styles.insets.sm),
                  const Divider(),
                  Gap($styles.insets.sm),

                  // FIRMAS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Firma del Operador *',
                        style: $styles.textStyles.label,
                      ),
                      Gap($styles.insets.sm),
                      Container(
                        padding: EdgeInsets.all($styles.insets.xs + 2),
                        color: Theme.of(context).canvasColor,
                        child: Center(
                          child: FilledButton(
                            onPressed: _showDialogFirma,
                            child: const Text('Dibujar Firma'),
                          ),
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Text(
                        'Firma del Verificador *',
                        style: $styles.textStyles.label,
                      ),
                      Gap($styles.insets.sm),
                      Container(
                        padding: EdgeInsets.all($styles.insets.xs + 2),
                        color: Theme.of(context).canvasColor,
                        child: Center(
                          child: FilledButton(
                            onPressed: _showDialogFirma,
                            child: const Text('Dibujar Firma'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          children: <Widget>[
            FilledButton.tonal(
              onPressed: () {},
              child: Text(
                'Anterior',
                style: $styles.textStyles.button,
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: Text(
                'Finalizar Inspección',
                style: $styles.textStyles.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
