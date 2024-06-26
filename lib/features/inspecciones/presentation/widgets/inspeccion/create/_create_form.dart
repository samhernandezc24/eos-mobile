part of '../../../pages/list/list_page.dart';

class _CreateInspeccionForm extends StatefulWidget {
  const _CreateInspeccionForm({Key? key, this.onFinish}) : super(key: key);

  final VoidCallback? onFinish;

  @override
  State<_CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<_CreateInspeccionForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey   = GlobalKey<FormState>();
  final LayerLink _optionsLayerLink     = LayerLink();

  // CONTROLLERS
  late TextEditingController _searchUnidadTextController;
  late TextEditingController _searchUnidadEOSTextController;

  // PROPERTIES
  InspeccionUnidadSelectOption _inspeccionUnidadSelectOption = InspeccionUnidadSelectOption.inventario;
  OverlayEntry? _floatingOptions;

  // LIST
  List<UnidadPredictiveListEntity> lstUnidades        = [];
  List<UnidadEOSPredictiveListEntity> lstUnidadesEOS  = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _searchUnidadTextController     = TextEditingController();
    _searchUnidadEOSTextController  = TextEditingController();
  }

  @override
  void dispose() {
    _searchUnidadTextController.dispose();
    _searchUnidadEOSTextController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text($strings.exitConfirmationDialogTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          content: Text($strings.exitConfirmationDialogMessage, style: $styles.textStyles.body.copyWith(height: 1.3)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, $strings.cancelButtonText),
              child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();    // Cerrar dialog
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();  // Cerrar ventana
                  widget.onFinish!();           // Ejecutar callback de actualización
                });
              },
              child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  void _onChangeSelectOption(bool? value) {
    setState(() {
      _inspeccionUnidadSelectOption = value ?? false
          ? InspeccionUnidadSelectOption.temporal
          : InspeccionUnidadSelectOption.inventario;
    });
  }

  void _handleUnidadSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) { return; }

    final List<SearchFilterPredictive> lstSearchFilters = [
      const SearchFilterPredictive(field: 'NumeroEconomico'),
      const SearchFilterPredictive(field: 'NumeroSerie'),
      const SearchFilterPredictive(field: 'UnidadTipoName'),
    ];

    final Predictive varArgs = Predictive(
      search          : query,
      searchFilters   : lstSearchFilters,
      filters         : const {},
      columns         : const {},
      dateFilters     : const DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadBloc>(context).add(PredictiveUnidades(varArgs));
  }

  void _handleUnidadEOSSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) { return; }

    final List<SearchFilterPredictive> lstSearchFilters = [
      const SearchFilterPredictive(field: 'NumeroEconomico'),
      const SearchFilterPredictive(field: 'NumeroSerie'),
      const SearchFilterPredictive(field: 'UnidadTipoName'),
    ];

    final Predictive varArgs = Predictive(
      search          : query,
      searchFilters   : lstSearchFilters,
      filters         : const {},
      columns         : const {},
      dateFilters     : const DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadEOSBloc>(context).add(PredictiveEOSUnidades(varArgs));
  }

  // METHODS

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _handleDidPopPressed(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text($strings.inspeccionCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // ALTERNAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL
                  _buildInspeccionUnidadSelector(),

                  // SECCION DE SUGERENCIA
                  RichText(
                    text: TextSpan(
                      style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: ': ${$strings.inspeccionCreateSuggestion}'),
                      ],
                    ),
                  ),

                  Gap($styles.insets.xs),

                  // BUSCADOR PREDICTIVO DE UNIDADES
                  _buildUnidadSearchPredictive(context),

                  // CAMPOS DEL FORMULARIO
                  Text('Formulario 1'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInspeccionUnidadSelector() {
    final bool isSelected = _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal;
    return GestureDetector(
      onTap: () => _onChangeSelectOption(!isSelected),
      child: Row(
        children: <Widget>[
          Checkbox(value: isSelected, onChanged : _onChangeSelectOption),
          Text(isSelected ? 'Buscar unidad temporal' : 'Buscar unidad inventario', style: $styles.textStyles.body),
        ],
      ),
    );
  }

  Widget _buildUnidadSearchPredictive(BuildContext context) {
    return _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.inventario
        ? _buildUnidadEOSSearch(context)
        : _buildUnidadSearch(context);
  }

  // BUSCADOR PREDICTIVO DE UNIDADES TEMPORALES
  Widget _buildUnidadSearch(BuildContext context) {
    return Column(
      children: <Widget>[
        _SearchUnidadInput(
          controller    : _searchUnidadTextController,
          onSubmit      : _handleUnidadSearchSubmitted,
          onClearField  : (){},
        ),
        BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (BuildContext context, RemoteUnidadState state) {
            if (state is RemoteUnidadPredictiveLoaded) {
              setState(() {
                lstUnidades = state.objResponse ?? [];
              });
            }
          },
          builder: (BuildContext context, RemoteUnidadState state) {
            if (state is RemoteUnidadPredictiveLoading) {
              return const AppLinearIndicator();
            }
            if (state is RemoteUnidadPredictiveLoaded) {
              final List<Widget> items = lstUnidades.map((item) => _buildSuggestion(context, item.numeroEconomico, (){})).toList();
              items.insert(0, _buildSuggestionTitle(context));

              return TopLeft(
                child: Container(
                  margin: EdgeInsets.only(top: $styles.insets.xxs),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color       : Colors.black.withOpacity(0.25),
                        blurRadius  : 4,
                        offset      : const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all($styles.insets.xs),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(0.92),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular($styles.insets.xs),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView(
                        padding: EdgeInsets.all($styles.insets.xs),
                        shrinkWrap: true,
                        children: items,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // BUSCADOR PREDICTIVO DE UNIDADES DE INVENTARIO
  Widget _buildUnidadEOSSearch(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrinats) {
        return Center(
          child: Column(
            children: <Widget>[
              _SearchUnidadInput(
                controller    : _searchUnidadEOSTextController,
                onSubmit      : _handleUnidadEOSSearchSubmitted,
                onClearField  : (){},
              ),
              BlocConsumer<RemoteUnidadEOSBloc, RemoteUnidadEOSState>(
                listener: (BuildContext context, RemoteUnidadEOSState state) {
                  if (state is RemoteUnidadEOSPredictiveLoaded) {
                    setState(() {
                      lstUnidadesEOS = state.objResponse ?? [];
                    });
                  }
                },
                builder: (BuildContext context, RemoteUnidadEOSState state) {
                  if (state is RemoteUnidadEOSPredictiveLoading) {
                    return const AppLinearIndicator();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuggestionTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
      margin: EdgeInsets.only(bottom: $styles.insets.xxs),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)))),
      child: CenterLeft(
        child: DefaultTextStyle(
          style: $styles.textStyles.title2.copyWith(color: Theme.of(context).colorScheme.onSurface),
          child: Text(
            $strings.searchInputResultsTitle.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      onPressed: onPressed,
      semanticLabel: suggestion,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: CenterLeft(
          child: DefaultTextStyle(
            style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface),
            child: Text(
              suggestion,
              overflow: TextOverflow.ellipsis,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
          ),
        ),
      ),
    );
  }
}
