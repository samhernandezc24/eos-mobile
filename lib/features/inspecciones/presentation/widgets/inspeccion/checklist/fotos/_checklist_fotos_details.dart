part of '../../../../pages/list/list_page.dart';

class _ChecklistFotosDetails extends StatefulWidget {
  const _ChecklistFotosDetails({required this.lstFicheros, required this.initialIndex, Key? key}) : super(key: key);

  final List<Fichero> lstFicheros;
  final int initialIndex;

  @override
  State<_ChecklistFotosDetails> createState() => _ChecklistFotosDetailsState();
}

class _ChecklistFotosDetailsState extends State<_ChecklistFotosDetails> {
  // CONTROLLERS
  late PageController _pageController;

  // PROPERTIES
  int _currentIndex = 0;

  // STATE
  @override
  void initState() {
    super.initState();
    _currentIndex     = widget.initialIndex;
    _pageController   = PageController(initialPage: widget.initialIndex);
  }

  // EVENTS
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleDetailsPressed(BuildContext context, Fichero objFichero) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: <Widget>[
            Text(
              'Detalles de creación y modificación',
              style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Divider(color: Theme.of(context).dividerColor, thickness: 1.5),
          ],
        ),
        titlePadding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildRichText(context, 'Creado por', objFichero.createdUserName ?? ''),
            _buildRichText(context, 'Creado el', objFichero.createdFechaNatural ?? ''),
            _buildRichText(context, 'Actualizado por', objFichero.updatedUserName ?? ''),
            _buildRichText(context, 'Actualizado el', objFichero.updatedFechaNatural ?? ''),
          ],
        ),
        contentPadding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, 0),
        actions: <Widget>[
          TextButton(
            onPressed : () => Navigator.of(context).pop($strings.closeButtonText),
            child     : Text($strings.closeButtonText, style: $styles.textStyles.button),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(0, 0, $styles.insets.sm, $styles.insets.xs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title   : Text('Foto ${_currentIndex + 1} de ${widget.lstFicheros.length}', style: $styles.textStyles.h3),
        actions : [
          IconButton(
            onPressed : () => _handleDetailsPressed(context, widget.lstFicheros[_currentIndex]),
            icon      : Icon(Icons.info, color: Theme.of(context).primaryColor),
            tooltip   : 'Detalles',
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics         : const BouncingScrollPhysics(),
        builder               : (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider   : NetworkImage(ListAPI.inspeccionFicheroPath(widget.lstFicheros[index].path ?? '')),
            initialScale    : PhotoViewComputedScale.contained * 0.8,
            minScale        : PhotoViewComputedScale.contained,
            maxScale        : PhotoViewComputedScale.covered * 1.1,
          );
        },
        itemCount             : widget.lstFicheros.length,
        loadingBuilder        : (context, event) => _buildLoading(event),
        backgroundDecoration  : BoxDecoration(color: Theme.of(context).splashColor.withOpacity(0.1)),
        pageController        : _pageController,
        onPageChanged         : _onPageChanged,
      ),
    );
  }

  Center _buildLoading(ImageChunkEvent? event) {
    final double value = event == null || event.expectedTotalBytes == null
        ? 0
        : event.cumulativeBytesLoaded / event.expectedTotalBytes!;
    return Center(
      child: SizedBox(
        width   : 30,
        height  : 30,
        child   : CircularProgressIndicator(
          color       : Theme.of(context).primaryColor,
          strokeWidth : 3,
          value       : value,
        ),
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: $styles.insets.xxs),
      child: RichText(
        text: TextSpan(
          style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
          children  : <InlineSpan>[
            TextSpan(text: label),
            TextSpan(text: ': $value'),
          ],
        ),
      ),
    );
  }
}
