// part of 'create_inspeccion_page.dart';

// class _CreateForm extends StatefulWidget {
//   const _CreateForm({Key? key}) : super(key: key);

//   @override
//   State<_CreateForm> createState() => _CreateFormState();
// }

// class _CreateFormState extends State<_CreateForm> {
//   // GLOBAL KEY
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // CONTROLLERS
//   late final TextEditingController _searchUnidadController;

//   late final TextEditingController _fechaProgramadaController;
//   late final TextEditingController _baseNameController;
//   late final TextEditingController _unidadNumeroEconomicoController;
//   late final TextEditingController _unidadTipoNameController;
//   late final TextEditingController _unidadMarcaNameController;
//   late final TextEditingController _unidadPlacaTipoNameController;
//   late final TextEditingController _placaController;
//   late final TextEditingController _numeroSerieController;
//   late final TextEditingController _modeloController;
//   late final TextEditingController _anioEquipoController;
//   late final TextEditingController _capacidadController;
//   late final TextEditingController _unidadCapacidadMedidaNameController;
//   late final TextEditingController _locacionController;
//   late final TextEditingController _tipoPlataformaController;
//   late final TextEditingController _odometroController;
//   late final TextEditingController _horometroController;

//   // LIST
//   late List<UnidadSearchEntity> lstUnidades                        = <UnidadSearchEntity>[];
//   late List<InspeccionTipoEntity> lstInspeccionesTipos             = <InspeccionTipoEntity>[];
//   late List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = <UnidadCapacidadMedida>[];

//   // SELECTED INSPECCION TIPO
//   String? _selectedInspeccionTipoId;
//   String? _selectedInspeccionTipoCodigo;
//   String? _selectedInspeccionTipoName;

//   // SELECTED UNIDAD
//   UnidadInspeccion? _selectedUnidadInspeccion;
//   // ignore: unused_field
//   UnidadSearchEntity? _selectedUnidad;

//   String? _selectedUnidadBaseId;
//   String? _selectedUnidadId;
//   String? _selectedUnidadTipoId;
//   String? _selectedUnidadMarcaId;
//   String? _selectedUnidadPlacaTipoId;

//   // SELECTED UNIDAD CAPACIDAD MEDIDA
//   String? _selectedUnidadCapacidadMedidaId;

//   void _handleSearchSubmitted(UnidadSearchEntity? selectedType) {
//     setState(() {
//       _selectedUnidad                           = selectedType;
//       _selectedUnidadId                         = selectedType?.idUnidad                  ?? '';
//       _selectedUnidadBaseId                     = selectedType?.idBase                    ?? '';
//       _selectedUnidadTipoId                     = selectedType?.idUnidadTipo              ?? '';
//       _selectedUnidadMarcaId                    = selectedType?.idUnidadMarca             ?? '';
//       _selectedUnidadPlacaTipoId                = selectedType?.idUnidadPlacaTipo         ?? '';
//       _selectedUnidadCapacidadMedidaId          = selectedType?.idUnidadCapacidadMedida   ?? '';

//       _unidadNumeroEconomicoController.text     = selectedType?.numeroEconomico           ?? '';
//       _baseNameController.text                  = selectedType?.baseName                  ?? '';
//       _unidadTipoNameController.text            = selectedType?.unidadTipoName            ?? '';
//       _unidadMarcaNameController.text           = selectedType?.unidadMarcaName           ?? '';
//       _unidadPlacaTipoNameController.text       = selectedType?.unidadPlacaTipoName       ?? '';
//       _placaController.text                     = selectedType?.placa                     ?? '';
//       _numeroSerieController.text               = selectedType?.numeroSerie               ?? '';
//       _modeloController.text                    = selectedType?.modelo                    ?? '';
//       _anioEquipoController.text                = selectedType?.anioEquipo                ?? '';
//       _capacidadController.text                 = selectedType?.capacidad                 ?? '';
//       _unidadCapacidadMedidaNameController.text = selectedType?.unidadCapacidadMedidaName ?? '';
//       _odometroController.text                  = selectedType?.odometro                  ?? '';
//       _horometroController.text                 = selectedType?.horometro                 ?? '';
//     });
//   }

//   void _handleStoreInspeccion() {
//     final DateTime? fechaProgramada  = _fechaProgramadaController.text.isNotEmpty ? DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text) : null;

//     final double? capacidad         = double.tryParse(_capacidadController.text);
//     final int? odometro             = int.tryParse(_odometroController.text);
//     final int? horometro            = int.tryParse(_horometroController.text);

