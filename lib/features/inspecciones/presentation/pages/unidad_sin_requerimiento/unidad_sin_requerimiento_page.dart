import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/core/enums/view_form_control.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({super.key});

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() => _InspeccionUnidadSinRequerimientoPageState();
}

class _InspeccionUnidadSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final ScrollController _scrollController               = ScrollController();
  late final TextEditingController _fechaInspeccionController = TextEditingController();
  late final TextEditingController _numeroEconomicoController = TextEditingController();

  // LIST
  static const List<(ViewFormControl, String, Icon)> _segmentItems = <(ViewFormControl, String, Icon)>[
    (ViewFormControl.list, 'Diseño de lista', Icon(Icons.menu_sharp, size: 24)),
    (ViewFormControl.tree, 'Diseño de árbol', Icon(Icons.account_tree, size: 24)),
  ];

  late List<dynamic> lstUnidades          = <dynamic>['A', 'B'];
  late List<dynamic> lstInspeccionesTipos = <dynamic>['A', 'B'];
  late List<dynamic> lstUnidadesMarcas    = <dynamic>['A', 'B'];
  late List<dynamic> lstBases             = <dynamic>['A', 'B'];

  // COLLECTIONS
  Set<ViewFormControl> _segmentedButtonsSelection = <ViewFormControl>{ViewFormControl.list};

  // PROPERTIES
  UnidadInspeccionTipo? _unidadRadioControl = UnidadInspeccionTipo.inventario;

  bool _showScrollToTopButton   = false;
  bool _showCreateUnidadButton  = false;

  @override
  void initState() {
    super.initState();
    _fechaInspeccionController.text = DateFormat.yMd().add_jm().format(DateTime.now());
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    super.dispose();
  }

  // METHODS
  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text($strings.inspectionNoReqAppBarText, style: $styles.textStyles.h3)),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              _showScrollToTopButton = _scrollController.offset > 100;
            });
          }
          return true;
        },
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.all($styles.insets.sm),
          children: <Widget>[
            // CAMBIAR MODO DE VISUALIZACIÓN DEL FORMULARIO
            _buildSegmentedButton(),

            Gap($styles.insets.sm),

            // FORMULARIO DE LA INSPECCIÓN DE UNIDAD
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Radio<UnidadInspeccionTipo>(
                                  value: UnidadInspeccionTipo.inventario,
                                  groupValue: _unidadRadioControl,
                                  onChanged: (UnidadInspeccionTipo? value){
                                    setState(() {
                                      _unidadRadioControl     = value;
                                      _showCreateUnidadButton = false;
                                    });
                                  },
                                ),
                                Expanded(child: Text('Unidad Inventario', style: $styles.textStyles.label)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  value: UnidadInspeccionTipo.temporal,
                                  groupValue: _unidadRadioControl,
                                  onChanged: (UnidadInspeccionTipo? value) {
                                    setState(() {
                                      _unidadRadioControl     = value;
                                      _showCreateUnidadButton = true;
                                    });
                                  },
                                ),
                                Expanded(child: Text('Unidad Temporal', style: $styles.textStyles.label)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // SELECCIONAR UNIDAD (INVENTARIO O TEMPORAL)
                      LabeledDropdownFormField(
                        labelText: '* Seleccione la unidad que desea inspeccionar:',
                        hintText: 'Seleccionar',
                        onChanged: (_){},
                        items: lstUnidades,
                      ),

                      AnimatedSwitcher(
                        duration: $styles.times.fast,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(sizeFactor: animation, child: child),
                          );
                        },
                        child: _showCreateUnidadButton
                            ? Padding(
                                padding: EdgeInsets.only(top: $styles.insets.sm),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FilledButton.icon(
                                      onPressed: (){},
                                      icon: const Icon(Icons.add),
                                      label: Text('Nueva Unidad', style: $styles.textStyles.button),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      Gap($styles.insets.sm),

                      // SELECCIONAR TIPO DE INSPECCIÓN
                      LabeledDropdownFormField(
                        labelText: '* Seleccione el tipo de inspección:',
                        hintText: 'Seleccionar',
                        onChanged: (_){},
                        items: lstInspeccionesTipos,
                      ),

                      Gap($styles.insets.sm),

                      // FECHA DE LA INSPECCIÓN
                      LabeledTextField(
                        controller: _fechaInspeccionController,
                        isReadOnly: true,
                        labelText: 'Fecha de la inspección:',
                        textAlign: TextAlign.end,
                      ),

                      Gap($styles.insets.sm),

                      // NO. ECONÓMICO
                      LabeledTextField(
                        controller: _fechaInspeccionController,
                        labelText: 'No. Económico:',
                      ),

                      Gap($styles.insets.sm),

                      // MARCA / MODELO DE LA UNIDAD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: LabeledDropdownFormField(
                              labelText: '* Seleccione la marca:',
                              hintText: 'Seleccionar',
                              onChanged: (_){},
                              items: lstUnidadesMarcas,
                            ),
                          ),
                          SizedBox(width: $styles.insets.sm),
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Modelo:',
                            ),
                          ),
                        ],
                      ),

                      Gap($styles.insets.sm),

                      // NO. DE SERIE / PLACA DE LA UNIDAD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Número de serie:',
                            ),
                          ),
                          SizedBox(width: $styles.insets.sm),
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Placa:',
                            ),
                          ),
                        ],
                      ),

                      Gap($styles.insets.sm),

                      // CAPACIDAD / AÑO DEL EQUIPO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Capacidad:',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: $styles.insets.sm),
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Año del equipo:',
                            ),
                          ),
                        ],
                      ),

                      Gap($styles.insets.sm),

                      // LOCACIÓN
                      LabeledTextField(
                        controller: _fechaInspeccionController,
                        labelText: '* Locación:',
                      ),

                      Gap($styles.insets.sm),

                      // BASE DE LA UNIDAD
                      LabeledDropdownFormField(
                        labelText: '* Seleccione la base de la unidad:',
                        hintText: 'Seleccionar',
                        onChanged: (_){},
                        items: lstBases,
                      ),

                      Gap($styles.insets.sm),

                      // HOROMETRO / ODOMETRO (SI APLICA)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Horómetro:',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: $styles.insets.sm),
                          Expanded(
                            child: LabeledTextField(
                              controller: _fechaInspeccionController,
                              labelText: 'Odómetro:',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSegmentedButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SegmentedButton<ViewFormControl>(
          selected: _segmentedButtonsSelection,
          style: const ButtonStyle(
            visualDensity: VisualDensity.compact,
          ),
          onSelectionChanged: (Set<ViewFormControl> newSelection) {
            setState(() {
              _segmentedButtonsSelection = newSelection;
            });
          },
          segments: _segmentItems.map<ButtonSegment<ViewFormControl>>(((ViewFormControl, String, Icon) item) {
            return ButtonSegment<ViewFormControl>(
              value   : item.$1,
              tooltip : item.$2,
              icon    : item.$3,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedOpacity(
      opacity: _showScrollToTopButton ? 1.0 : 0.0,
      duration: $styles.times.fast,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
