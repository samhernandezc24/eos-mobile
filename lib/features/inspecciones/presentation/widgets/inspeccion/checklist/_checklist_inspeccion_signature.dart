part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionSignature extends StatefulWidget {
  const _ChecklistInspeccionSignature({Key? key}) : super(key: key);

  @override
  State<_ChecklistInspeccionSignature> createState() => _ChecklistInspeccionSignatureState();
}

class _ChecklistInspeccionSignatureState extends State<_ChecklistInspeccionSignature> {
  // GLOBAL KEY
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey<SfSignaturePadState>();

  // EVENTS
  void _handleClearPressed() {
    _signaturePadKey.currentState!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text($strings.checklistDrawSignatureAppBarTitle, style: $styles.textStyles.h3)),
      body: Column(
        children: <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.checklistDrawSignatureBoxSuggest}'),
                    ],
                  ),
                ),
                // Gap($styles.insets.sm),
                // Row(
                //   mainAxisAlignment   : MainAxisAlignment.center,
                //   children            : <Widget>[
                //     GestureDetector(
                //       onTap: (){},
                //       child: Column(
                //         children: [
                //           const Icon(Icons.undo),
                //           Gap($styles.insets.xxs),
                //           const Text('Rehacer'),
                //         ],
                //       ),
                //     ),
                //     Gap($styles.insets.md),
                //     GestureDetector(
                //       onTap: (){},
                //       child: Column(
                //         children: [
                //           const Icon(Icons.redo),
                //           Gap($styles.insets.xxs),
                //           const Text('Deshacer'),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),

          Gap($styles.insets.sm),

          Padding(
            padding: EdgeInsets.all($styles.insets.sm),
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: DottedBorder(
                color: Theme.of(context).primaryColor,
                strokeWidth: 3,
                dashPattern: const [5, 4],
                borderType: BorderType.RRect,
                child: SfSignaturePad(
                  key                 : _signaturePadKey,
                  minimumStrokeWidth  : 1,
                  maximumStrokeWidth  : 3,
                  strokeColor         : Colors.blue,
                  backgroundColor     : Theme.of(context).canvasColor,
                ),
              ),
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
            onPressed : _handleClearPressed,
            style     : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).disabledColor)),
            child     : Text($strings.clearButtonText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          FilledButton(onPressed: () {}, child: Text($strings.saveButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );
  }
}
