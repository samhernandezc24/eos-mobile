import 'dart:io';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:intl/intl.dart';

class ChecklistInspeccionPage extends StatefulWidget {
  const ChecklistInspeccionPage({Key? key, this.inspeccionDataSource}) : super(key: key);

  final InspeccionDataSourceEntity? inspeccionDataSource;

  @override
  State<ChecklistInspeccionPage> createState() => _ChecklistInspeccionPageState();
}

class _ChecklistInspeccionPageState extends State<ChecklistInspeccionPage> {
  /// INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  late final ScrollController _scrollController = ScrollController();

  late final TextEditingController _fechaInspeccionController;

  late final List<Map<String, dynamic>> arrInspeccionGeneralInfo;

  /// PROPERTIES
  bool _showScrollToTopButton = false;

  // final List<_Item> _data = generateItems([]);
  final List<String> categoriesFromServer = ['Categoría 1', 'Categoría 2', 'Categoría 3']; // Ejemplo de categorías obtenidas del servidor

  final List<File> _lstImages = <File>[];

  @override
  void initState() {
    super.initState();

    arrInspeccionGeneralInfo = getInspeccionGeneralInfoList();

    _fechaInspeccionController = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    super.dispose();
  }

  /// METHODS
  Future<DateTime?> _selectFechaInspeccion(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context     : context,
      initialDate : DateTime.now(),
      firstDate   : DateTime(2000),
      lastDate    : DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context     : context,
        initialTime : TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }

