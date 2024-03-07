import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_text_field.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/card_checklist.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/radio_group_checklist.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() =>
      _InspeccionSinRequerimientoPageState();
}

class _InspeccionSinRequerimientoPageState
    extends State<InspeccionUnidadSinRequerimientoPage> {
  // Definir controladores para los campos de texto
  final TextEditingController _fechaInspeccionController =
      TextEditingController();
  final TextEditingController _locacionController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  final TextEditingController _unidadNumeroEconomicoController =
      TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _capacidadController = TextEditingController();
  final TextEditingController _anioEquipoController = TextEditingController();
  final TextEditingController _horometroController = TextEditingController();
  final TextEditingController _odometroController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // Propiedades
  final List<String> lstOptions = <String>['Uno', 'Dos', 'Tres'];
  final List<String> lstOptionsControl = <String>['Sí', 'N/A', 'No'];
  final List<Map<String, dynamic>> myProducts = List.generate(
    6,
    (index) => {
      'id': index,
      'path':
          'https://fastly.picsum.photos/id/88/1280/1707.jpg?hmac=NnkwPVDBTVxHkc4rALB_fyu-OHY2usdm7iRk5El7JC4',
      'fileName': 'nombre_archivo_$index',
    },
  ).toList();

  int? _selectedRadioValue;
  bool _isVisible = false;
  bool _showNuevaUnidadButton = false;

  @override
  void initState() {
    super.initState();
    _selectedRadioValue = 1;
    _fechaInspeccionController.text =
        DateFormat.yMd().add_jm().format(DateTime.now());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fechaInspeccionController.dispose();
    _locacionController.dispose();
    _modeloController.dispose();
    _numeroSerieController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _placaController.dispose();
    _capacidadController.dispose();
    _anioEquipoController.dispose();
    _horometroController.dispose();
    _odometroController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: $styles.times.medium,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Inspección de Unidad Sin Req.',
          style: $styles.textStyles.h3,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _isVisible = _scrollController.offset > 100;
            });
          }
          return true;
        },
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all($styles.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // ES UNIDAD TEMPORAL O UNIDAD DE INVENTARIO?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue = value;
                                  _showNuevaUnidadButton = false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Unidad Inventario',
                                style: $styles.textStyles.label,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue = value;
                                  _showNuevaUnidadButton = true;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Unidad Temporal',
                                style: $styles.textStyles.label,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // SELECCIONAR UNIDAD (INVENTARIO O TEMPORAL)
                  DropdownButtonFormField<String>(
                    items: lstOptions.map((String option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 3,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Seleccione una unidad',
                    ),
                  ),

                  Gap($styles.insets.sm),

                  AnimatedSwitcher(
                    duration: $styles.times.fast,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: child,
                        ),
                      );
                    },
                    child: _showNuevaUnidadButton
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                                label: const Text(
                                  'Nueva Unidad',
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),

                  // FECHA DE LA INSPECCIÓN
                  LabeledTextField(
                    controller: _fechaInspeccionController,
                    labelText: 'Fecha Inspección *',
                    isReadOnly: true,
                  ),

                  Gap($styles.insets.sm),

                  // NO. ECONÓMICO
                  LabeledTextField(
                    controller: _unidadNumeroEconomicoController,
                    labelText: 'No. Económico *',
                  ),

                  Gap($styles.insets.sm),

                  // SelectDropList(
                  //   itemSelected: optionItemSelected,
                  //   dropListModel: lstBases,
                  //   showIcon: false,
                  //   showArrowIcon: true,
                  //   onOptionSelected: (optionItem) {
                  //     optionItemSelected = optionItem;
                  //     setState(() {});
                  //   },
                  // ),

                  // DropdownSearch<BaseData>(
                  //   key: const Key('baseSelection'),
                  //   popupProps: PopupProps.menu(
                  //     showSearchBox: true,
                  //     isFilterOnline: true,
                  //     searchFieldProps: TextFieldProps(
                  //       decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.symmetric(
                  //           vertical: $styles.insets.sm - 6,
                  //           horizontal: $styles.insets.xs + 2,
                  //         ),
                  //         labelText: 'Buscar base',
                  //         helperText: 'ej. Veracruz, Villahermosa',
                  //         helperMaxLines: 2,
                  //       ),
                  //     ),
                  //     itemBuilder: (context, BaseData item, isSelected) {
                  //       return ListTile(
                  //         key: Key('baseSelection_${item.idBase}'),
                  //         title:
                  //             Text(item.name, style: $styles.textStyles.bodySmall),
                  //       );
                  //     },
                  //   ),
                  //   dropdownDecoratorProps: DropDownDecoratorProps(
                  //     dropdownSearchDecoration: InputDecoration(
                  //       contentPadding: EdgeInsets.symmetric(
                  //         vertical: $styles.insets.sm - 6,
                  //         horizontal: $styles.insets.xs + 2,
                  //       ),
                  //     ),
                  //   ),
                  //   selectedItem: BaseData.defaultBaseData(),
                  //   itemAsString: (BaseData item) => item.name,
                  //   items: lstBases,
                  //   onChanged: (BaseData? data) {
                  //     if (data != null) {
                  //       _onChanged(context, data);
                  //     }
                  //   },
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // MARCA
                      Expanded(
                        child: LabeledDropdownField(
                          labelText: 'Marca *',
                          hintText: 'Seleccione',
                          items: const <String>[
                            '3MA',
                            'AFFER',
                            'All Pressure',
                            'AMC',
                            'Amida',
                            'ASM',
                            'Audi',
                            'Autocar',
                            'Braden',
                            'Mercedes Benz',
                            'Mitsubishi',
                          ],
                          onChanged: (newValue) {
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: $styles.insets.sm),
                      // MODELO
                      Expanded(
                        child: LabeledTextField(
                          controller: _modeloController,
                          labelText: 'Modelo *',
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // NO. DE SERIE
                      Expanded(
                        child: LabeledTextField(
                          controller: _numeroSerieController,
                          labelText: 'No. de Serie',
                        ),
                      ),
                      SizedBox(width: $styles.insets.sm),
                      // PLACA
                      Expanded(
                        child: LabeledTextField(
                          controller: _placaController,
                          labelText: 'Placa',
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // CAPACIDAD
                      Expanded(
                        child: LabeledTextField(
                          controller: _capacidadController,
                          keyboardType: TextInputType.number,
                          labelText: 'Capacidad *',
                        ),
                      ),
                      SizedBox(width: $styles.insets.sm),
                      // AÑO DEL EQUIPO
                      Expanded(
                        child: LabeledTextField(
                          controller: _anioEquipoController,
                          labelText: 'Año del Equipo',
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),

                  // LOCACIÓN
                  LabeledTextField(
                    controller: _locacionController,
                    labelText: 'Locación *',
                  ),

                  Gap($styles.insets.sm),

                  // BASE DE LA UNIDAD
                  LabeledDropdownField(
                    labelText: 'Base *',
                    hintText: 'Seleccione una base',
                    items: const <String>[
                      'BALANCAN',
                      'CIUDAD ACUÑA',
                      'CIUDAD DEL CARMEN',
                      'LA VENTOSA',
                      'MERIDA',
                      'PARAISO',
                      'POR DEFINIR',
                      'POZA RICA',
                      'REFORMA',
                      'TEXAS',
                      'TOLUCA',
                      'VERACRUZ',
                      'VILLAHERMOSA',
                    ],
                    onChanged: (newValue) {
                      setState(() {});
                    },
                  ),

                  Gap($styles.insets.sm),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // HOROMETRO (SI APLICA)
                      Expanded(
                        child: LabeledTextField(
                          controller: _horometroController,
                          keyboardType: TextInputType.number,
                          labelText: 'Horometro',
                        ),
                      ),
                      SizedBox(width: $styles.insets.sm),
                      // ODOMETRO (SI APLICA)
                      Expanded(
                        child: LabeledTextField(
                          controller: _odometroController,
                          keyboardType: TextInputType.number,
                          labelText: 'Odometro',
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),
                  const Divider(),
                  Gap($styles.insets.sm),

                  // FORMULARIOS
                  CardCheckList(
                    title: 'Niveles y Motor MotorMotorMotor Motor Motor Motor',
                    children: [
                      RadioGroupChecklist(
                        label: '1. Tanque de Combustible',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '2. Tanque de Aceite Hidráulico',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '3. Nivel de Aceite Hidráulico',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '4. Nivel de Combustible',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '5. Nivel de Anticongelante',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '6. Batería en Buen Estado',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '7. Nivel de Aceite de Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '8. Filtro de Aire',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '9. Conexiones Eléctricas en General',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '10. Conexiones Hidráulicas',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '11. Estado de Soldaduras',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '12. Tapa del Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '13. Tornillería en General',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: '14. Estado del Aceite de Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),
                  const Divider(),

                  // EVIDENCIA FOTOGRAFICA
                  Gap($styles.insets.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Evidencia Fotográfica *',
                        style: $styles.textStyles.label,
                      ),
                      Gap($styles.insets.sm),
                      Container(
                        padding: EdgeInsets.all($styles.insets.xs + 2),
                        color: Theme.of(context).dividerColor,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: myProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular($styles.corners.md),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Ink.image(
                                      image: NetworkImage(
                                        myProducts[index]['path'].toString(),
                                      ),
                                      fit: BoxFit.cover,
                                      child: InkWell(onTap: () {}),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: IconButton(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding:
                                          EdgeInsets.all($styles.insets.xxs),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor
                                            .withOpacity(0.7),
                                      ),
                                      child: Text(
                                        myProducts[index]['fileName'].toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
              tooltip: 'Tomar Fotografía',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sync),
              tooltip: 'Sincronizar Información',
            ),
            const Spacer(),
            FilledButton(
              onPressed: null,
              child: Text(
                'Guardar Inspección',
                style: $styles.textStyles.button,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: $styles.times.fast,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
