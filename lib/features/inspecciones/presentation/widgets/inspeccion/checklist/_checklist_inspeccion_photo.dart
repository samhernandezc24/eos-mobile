part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionPhoto extends StatefulWidget {
  const _ChecklistInspeccionPhoto({Key? key, this.inspeccion}) : super(key: key);

  final Inspeccion? inspeccion;

  @override
  State<_ChecklistInspeccionPhoto> createState() => __ChecklistInspeccionPhotoState();
}

class __ChecklistInspeccionPhotoState extends State<_ChecklistInspeccionPhoto> {
  // EVENTS
  void _handleNextPressed() {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => const _ChecklistInspeccionFinal(),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          const Offset begin    = Offset(1, 0);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: child);
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text($strings.checklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment  : CrossAxisAlignment.stretch,
        children            : <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                Text('Número económico:', style: $styles.textStyles.bodySmall),
                Text(widget.inspeccion?.unidadNumeroEconomico ?? '', style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3)),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de unidad'),
                      TextSpan(text: ': ${widget.inspeccion?.unidadTipoName ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Número de serie'),
                      TextSpan(text: ': ${widget.inspeccion?.numeroSerie ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.checklistPhotoEvidenceBoxSuggest}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Expanded(
            child: RepaintBoundary(
              child: _PhotosGrid(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
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
          FilledButton(onPressed: () => _handleNextPressed(), child: Text($strings.nextButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );
  }
}
