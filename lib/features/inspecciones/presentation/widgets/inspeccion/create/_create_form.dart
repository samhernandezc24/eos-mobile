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

  // CONTROLLERS

  // PROPERTIES
  InspeccionUnidadSelectOption _inspeccionUnidadSelectOption = InspeccionUnidadSelectOption.inventario;

  String _errorMessage  = '';
  bool _hasServerError  = false;
  bool _isLoading       = false;

  // LIST
  List<UnidadPredictiveListEntity> lstUnidades        = [];
  List<UnidadEOSPredictiveListEntity> lstUnidadesEOS  = [];

  // STATE
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo guardar la inspección.',
      ),
    );
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
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
        BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (context, state) {
            // LOADING
            if (state is RemoteUnidadPredictiveLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // ERROR
            if (state is RemoteUnidadServerFailedMessagePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.errorMessage ?? 'Error inesperado';
              });
            }

            if (state is RemoteUnidadServerFailurePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.failure?.errorMessage ?? 'Error inesperado';
              });
            }

            // SUCCESS
            if (state is RemoteUnidadPredictiveLoaded) {
              setState(() {
                _isLoading      = false;
                _hasServerError = false;

                lstUnidades = state.objResponse ?? [];
              });
            }
          },
          child: _SearchUnidadInput(
            boolError     : _hasServerError,
            boolSearch    : _isLoading,
            errorMessage  : _errorMessage,
            lstRows       : lstUnidades,
            onSubmit      : _handleUnidadSearchSubmitted,
            onSelected    : (_){},
            onClearField  : (){},
          ),
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
              // _SearchUnidadInput(
              //   // controller    : _searchUnidadEOSTextController,
              //   onSubmit      : _handleUnidadEOSSearchSubmitted,
              //   // onClearField  : (){},
              // ),
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

  Widget _buildBottomAppBar(BuildContext context) {
     return BottomAppBar(
      height: 70,
      child : Row(
        children: <Widget>[
          IconButton(
            onPressed : (){},
            icon      : const Icon(Icons.refresh),
            tooltip   : 'Actualizar datos',
          ),
          const Spacer(),
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }

              if (state is RemoteInspeccionStoreSuccess) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nueva inspección', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.onFinish!();
              }
            },
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionStoreLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }
              return FilledButton(
                onPressed : (){},
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
