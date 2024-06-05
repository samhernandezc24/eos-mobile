part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionPhoto extends StatefulWidget {
  const _ChecklistInspeccionPhoto({required this.objData, Key? key}) : super(key: key);

  final InspeccionIdReqEntity objData;

  @override
  State<_ChecklistInspeccionPhoto> createState() => __ChecklistInspeccionPhotoState();
}

class __ChecklistInspeccionPhotoState extends State<_ChecklistInspeccionPhoto> {
  // PROPERTIES
  String? imageBase64             = '';
  String? unidadNumeroEconomico   = '';
  String? unidadTipoName          = '';
  String? unidadNumeroSerie       = '';
  String? idInspeccionEstatus     = '';

  bool _isLoading       = false;
  bool _hasServerError  = false;

  // LIST
  List<XFile> files = <XFile>[];

  // STATE
  @override
  void initState() {
    super.initState();
    _getFotos();
  }

  // EVENTS
  void _handleNextPressed() {
    if (files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // TITLE:
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              // MESSAGE:
              Text(
                $strings.checklistPhotoAlertNextPageMessage,
                style     : $styles.textStyles.bodySmall.copyWith(height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : const Color(0xfff89406),
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    } else {
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
  }

  Future<void> _handleTakePhotoPressed() async {
    final XFile? photo = await imageHelper.takePhoto();
    if (photo != null) {
      setState(() {
        files.add(photo);
      });
      final String base64Image = await _imageToBase64(photo);
      debugPrint('Base64 Image: $base64Image');
    }
  }

  // METHODS
  void _getFotos() {
    setState(() {
      _isLoading = true;
      _hasServerError = false;
    });
    context.read<RemoteInspeccionFicheroBloc>().add(ListInspeccionFicheros(widget.objData));
  }

  Future<String> _imageToBase64(XFile image) async {
    final List<int> arrBytes = File(image.path).readAsBytesSync();
    return base64Encode(arrBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text($strings.checklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
      body: BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
        listener: (BuildContext context, RemoteInspeccionFicheroState state) {
          if (state is RemoteInspeccionFicheroLoading) {
            setState(() {
              _isLoading      = true;
              _hasServerError = false;
            });
          }

          if (state is RemoteInspeccionFicheroServerFailedMessageList) {
            setState(() {
              _hasServerError = true;
              _isLoading      = false;
            });
          }

          if (state is RemoteInspeccionFicheroServerFailureList) {
            setState(() {
              _hasServerError = true;
              _isLoading      = false;
            });
          }

          if (state is RemoteInspeccionFicheroSuccess) {
            setState(() {
              unidadNumeroEconomico   = state.objResponse?.inspeccion.unidadNumeroEconomico ?? '';
              unidadTipoName          = state.objResponse?.inspeccion.unidadTipoName        ?? '';
              unidadNumeroSerie       = state.objResponse?.inspeccion.numeroSerie           ?? '';
              idInspeccionEstatus     = state.objResponse?.inspeccion.idInspeccionEstatus   ?? '';

              _hasServerError = false;
              _isLoading      = false;
            });
          }
        },
        builder: (BuildContext context, RemoteInspeccionFicheroState state) {
          if (state is RemoteInspeccionFicheroServerFailedMessageList) {
            return ErrorInfoContainer(
              onPressed     : _getFotos,
              errorMessage  : state.errorMessage,
            );
          }

          if (state is RemoteInspeccionFicheroServerFailureList) {
            return ErrorInfoContainer(
              onPressed     : _getFotos,
              errorMessage  : state.failure?.errorMessage,
            );
          }

          if (state is RemoteInspeccionFicheroLoading) {
            return const Center(child: AppLoadingIndicator());
          }

          if (state is RemoteInspeccionFicheroSuccess) {
            return Column(
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
                      Text('$unidadNumeroEconomico', style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3)),

                      RichText(
                        text: TextSpan(
                          style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                          children  : <InlineSpan>[
                            const TextSpan(text: 'Tipo de unidad'),
                            TextSpan(text: ': $unidadTipoName'),
                          ],
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                          children  : <InlineSpan>[
                            const TextSpan(text: 'Número de serie'),
                            TextSpan(text: ': $unidadNumeroSerie'),
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

                if (files.isNotEmpty)
                  Expanded(
                    child: RepaintBoundary(
                      child: _PhotosGrid(imageFiles: files),
                    ),
                  )
                else
                  Expanded(
                    child: RequestDataUnavailable(
                      title         : $strings.checklistPhotoEmptyListTitle,
                      message       : $strings.checklistPhotoEmptyListMessage,
                      onRefresh     : _getFotos,
                    ),
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: !_isLoading && !_hasServerError
          ? FloatingActionButton(
              onPressed : _handleTakePhotoPressed,
              tooltip   : 'Tomar fotografía',
              child     : const Icon(Icons.camera_alt),
            )
          : null,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
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
          // FilledButton(
          //   onPressed : () => Navigator.pop(context),
          //   style     : ButtonStyle(
          //     backgroundColor : MaterialStateProperty.all<Color>(const Color(0xFFD9E4F0)),
          //     foregroundColor : MaterialStateProperty.all<Color>(const Color(0xff233876)),
          //   ),
          //   child     : Text($strings.prevButtonText, style: $styles.textStyles.button),
          // ),
          const Spacer(),
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : _handleNextPressed,
            semanticLabel : $strings.nextButtonText,
          ),
        ],
      ),
    );
  }
}