//     final InspeccionStoreReqEntity objData = InspeccionStoreReqEntity(
//       fechaProgramada             : fechaProgramada                 ?? DateTime.now(),
//       idInspeccionTipo            : _selectedInspeccionTipoId       ?? '',
//       inspeccionTipoCodigo        : _selectedInspeccionTipoCodigo   ?? '',
//       inspeccionTipoName          : _selectedInspeccionTipoName     ?? '',
//       idBase                      : _selectedUnidadBaseId           ?? '',
//       baseName                    : _baseNameController.text,
//       idUnidad                    : _selectedUnidadId               ?? '',
//       unidadNumeroEconomico       : _unidadNumeroEconomicoController.text,
//       isUnidadTemporal            : _selectedUnidadInspeccion == UnidadInspeccion.temporal,
//       idUnidadTipo                : _selectedUnidadTipoId           ?? '',
//       unidadTipoName              : _unidadTipoNameController.text,
//       idUnidadMarca               : _selectedUnidadMarcaId          ?? '',
//       unidadMarcaName             : _unidadMarcaNameController.text,
//       idUnidadPlacaTipo           : _selectedUnidadPlacaTipoId      ?? '',
//       unidadPlacaTipoName         : _unidadPlacaTipoNameController.text,
//       placa                       : _unidadPlacaTipoNameController.text,
//       numeroSerie                 : _numeroSerieController.text,
//       modelo                      : _modeloController.text,
//       anioEquipo                  : _anioEquipoController.text,
//       capacidad                   : capacidad,
//       idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedidaId ?? '',
//       unidadCapacidadMedidaName   : _unidadCapacidadMedidaNameController.text,
//       locacion                    : _locacionController.text,
//       tipoPlataforma              : _tipoPlataformaController.text,
//       odometro                    : odometro,
//       horometro                   : horometro,
//     );

//     final bool isValidForm = _formKey.currentState!.validate();

//     // Verificar la validacion en el formulario.
//     if (isValidForm) {
//       _formKey.currentState!.save();
//       BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objData));
//     }
//   }

//   Future<void> _showFailureDialog(BuildContext context, RemoteInspeccionServerFailure state) {
//     return showDialog<void>(
//       context   : context,
//       builder   : (_) => AlertDialog(
//         title   : const SizedBox.shrink(),
//         content : Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             Gap($styles.insets.sm),
//             Flexible(
//               child: Text(
//                 state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la inspección de nuevo.',
//                 style: $styles.textStyles.title2.copyWith(height: 1.5),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(onPressed: () => context.pop(), child: Text($strings.acceptButtonText, style: $styles.textStyles.button)),
//         ],
//       ),
//     );
//   }

//   Future<void> _showFailedMessageDialog(BuildContext context, RemoteInspeccionServerFailedMessage state) {
//     return showDialog<void>(
//       context   : context,
//       builder   : (_) => AlertDialog(
//         title   : const SizedBox.shrink(),
//         content : Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             Gap($styles.insets.sm),
//             Flexible(
//               child: Text(
//                 state.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la inspección de nuevo.',
//                 style: $styles.textStyles.title2.copyWith(height: 1.5),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(onPressed: () => context.pop(), child: Text($strings.acceptButtonText, style: $styles.textStyles.button)),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           // CAMBIAR DINAMICAMENTE ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
//           _buildUnidadCheckbox(UnidadInspeccion.temporal, 'Unidad temporal'),

//           Gap($styles.insets.xs),

//           Text(
//             '(Es necesario que realice la búsqueda de la unidad antes de crear la inspección)',
//             style: $styles.textStyles.bodySmall.copyWith(fontSize: 12),
//           ),

//           Gap($styles.insets.xs),

//           // SELECCIONAR Y BUSCAR UNIDAD A INSPECCIONAR:
//           if (_selectedUnidadInspeccion == UnidadInspeccion.temporal)
//             BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
//               builder: (BuildContext context, RemoteUnidadState state) {
//                 if (state is RemoteUnidadSearchLoading) {
//                   return const Center(child: AppLoadingIndicator(width: 20, height: 20));
//                 }

//                 if (state is RemoteUnidadServerFailedMessage) {
//                   return ErrorBoxContainer(
//                     errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
//                     onPressed     : () {
//                       // Cargar listado de unidades.
//                       context.read<RemoteUnidadBloc>().add(ListUnidades());

//                       // Cargar listado de tipos de inspecciones.
//                       context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
//                     },
//                   );
//                 }

//                 if (state is RemoteUnidadServerFailure) {
//                   return ErrorBoxContainer(
//                     errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
//                     onPressed     : () {
//                       // Cargar listado de unidades.
//                       context.read<RemoteUnidadBloc>().add(ListUnidades());

//                       // Cargar listado de tipos de inspecciones.
//                       context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
//                     },
//                   );
//                 }

