import 'dart:io';

import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/core/common/widgets/modals/form_modal.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/core/enums/view_form_control.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/card_checklist.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/radio_group_checklist.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_form.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({super.key});

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() => _InspeccionUnidadSinRequerimientoPageState();
}

class _InspeccionUnidadSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final ScrollController _scrollController               = ScrollController();
  late final TextEditingController _fechaInspeccionController = TextEditingController();

  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _modeloController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _placaController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _locacionController;
  late final TextEditingController _horometroController;
  late final TextEditingController _odometroController;

  // LIST
  final List<File> _lstImages = <File>[];

  static const List<(ViewFormControl, String, Icon)> _segmentItems = <(ViewFormControl, String, Icon)>[
    (ViewFormControl.list, 'Diseño de lista', Icon(Icons.menu_sharp, size: 24)),
    (ViewFormControl.tree, 'Diseño de árbol', Icon(Icons.account_tree, size: 24)),
  ];

  late List<dynamic> lstUnidades              = <dynamic>['A', 'B'];
  late List<dynamic> lstInspeccionesTipos     = <dynamic>['A', 'B'];
  late List<dynamic> lstUnidadesMarcas        = <dynamic>['A', 'B'];
  late List<dynamic> lstBases                 = <dynamic>['A', 'B'];
  late List<dynamic> lstUnidadesPlacasTipos   = <dynamic>['A', 'B'];
  late List<dynamic> lstFormOptionsItems      = <dynamic>['Si', 'No', 'No Aplica'];

  // COLLECTIONS
  Set<ViewFormControl> _segmentedButtonsSelection = <ViewFormControl>{ViewFormControl.list};

  // PROPERTIES
  UnidadInspeccionTipo? _unidadRadioControl = UnidadInspeccionTipo.inventario;

  bool _showScrollToTopButton     = false;
  bool _showCreateUnidadButton    = false;

  @override
  void initState() {
    _fechaInspeccionController.text = DateFormat.yMd().add_jm().format(DateTime.now());
    _numeroEconomicoController  = TextEditingController();
    _modeloController           = TextEditingController();
    _numeroSerieController      = TextEditingController();
    _placaController            = TextEditingController();
    _capacidadController        = TextEditingController();
    _anioEquipoController       = TextEditingController();
    _locacionController         = TextEditingController();
    _horometroController        = TextEditingController();
    _odometroController         = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    _numeroEconomicoController.dispose();
    _modeloController.dispose();
    _numeroSerieController.dispose();
    _placaController.dispose();
    _capacidadController.dispose();
    _anioEquipoController.dispose();
    _locacionController.dispose();
    _horometroController.dispose();
    _odometroController.dispose();
    super.dispose();
  }

  // METHODS
  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text(
                '¿Quieres terminar la inspección más tarde?',
                  style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.bookmark),
              title: const Text('Guardar como borrador'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              title: const Text('Descartar inspección'),
              onTap: () {
                Navigator.pop(context);
                GoRouter.of(context).go('/home/inspecciones');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              title: const Text('Seguir editando'),
              onTap: () => context.pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showModalBottomSheet();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Inspección de unidad sin req.', style: $styles.textStyles.h3)),
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
                                        onPressed: (){
                                          Navigator.push<void>(
                                            context,
                                            PageRouteBuilder<void>(
                                              transitionDuration: $styles.times.pageTransition,
                                              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                                const Offset begin  = Offset(0, 1);
                                                const Offset end    = Offset.zero;
                                                const Cubic curve   = Curves.ease;

                                                final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

                                                return SlideTransition(
                                                  position: animation.drive<Offset>(tween),
                                                  child: const FormModal(
                                                    title: 'Nueva unidad',
                                                    child: CreateUnidadForm(),
                                                  ),
                                                );
                                              },
                                              fullscreenDialog: true,
                                            ),
                                          );
                                        },
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
                          controller: _numeroEconomicoController,
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
                                controller: _modeloController,
                                labelText: 'Modelo:',
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // NO. DE SERIE
                        LabeledTextField(
                          controller: _numeroSerieController,
                          labelText: 'Número de serie:',
                        ),

                        Gap($styles.insets.sm),

                        // PLACA TIPO / PLACA DE LA UNIDAD
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: LabeledDropdownFormField(
                                labelText: '* Seleccione tipo de placa:',
                                hintText: 'Seleccionar',
                                onChanged: (_){},
                                items: lstUnidadesPlacasTipos,
                              ),
                            ),
                            SizedBox(width: $styles.insets.sm),
                            Expanded(
                              child: LabeledTextField(
                                controller: _placaController,
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
                                controller: _capacidadController,
                                labelText: 'Capacidad:',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: $styles.insets.sm),
                            Expanded(
                              child: LabeledTextField(
                                controller: _anioEquipoController,
                                labelText: 'Año del equipo:',
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // LOCACIÓN
                        LabeledTextField(
                          controller: _locacionController,
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
                                controller: _horometroController,
                                labelText: 'Horómetro:',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: $styles.insets.sm),
                            Expanded(
                              child: LabeledTextField(
                                controller: _odometroController,
                                labelText: 'Odómetro:',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),
                        const Divider(),
                        Gap($styles.insets.sm),

                        // FORMULARIO DE PREGUNTAS
                        CardCheckList(
                          title: 'Niveles Y Motor',
                          children: <Widget>[
                            RadioGroupChecklist(
                              label: '1. Tanque de Combustible',
                              options: lstFormOptionsItems,
                              selectedValue: '',
                              onChanged: (_){},
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),
                        const Divider(),
                        Gap($styles.insets.sm),

                        // EVIDENCIA FOTOGRÁFICA
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text('* Evidencia fotográfica:', style: $styles.textStyles.label),

                            Gap($styles.insets.sm),

                            if (_lstImages.isNotEmpty)
                             SizedBox(
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: $styles.insets.sm,
                                  mainAxisSpacing: $styles.insets.sm,
                                ),
                                itemCount: _lstImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: SizedBox(
                                              child: Image.file(_lstImages[index], fit: BoxFit.contain),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                            child: Image.file(
                                              _lstImages[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              color: Theme.of(context).colorScheme.error,
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  _lstImages.removeAt(index);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                              ),
                             )
                            else
                              Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                padding: EdgeInsets.all($styles.insets.lg * 1.4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular($styles.corners.md),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(Icons.camera_alt_outlined, size: 64),
                                    Text(
                                      'Aún no hay fotografías',
                                      style: $styles.textStyles.title1.copyWith(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    Gap($styles.insets.xs),
                                    Text(
                                      'Toma fotografías dando clic en el ícono de la cámara para visualizarlas aquí.',
                                      style: $styles.textStyles.bodySmall.copyWith(height: 1.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
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
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    final file = await imageHelper.takePhoto();
                    if (file != null) {
                      setState(() {
                        _lstImages.add(File(file.path));
                      });
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  tooltip: 'Tomar fotografía',
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.sync), tooltip: 'Sincronizar información'),
                const Spacer(),
                FilledButton(onPressed: (){}, child: Text('Guardar Inspección', style: $styles.textStyles.button)),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
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
