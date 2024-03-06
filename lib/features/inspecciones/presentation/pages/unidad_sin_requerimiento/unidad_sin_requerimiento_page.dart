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
  bool _isVisible = false;

  // late final ValueChanged<BaseData> onChanged;

  @override
  void initState() {
    super.initState();
    // onChanged = (data) {};
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

  // void _onChanged(BuildContext context, BaseData? data) {
  //   if (data != null) {
  //     onChanged(data);
  //   }
  // }

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

                  Gap($styles.insets.xs),

                  Row(
                    children: [
                      Expanded(child: Container(),),
                      const Spacer(),
                      TextButton(
                        onPressed: (){},
                        child: const Text(
                          'Nueva Unidad',
                        )),
                    ],
                  ),

                  Gap($styles.insets.xs),

                  // SELECCIONAR INSPECCIÓN TIPO
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
                      hintText: 'Ej. Unidad',
                      labelText: 'Seleccione tipo de inspección',
                    ),
                  ),

                  Gap($styles.insets.md),

                  // FECHA DE LA INSPECCIÓN
                  LabeledTextField(
                    controller: _fechaInspeccionController,
                    labelText: 'Fecha Inspección *',
                    isReadOnly: true,
                  ),

                  Gap($styles.insets.md),

                  // NO. ECONÓMICO
                  LabeledTextField(
                    controller: _unidadNumeroEconomicoController,
                    labelText: 'No. Económico *',
                  ),

                  Gap($styles.insets.md),

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

                  Gap($styles.insets.md),

                  // MARCA
                  Text(
                    'Marca *',
                    style: $styles.textStyles.label,
                  ),

                  Gap($styles.insets.xs),

                  // MARCA
                  DropdownButtonFormField<String>(
                    menuMaxHeight: 280,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 6,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Seleccione la marca',
                    ),
                    items: <String>[
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: $styles.textStyles.bodySmall),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),

                  Gap($styles.insets.md),

                  // MODELO
                  LabeledTextField(
                    controller: _modeloController,
                    labelText: 'Modelo *',
                  ),

                  Gap($styles.insets.md),

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

                  Gap($styles.insets.md),

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

                  Gap($styles.insets.md),

                   // LOCACIÓN
                  LabeledTextField(
                    controller: _locacionController,
                    labelText: 'Locación *',
                  ),

                  Gap($styles.insets.md),

                  // BASE DE LA UNIDAD
                  Text(
                    'Base *',
                    style: $styles.textStyles.label,
                  ),

                  Gap($styles.insets.xs),

                  DropdownButtonFormField<String>(
                    menuMaxHeight: 280,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 6,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Seleccione una base',
                    ),
                    items: <String>[
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
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: $styles.textStyles.bodySmall),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),

                  Gap($styles.insets.md),

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

                  Gap($styles.insets.md),
                  const Divider(),

                  // FORMULARIOS
                  CardCheckList(
                    title: 'Niveles y Motor',
                    children: [
                      RadioGroupChecklist(
                        label: 'Tanque de Combustible',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Tanque de Aceite Hidráulico',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Nivel de Aceite Hidráulico',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Nivel de Combustible',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Nivel de Anticongelante',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Batería en Buen Estado',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Nivel de Aceite de Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Filtro de Aire',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Conexiones Eléctricas en General',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Conexiones Hidráulicas',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Estado de Soldaduras',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Tapa del Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Tornillería en General',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                      RadioGroupChecklist(
                        label: 'Estado del Aceite de Motor',
                        options: lstOptionsControl,
                        selectedValue: '',
                        onChanged: (_) {},
                      ),
                    ],
                  ),

                  Gap($styles.insets.md),
                  const Divider(),
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
              icon: const Icon(Icons.restore),
              tooltip: 'Restablecer',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sync),
              tooltip: 'Sincronizar',
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