//                 if (state is RemoteUnidadSearchLoaded) {
//                   lstUnidades = state.unidades ?? [];

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       _SearchInput(
//                         onSelected  : _handleSearchSubmitted,
//                         onSubmit    : (_){}, unidades: lstUnidades,
//                       ),
//                     ],
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             )
//           else BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
//             builder: (BuildContext context, RemoteUnidadState state) {
//               if (state is RemoteUnidadSearchLoading) {
//                 return const Center(child: AppLoadingIndicator(width: 20, height: 20));
//               }

//               if (state is RemoteUnidadServerFailedMessage) {
//                 return ErrorBoxContainer(
//                   errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
//                   onPressed     : () {
//                     // Cargar listado de unidades.
//                     context.read<RemoteUnidadBloc>().add(ListUnidades());

//                     // Cargar listado de tipos de inspecciones.
//                     context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
//                   }
//                 );
//               }

//               if (state is RemoteUnidadServerFailure) {
//                 return ErrorBoxContainer(
//                   errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
//                   onPressed     : () {
//                     // Cargar listado de unidades.
//                     context.read<RemoteUnidadBloc>().add(ListUnidades());

//                     // Cargar listado de tipos de inspecciones.
//                     context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
//                   },
//                 );
//               }

//               if (state is RemoteUnidadSearchLoaded) {
//                 lstUnidades = state.unidades ?? [];

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     _SearchInput(
//                       onSelected  : _handleSearchSubmitted,
//                       onSubmit    : (_){}, unidades: lstUnidades,
//                     ),
//                   ],
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),

//           // NUEVA UNIDAD TEMPORAL:
//           AnimatedSwitcher(
//             duration: $styles.times.fast,
//             transitionBuilder: (Widget child, Animation<double> animation) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: SizeTransition(sizeFactor: animation, child: child),
//               );
//             },
//             child: _selectedUnidadInspeccion == UnidadInspeccion.temporal
//                 ? Padding(
//                     padding: EdgeInsets.only(top: $styles.insets.sm),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         FilledButton.icon(
//                           onPressed : () => _handleCreateUnidadPressed(context),
//                           icon      : const Icon(Icons.add),
//                           label     : Text('Nueva unidad', style: $styles.textStyles.button),
//                         ),
//                       ],
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),

//           Gap($styles.insets.sm),

//           // SELECCIONAR TIPO DE INSPECCIÓN:
//           BlocListener<RemoteInspeccionBloc, RemoteInspeccionState>(
//             listener: (BuildContext context, RemoteInspeccionState state) {
//               if (state is RemoteInspeccionCreateLoaded) {
//                 // FRAGMENTO NO MODIFICABLE - LISTAS
//                 setState(() {
//                   lstInspeccionesTipos = state.objResponse?.inspeccionesTipos ?? [];
//                 });
//               }
//             },
//             child: LabeledDropdownFormField<InspeccionTipoEntity>(
//               hintText    : 'Seleccionar',
//               label       : '* Tipo de inspección:',
//               items       : lstInspeccionesTipos,
//               itemBuilder : (item) => Text(item.name),
//               onChanged   : (selectedType) {
//                 setState(() {
//                   _selectedInspeccionTipoId       = selectedType?.idInspeccionTipo;
//                   _selectedInspeccionTipoCodigo   = selectedType?.codigo;
//                   _selectedInspeccionTipoName     = selectedType?.name;
//                 });
//               },
//               validator : FormValidators.dropdownValidator,
//             ),
//           ),

//           Gap($styles.insets.sm),

//           // FECHA PROGRAMADA:
//           LabeledTextFormField(
//             controller  : _fechaProgramadaController,
//             isReadOnly  : true,
//             label       : '* Fecha programada:',
//             onTap       : () async => _handleFechaProgramadaPressed(context),
//             textAlign   : TextAlign.end,
//             validator   : FormValidators.textValidator,
//           ),

//           Gap($styles.insets.sm),

//           // UNIDAD NUMERO ECONOMICO:
//           LabeledTextFormField(
//             controller  : _unidadNumeroEconomicoController,
//             isReadOnly  : true,
//             label       : '* Número económico:',
//             // validator   : FormValidators.textValidator,
//           ),

//           Gap($styles.insets.sm),

//           // UNIDAD TIPO NAME:
//           LabeledTextFormField(
//             controller  : _unidadTipoNameController,
//             isReadOnly  : true,
//             label       : '* Tipo de unidad:',
//             // validator   : FormValidators.textValidator,
//           ),

//           Gap($styles.insets.sm),

//           // UNIDAD MARCA NAME / MODELO:
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _unidadMarcaNameController,
//                   isReadOnly  : true,
//                   label       : 'Marca:',
//                 ),
//               ),
//               Gap($styles.insets.sm),
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _modeloController,
//                   isReadOnly  : true,
//                   label       : 'Modelo:',
//                 ),
//               ),
//             ],
//           ),

