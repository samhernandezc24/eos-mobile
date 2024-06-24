part of '../../../../pages/list/list_page.dart';

class _ChecklistFirmaModal extends StatefulWidget {
  const _ChecklistFirmaModal({Key? key}) : super(key: key);

  @override
  State<_ChecklistFirmaModal> createState() => __ChecklistFirmaModalState();
}

class __ChecklistFirmaModalState extends State<_ChecklistFirmaModal> {
  // GLOBAL KEY
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey<SfSignaturePadState>();

  // EVENTS
  Future<void> _handleStorePressed() async {

  }

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
            color   : Theme.of(context).colorScheme.background,
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            child   : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${ $strings.checklistDrawSignatureBoxSuggest}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap($styles.insets.sm),
          Padding(
            padding : EdgeInsets.all($styles.insets.sm),
            child   : SizedBox(
              width   : double.infinity,
              height  : 300,
              child   : DottedBorder(
                color       : Theme.of(context).primaryColor,
                strokeWidth : 3,
                dashPattern : const [5, 4],
                borderType  : BorderType.RRect,
                child       : SfSignaturePad(
                  key                 : _signaturePadKey,
                  minimumStrokeWidth  : 1,
                  maximumStrokeWidth  : 3,
                  backgroundColor     : Theme.of(context).canvasColor,
                  strokeColor         : Colors.blue,
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
      height: 70,
      child: Row(
        children: <Widget>[
          FilledButton(
            onPressed : _handleClearPressed,
            style     : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF4FAFF)),
              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF233876)),
            ),
            child     : Text($strings.clearButtonText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          FilledButton(
            onPressed : _handleStorePressed,
            child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
