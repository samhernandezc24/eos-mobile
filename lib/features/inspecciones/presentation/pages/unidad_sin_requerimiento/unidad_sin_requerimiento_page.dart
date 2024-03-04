import 'package:eos_mobile/core/common/widgets/controls/simple_checkbox.dart';
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
  final TextEditingController _dateInputController = TextEditingController();
  final TextEditingController _locacionController = TextEditingController();
  final TextEditingController _baseNameInputController =
      TextEditingController();
  final TextEditingController _unidadNumeroEconomicoController =
      TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  final TextEditingController _capacidadController = TextEditingController();
  final TextEditingController _horometroController = TextEditingController();
  final TextEditingController _odometroController = TextEditingController();
  final TextEditingController _tipoPlataformaController =
      TextEditingController();
  final TextEditingController _unidadMarcaNameController =
      TextEditingController();

  final List<String> lstOptions = ['Sí', 'N/A', 'No'];
  late final List<TextEditingController> _optionControllers;

  final List<String> lstBases = [
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
  ];

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _dateInputController.text =
        DateFormat.yMd().add_jm().format(DateTime.now());
    _optionControllers =
        lstOptions.map((opt) => TextEditingController()).toList();
  }

  @override
  void dispose() {
    _dateInputController.dispose();
    _locacionController.dispose();
    _baseNameInputController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _modeloController.dispose();
    _numeroSerieController.dispose();
    _capacidadController.dispose();
    _horometroController.dispose();
    _odometroController.dispose();
    _tipoPlataformaController.dispose();
    _unidadMarcaNameController.dispose();
    super.dispose();
  }

  void _showBaseSelectionDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Seleccionar Base',
            style: $styles.textStyles.h3,
          ),
          content: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Column(
                children: lstBases.map((base) {
                  return ListTile(
                    title: Text(base),
                    onTap: () {
                      _baseNameInputController.text = base;
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspección de Unidad Sin Req.',
          style: $styles.textStyles.h3,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleCheckbox(
                    isActive: _isChecked,
                    label: 'Unidad Temporal',
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked = newValue ?? false;
                      });
                    },
                  ),
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
                    child: _isChecked
                        ? TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.local_shipping),
                            label: const Text('Nueva Unidad Temporal'),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              const Gap(6),
              SearchAnchor(
                isFullScreen: false,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                    ),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular($styles.insets.xs),
                      ),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Seleccionar Inspección *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              SearchAnchor(
                isFullScreen: false,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                    ),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular($styles.insets.xs),
                      ),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Fecha Inspección *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _dateInputController,
                decoration: const InputDecoration(
                  isDense: true,
                ),
                readOnly: true,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Base de la Unidad *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _baseNameInputController,
                decoration: const InputDecoration(
                  hintText: 'Seleccione',
                  isDense: true,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                readOnly: true,
                onTap: () {
                  _showBaseSelectionDialog(context);
                },
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Locación *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _locacionController,
                decoration: const InputDecoration(
                  hintText: 'ej. Villahermosa',
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Marca *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _unidadMarcaNameController,
                decoration: const InputDecoration(
                  hintText: 'ej. T3, 600A',
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Modelo *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(
                  hintText: 'ej. T3, 600A',
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'No. Serie *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _numeroSerieController,
                decoration: const InputDecoration(
                  hintText: 'Revisa el VIN de la unidad',
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'No. Económico *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _unidadNumeroEconomicoController,
                decoration: const InputDecoration(
                  hintText: 'ej. HL-1085, VF-HL-140',
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Capacidad *',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _capacidadController,
                decoration: const InputDecoration(
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              Text(
                'Tipo de Plataforma',
                style: $styles.textStyles.label,
              ),
              const Gap(6),
              TextFormField(
                controller: _tipoPlataformaController,
                decoration: const InputDecoration(
                  isDense: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const Gap(12),
              const Divider(),
              const Gap(12),
              SizedBox(
                height: 350,
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular($styles.insets.xs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all($styles.insets.sm),
                        child: Text(
                          'Niveles & Motor',
                          style: $styles.textStyles.h4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                              RadioGroupChecklist(
                                label: 'Tanque de Combustible',
                                options: lstOptions,
                                selectedValue: '',
                                onChanged: (_) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: Center(
            child: FilledButton(
              onPressed: null,
              child: Text(
                'Guardar Inspección',
                style: $styles.textStyles.button,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
