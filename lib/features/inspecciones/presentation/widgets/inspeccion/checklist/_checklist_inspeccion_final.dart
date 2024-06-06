part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionFinal extends StatefulWidget {
  const _ChecklistInspeccionFinal({Key? key, this.inspeccion}) : super(key: key);

  final Inspeccion? inspeccion;

  @override
  State<_ChecklistInspeccionFinal> createState() => _ChecklistInspeccionFinalState();
}

class _ChecklistInspeccionFinalState extends State<_ChecklistInspeccionFinal> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionFinalController;
  late final TextEditingController _observacionesController;
  late final TextEditingController _nombreOperadorController;
  late final TextEditingController _nombreVerificadorController;

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionFinalController = TextEditingController();
    _observacionesController        = TextEditingController();
    _nombreOperadorController       = TextEditingController();
    _nombreVerificadorController    = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionFinalController.dispose();
    _observacionesController.dispose();
    _nombreOperadorController.dispose();
    _nombreVerificadorController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleDrawSignaturePressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : const _ChecklistInspeccionSignature(),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleFinishPressed() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text('Confirmar finalización', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : Text(
            'Soy testigo de la inspección realizada al equipo que tengo a mi cargo y se me informo específicamente de cada punto a considerar para su atención correctiva.',
            style: $styles.textStyles.body.copyWith(height: 1.4),
          ),
          actions : [
            TextButton(onPressed: () => Navigator.pop(context, $strings.cancelButtonText), child: Text($strings.cancelButtonText, style: $styles.textStyles.button)),
            TextButton(
              onPressed: () {
                Navigator.pop(context, $strings.acceptButtonText);  // Cerrar el dialógo
              },
              child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text($strings.checklistFinishAppBarTitle, style: $styles.textStyles.h3)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // FECHA INSPECCION FINAL:
              LabeledDateTimeTextFormField(
                controller  : _fechaInspeccionFinalController,
                hintText    : 'dd/mm/aaaa hh:mm',
                label       : '* Fecha de inspección final:',
              ),

              Gap($styles.insets.sm),

              // OBSERVACIONES:
              LabeledTextareaFormField(
                controller    : _observacionesController,
                hintText      : 'Ingresa la observación presentada durante la inspección',
                labelText     : 'Observaciones (opcional):',
                maxCharacters : 300,
              ),

              Gap($styles.insets.sm),

              // FIRMAS:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Firma del operador *:', style: $styles.textStyles.label),
                  Gap($styles.insets.sm),
                  Container(
                    padding : EdgeInsets.all($styles.insets.sm),
                    color   : Theme.of(context).colorScheme.background,
                    child   : Center(
                      child: FilledButton(
                        onPressed : () => _handleDrawSignaturePressed(context),
                        child     : Text($strings.checklistFinishSignatureButtonText, style: $styles.textStyles.button),
                      ),
                    ),
                  ),
                ],
              ),

              Gap($styles.insets.sm),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Firma del verificador *:', style: $styles.textStyles.label),
                  Gap($styles.insets.sm),
                  Container(
                    padding : EdgeInsets.all($styles.insets.sm),
                    color   : Theme.of(context).colorScheme.background,
                    child   : Center(
                      child: FilledButton(
                        onPressed : () => _handleDrawSignaturePressed(context),
                        child     : Text($strings.checklistFinishSignatureButtonText, style: $styles.textStyles.button),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      height  : 70,
      child   : Row(
        children  : <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () => Navigator.pop(context),
            semanticLabel : $strings.prevButtonText,
            flipIcon      : true,
          ),
          const Spacer(),
          FilledButton(
            onPressed : _handleFinishPressed,
            child     : Text($strings.finishButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
