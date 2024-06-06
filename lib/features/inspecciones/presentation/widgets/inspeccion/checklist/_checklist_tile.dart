part of '../../../pages/list/list_page.dart';

class _ChecklistTile extends StatefulWidget {
  const _ChecklistTile({
    required this.categoria,
    required this.selectedValues,
    required this.onSelectedValuesChanged,
    required this.isEvaluado,
    Key? key,
  }) : super(key: key);

  final Categoria categoria;
  final Map<String, String> selectedValues;
  final void Function(Map<String, String>) onSelectedValuesChanged;
  final bool isEvaluado;

  @override
  State<_ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<_ChecklistTile> {
  // PROPERTIES
  late Map<String, String> _selectedValues;

  // STATE
  @override
  void initState() {
    super.initState();
    _selectedValues = Map<String, String>.from(widget.selectedValues);
  }

  @override
  void didUpdateWidget (_ChecklistTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValues != oldWidget.selectedValues) {
      _selectedValues = Map<String, String>.from(widget.selectedValues);
    }
  }

  // EVENTS
  void _handleSelectRadioChange(String option, String itemId) {
    if (widget.isEvaluado) return;
    setState(() {
      _selectedValues[itemId] = option;
      widget.onSelectedValuesChanged(_selectedValues);
    });
  }

  // METHODS
  int _preguntasRespondidas() {
    final int answeredQuestions = widget.categoria.categoriasItems?.where((item) => _selectedValues[item.idCategoriaItem] != null && _selectedValues[item.idCategoriaItem]!.isNotEmpty).length ?? 0;
    return answeredQuestions;
  }

  String? _getCommonOption() {
    final values = widget.categoria.categoriasItems?.map((item) => _selectedValues[item.idCategoriaItem]).toSet();
    if (values != null && values.length == 1) {
      return values.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final int totalQuestions    = widget.categoria.categoriasItems?.length ?? 0;
    final int answeredQuestions = _preguntasRespondidas();

    final List<String> commonOptions    = widget.categoria.categoriasItems?.isNotEmpty ?? false
        ? widget.categoria.categoriasItems!.first.formularioValor?.split(',') ?? []
        : [];
    final String? selectedCommonOption  = _getCommonOption();

    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: $styles.insets.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor,
            borderRadius: BorderRadius.circular($styles.corners.md),
          ),
          child: Text(
            '$answeredQuestions / $totalQuestions',
            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        title: Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children: <Widget>[
          Column(
            children: <Widget>[
              if (!widget.isEvaluado)
                Text('Aplicar a todos a:', style: $styles.textStyles.body),
              if (!widget.isEvaluado)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: commonOptions.map((option) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Radio(
                                value: option,
                                groupValue: selectedCommonOption,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    for (final item in widget.categoria.categoriasItems!) {
                                      _handleSelectRadioChange(option, item.idCategoriaItem!);
                                    }
                                  }
                                },
                              ),
                              Text(option, style: $styles.textStyles.body),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount   : widget.categoria.categoriasItems?.length,
                  itemBuilder : (BuildContext context, int index) {
                    return Padding(
                      padding : EdgeInsets.only(bottom: $styles.insets.sm),
                      child   : _buildItemElement(widget.categoria.categoriasItems![index], index),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ITEMS:
  Widget _buildItemElement(CategoriaItem item, int index) {
    switch (item.idFormularioTipo) {
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}'.toCapitalized(), style: $styles.textStyles.body.copyWith(height: 1.3), softWrap: true)),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      ..._buildOpcionesMultiples(item),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
    }
    return Text('Tipo de formulario desconocido', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
  }

  List<Widget> _buildOpcionesMultiples(CategoriaItem item) {
    return (item.formularioValor?.split(',') ?? [])
        .map(
          (option) => Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                value: option,
                groupValue: _selectedValues[item.idCategoriaItem] ?? '',
                onChanged: widget.isEvaluado ? null : (String? value) {
                  setState(() {
                    _selectedValues[item.idCategoriaItem!] = value!;
                    widget.onSelectedValuesChanged(_selectedValues);
                  });
                },
              ),
              Text(option, style: $styles.textStyles.body),
            ],
          ),
        ).toList();
  }
}
