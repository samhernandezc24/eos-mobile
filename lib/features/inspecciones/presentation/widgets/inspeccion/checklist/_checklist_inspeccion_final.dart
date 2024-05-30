part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionFinal extends StatefulWidget {
  const _ChecklistInspeccionFinal({Key? key}) : super(key: key);

  @override
  State<_ChecklistInspeccionFinal> createState() => _ChecklistInspeccionFinalState();
}

class _ChecklistInspeccionFinalState extends State<_ChecklistInspeccionFinal> {
  // CONTROLLERS
  late final TextEditingController _observacionesController;
  late final TextEditingController _nombreOperadorController;
  late final TextEditingController _nombreVerificadorController;

  // STATE
  @override
  void initState() {
    super.initState();
    _observacionesController      = TextEditingController();
    _nombreOperadorController     = TextEditingController();
    _nombreVerificadorController  = TextEditingController();
  }

  @override
  void dispose() {
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
                  LabeledTextFormField(
                    controller  : _nombreOperadorController,
                    hintText    : 'Ingrese nombre del operador',
                    label       : 'Nombre y firma del operador*:',
                    validator   : FormValidators.textValidator,
                  ),
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
                  LabeledTextFormField(
                    controller  : _nombreVerificadorController,
                    hintText    : 'Ingrese nombre de quién realizó la inspección',
                    label       : 'Nombre y firma del verificador*:',
                    validator   : FormValidators.textValidator,
                  ),
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
          FilledButton(
            onPressed : () => Navigator.pop(context),
            style     : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).disabledColor)),
            child     : Text($strings.prevButtonText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          FilledButton(onPressed: () {}, child: Text($strings.finishButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );
  }
}