//           Gap($styles.insets.sm),

//           // UNIDAD PLACA TIPO NAME / PLACA:
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _unidadPlacaTipoNameController,
//                   isReadOnly  : true,
//                   label       : 'Tipo de placa:',
//                 ),
//               ),
//               Gap($styles.insets.sm),
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _placaController,
//                   isReadOnly  : true,
//                   label       : 'Placa:',
//                 ),
//               ),
//             ],
//           ),

//           Gap($styles.insets.sm),

//           // NUMERO SERIE / AÑO DEL EQUIPO:
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _numeroSerieController,
//                   isReadOnly  : true,
//                   label       : 'Número de serie:',
//                 ),
//               ),
//               Gap($styles.insets.sm),
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller  : _anioEquipoController,
//                   isReadOnly  : true,
//                   label       : 'Año del equipo:',
//                 ),
//               ),
//             ],
//           ),

//           Gap($styles.insets.sm),

//           // LOCACIÓN DE INSPECCIÓN:
//           LabeledTextareaFormField(
//             controller    : _locacionController,
//             hintText      : 'Ingresa lugar de inspección',
//             labelText     : '* Locación:',
//             maxLines      : 2,
//             maxCharacters : 300,
//             validator     : FormValidators.textValidator,
//           ),

//           Gap($styles.insets.sm),

//           // BASE:
//           LabeledTextFormField(
//             controller  : _baseNameController,
//             isReadOnly  : true,
//             label       : '* Base:',
//           ),

//           Gap($styles.insets.sm),

//           // TIPO DE PLATAFORMA:
//           LabeledTextFormField(
//             controller  : _tipoPlataformaController,
//             label       : 'Tipo de plataforma:',
//           ),

//           Gap($styles.insets.sm),

//           // UNIDAD CAPACIDAD / UNIDAD CAPACIDAD MEDIDA:
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller    : _capacidadController,
//                   isReadOnly    : true,
//                   label         : '* Capacidad:',
//                 ),
//               ),
//               Gap($styles.insets.xs),
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller    : _unidadCapacidadMedidaNameController,
//                   isReadOnly    : true,
//                   label         : '* Tipo de capacidad',
//                 ),
//               ),
//             ],
//           ),

//           Gap($styles.insets.sm),

//           // ODOMETRO / HOROMETRO:
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller    : _odometroController,
//                   hintText      : 'Ingresa cantidad',
//                   keyboardType  : TextInputType.number,
//                   label         : 'Odómetro:',
//                 ),
//               ),
//               Gap($styles.insets.sm),
//               Expanded(
//                 child: LabeledTextFormField(
//                   controller    : _horometroController,
//                   hintText      : 'Ingresa cantidad',
//                   keyboardType  : TextInputType.number,
//                   label         : 'Horómetro:',
//                 ),
//               ),
//             ],
//           ),

//           Gap($styles.insets.lg),

//           BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
//             listener: (BuildContext context, RemoteInspeccionState state) {
//               if (state is RemoteInspeccionServerFailure) {
//                 _showFailureDialog(context, state);
//               }

//               if (state is RemoteInspeccionServerFailedMessage) {
//                 _showFailedMessageDialog(context, state);
//               }

//               if (state is RemoteInspeccionStored) {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context)
//                 ..hideCurrentSnackBar()
//                 ..showSnackBar(
//                   SnackBar(
//                     content         : Text(state.objResponse?.message ?? '', softWrap: true),
//                     backgroundColor : Colors.green,
//                     behavior        : SnackBarBehavior.fixed,
//                     elevation       : 0,
//                   ),
//                 );
//               }
//             },
//             builder: (BuildContext context, RemoteInspeccionState state) {
//               if (state is RemoteInspeccionStoring) {
//                 return FilledButton(
//                   onPressed : null,
//                   style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
//                   child     : const AppLoadingIndicator(width: 20, height: 20),
//                 );
//               }

//               return FilledButton(
//                 onPressed : _handleStoreInspeccion,
//                 style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
//                 child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildUnidadCheckbox(UnidadInspeccion unidad, String value) {
//     if (unidad == UnidadInspeccion.temporal) {
//       final bool isSelectedUnidad = _selectedUnidadInspeccion == unidad;

//       return GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedUnidadInspeccion = isSelectedUnidad ? null : unidad;
//           });
//         },
//         child: Row(
//           children: <Widget>[
//             Checkbox(
//               value: isSelectedUnidad,
//               onChanged: (value) {
//                 if (value != null) {
//                    setState(() {
//                     _selectedUnidadInspeccion = value ? unidad : null;
//                   });
//                 }
//               },
//             ),
//             Text(value, style: $styles.textStyles.label),
//           ],
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }
