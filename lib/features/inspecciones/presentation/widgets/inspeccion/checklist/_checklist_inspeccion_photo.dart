part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionPhoto extends StatefulWidget {
  const _ChecklistInspeccionPhoto({required this.objData, required this.objInspeccion, Key? key}) : super(key: key);

  final InspeccionIdReqEntity objData;
  final InspeccionDataSourceEntity objInspeccion;

  @override
  State<_ChecklistInspeccionPhoto> createState() => __ChecklistInspeccionPhotoState();
}

class __ChecklistInspeccionPhotoState extends State<_ChecklistInspeccionPhoto> {
  // NOTIFIERS
  final ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);

  // PROPERTIES
  String? imageBase64             = '';
  String? unidadNumeroEconomico   = '';
  String? unidadTipoName          = '';
  String? unidadNumeroSerie       = '';
  String? idInspeccionEstatus     = '';

  int indexUpload       = 0;
  int countQueueUpload  = 0;
  int countQueueTotal   = 0;

  bool isSave = false;

  // LIST
  List<Fichero> lstFicheros = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _getFotos();
  }

  // EVENTS
  void _handleNextPressed() {
    if (lstFicheros.isEmpty) {
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

  void _handleCreatePressed(BuildContext context) {
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
            child     : _CreateInspeccionFicheroForm(buildFicheroDataCallback: _getFotos, objInspeccion: widget.objInspeccion),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // METHODS
  Future<void> _getFotos() async {
    context.read<RemoteInspeccionFicheroBloc>().add(ListInspeccionFicheros(widget.objData));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (isDialOpen.value) {
            isDialOpen.value = false;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text($strings.checklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
          listener: (BuildContext context, RemoteInspeccionFicheroState state) {
            // SUCCESS:
            if (state is RemoteInspeccionFicheroSuccess) {
              setState(() {
                // DATOS
                unidadNumeroEconomico   = state.objResponse?.inspeccion.unidadNumeroEconomico ?? '';
                unidadTipoName          = state.objResponse?.inspeccion.unidadTipoName        ?? '';
                unidadNumeroSerie       = state.objResponse?.inspeccion.numeroSerie           ?? '';
                idInspeccionEstatus     = state.objResponse?.inspeccion.idInspeccionEstatus   ?? '';

                // LIST FICHEROS
                lstFicheros = state.objResponse?.ficheros ?? [];
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionFicheroState state) {
            if (state is RemoteInspeccionFicheroLoading) {
              return const Center(child: AppLoadingIndicator());
            }

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

                        const Divider(),

                        Row(
                          children: <Widget>[
                            FilledButton.icon(onPressed: _getFotos, icon: const Icon(Icons.refresh), label: const Text('Actualizar')),
                            Gap($styles.insets.xs),
                            FilledButton.icon(onPressed: () => _handleCreatePressed(context), icon: const Icon(Icons.add), label: const Text('Nuevo')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: lstFicheros.isNotEmpty
                        ? RepaintBoundary(
                            child: _PhotoGrid(lstFicheros: lstFicheros),
                          )
                        : RequestDataUnavailable(
                            title         : $strings.checklistPhotoEmptyListTitle,
                            message       : $strings.checklistPhotoEmptyListMessage,
                            isRefreshData : false,
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
      ),
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