  void _handleOnPopPage(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text('¿Quieres terminar la inspección más tarde?', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.bookmark),
              title: const Text('Guardar como borrador'),
              subtitle: const Text('Puedes retomar y responder esta inspección en otro momento.'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              leading: const Icon(Icons.delete_forever),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              title: const Text('Descartar inspección'),
            ),
            ListTile(
              onTap: () => context.pop(),
              leading: const Icon(Icons.check),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              title: const Text('Continuar respondiendo'),
            ),
          ],
        );
      },
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  List<Map<String, dynamic>> getInspeccionGeneralInfoList() {
    final String requerimientoFolio = widget.inspeccionDataSource!.hasRequerimiento == true
        ? widget.inspeccionDataSource?.requerimientoFolio ?? ''
        : 'SIN REQUERIMIENTO';
    return [
      { 'title': 'Folio inspección:',             'subtitle': widget.inspeccionDataSource?.folio ?? ''                  },
      { 'title': 'Requerimiento:',                'subtitle': requerimientoFolio                                        },
      { 'title': 'Fecha programada inspección:',  'subtitle': widget.inspeccionDataSource?.fechaNatural ?? ''           },
      { 'title': 'No. económico:',                'subtitle': widget.inspeccionDataSource?.unidadNumeroEconomico ?? ''  },
      { 'title': 'Tipo de unidad:',               'subtitle': widget.inspeccionDataSource?.unidadTipoName ?? ''         },
      { 'title': 'Tipo de inspección:',           'subtitle': widget.inspeccionDataSource?.inspeccionTipoName ?? ''     },
      { 'title': 'Lugar de inspección:',          'subtitle': widget.inspeccionDataSource?.locacion ?? ''               },
      { 'title': 'Base unidad:',                  'subtitle': widget.inspeccionDataSource?.baseName ?? ''               },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Widget scrollToTopButton = AnimatedOpacity(
      opacity   : _showScrollToTopButton ? 1.0 : 0.0,
      duration  : $styles.times.fast,
      child     : FloatingActionButton(onPressed: _scrollToTop, child: const Icon(Icons.arrow_upward)),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        _handleOnPopPage(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Evaluar unidad', style: $styles.textStyles.h3)),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _showScrollToTopButton = _scrollController.offset > 100;
              });
            }
            return true;
          },
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: $styles.insets.sm),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Número económico:', style: $styles.textStyles.label),
                    Text(
                      widget.inspeccionDataSource?.unidadNumeroEconomico ?? '',
                      style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3),
                    ),

                    Gap($styles.insets.xxs),

                    RichText(
                      text: TextSpan(
                        style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                        children: <InlineSpan>[
                          TextSpan(text: 'Folio inspección', style: $styles.textStyles.label),
                          TextSpan(text: ': ${widget.inspeccionDataSource?.folio ?? ''}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                        children: <InlineSpan>[
                          TextSpan(text: 'Tipo de inspección', style: $styles.textStyles.label),
                          TextSpan(text: ': ${widget.inspeccionDataSource?.inspeccionTipoName ?? ''}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                        children: <InlineSpan>[
                          TextSpan(text: 'Tipo de unidad', style: $styles.textStyles.label),
                          TextSpan(text: ': ${widget.inspeccionDataSource?.unidadTipoName ?? ''}'),
                        ],
                      ),
                    ),

                    Gap($styles.insets.xs),

                    Divider(color: Theme.of(context).dividerColor, thickness: 1.5),
                  ],
                ),
              ),

              Gap($styles.insets.sm),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // FECHA DE LA INSPECCIÓN:
                      LabeledTextFormField(
                        controller  : _fechaInspeccionController,
                        isReadOnly  : true,
                        label       : '* Fecha de inspección inicial:',
                        textAlign   : TextAlign.end,
                        onTap       : () async {
                          final DateTime? pickedDate = await _selectFechaInspeccion(context);
                          if (pickedDate != null) {
                            setState(() {
                              _fechaInspeccionController.text = DateFormat('dd/MM/yyyy HH:mm').format(pickedDate);
                            });
                          }
                        },
                        validator   : FormValidators.textValidator,
                      ),
                    ],
                  ),
                ),
              ),

              Gap($styles.insets.sm),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular($styles.corners.md),
                ),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                  title: Expanded(
                    child: Text(
                      'DATOS GENERALES',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: $styles.textStyles.h4,
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: arrInspeccionGeneralInfo.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = arrInspeccionGeneralInfo[index];
                          return ListTile(
                            dense: true,
                            title: Text(item['title'].toString(), style: $styles.textStyles.label),
                            subtitle: Text(item['subtitle'].toString(), style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600, height: 1.3)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // _buildExpansionTileList(categoriesFromServer),
              // ExpansionPanelList(
              //   expansionCallback: (int index, bool isExpanded) {
              //     setState(() {
              //       _data[index].isExpanded = isExpanded;
              //     });
              //   },
              //   children: _data.map<ExpansionPanel>((_Item item) {
              //     return ExpansionPanel(
              //       headerBuilder: (BuildContext context, bool isExpanded) {
              //         return ListTile(title: Text(item.headerValue));
              //       },
              //       body: ListTile(
              //         title: Text(item.expandedValue),
              //       ),
              //       isExpanded: item.isExpanded,
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  final picture = await imageHelper.takePhoto();
                  if (picture != null) {
                    setState(() {
                      _lstImages.add(File(picture.path));
                    });
                  }
                },
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Tomar fotografía',
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.sync), tooltip: 'Sincronizar información'),
              const Spacer(),
              FilledButton(onPressed: (){}, child: Text('Siguiente', style: $styles.textStyles.button)),
            ],
          ),
        ),
        floatingActionButton: scrollToTopButton,
      ),
    );
  }

  Widget _buildExpansionTileList(List<String> categories) {
    return Column(
      children: categories.map<Widget>((category) {
      return Card(
        elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular($styles.insets.xs),
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            tilePadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
            leading: Container(
              padding: EdgeInsets.symmetric(
                vertical: $styles.insets.xxs,
                horizontal: $styles.insets.xs,
              ),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.errorContainer.withOpacity(0.85),
                borderRadius: BorderRadius.circular($styles.corners.md),
              ),
              child: Text(
                '1 / 10',
                style: $styles.textStyles.label.copyWith(fontSize: 12),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'Pregunta 1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: $styles.textStyles.h4,
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            children: <Widget>[
              SizedBox(
                height: 280,
                child: Container(),
              ),
            ],
          ),
        );
        // return ExpansionTile(
        //   title: Text(category),
        //   children: const <Widget>[
        //     ListTile(
        //       title: Text('Pregunta 1'),
        //     ),
        //     ListTile(
        //       title: Text('Pregunta 2'),
        //     ),
        //     ListTile(
        //       title: Text('Pregunta 3'),
        //     ),
        //     // Agrega más ListTile según sea necesario para representar las preguntas para cada categoría
        //   ],
        // );
      }).toList(),
    );
  }
}

class _Item {
  _Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
