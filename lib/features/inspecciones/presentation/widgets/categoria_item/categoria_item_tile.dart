import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemTile extends StatefulWidget {
  const CategoriaItemTile({Key? key, this.categoriaItem, this.lstFormulariosTipos}) : super(key: key);

  final CategoriaItemEntity? categoriaItem;
  final List<FormularioTipoEntity>? lstFormulariosTipos;

  @override
  State<CategoriaItemTile> createState() => _CategoriaItemTileState();
}

class _CategoriaItemTileState extends State<CategoriaItemTile> {
  /// LIST
  // late final List<FormularioTipoEntity> lstFormulariosTipos = <FormularioTipoEntity>[];

  // late final List<dynamic> lstFormulariosTipos = <dynamic>[
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ListTile(
          //   leading: CircleAvatar(
          //     radius: 12,
          //     child: Text(categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4),
          //   ),
          //   title: Text(categoriaItem!.name, overflow: TextOverflow.ellipsis, maxLines: 2),
          //   onTap: () {},
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
          //   child: Column(
          //     children: <Widget>[
          //       _buildMultipleChoiceOptions(),
          //     ],
          //   ),
          // ),
          ListTile(
            title: LabeledTextField(
              controller: TextEditingController(),
              labelText: 'Pregunta:',
              textInputAction: TextInputAction.done,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Tipo:', style: $styles.textStyles.label),
                Gap($styles.insets.xs),
                DropdownButtonFormField<dynamic>(
                  menuMaxHeight: 280,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: $styles.insets.sm - 3,
                      horizontal: $styles.insets.xs + 2,
                    ),
                    hintText: 'Seleccione',
                  ),
                  items: widget.lstFormulariosTipos!
                    .map<DropdownMenuItem<dynamic>>((formularioTipo) {
                      return DropdownMenuItem<dynamic>(
                        value: formularioTipo.idFormularioTipo,
                        child: Text(formularioTipo.name),
                      );
                    }).toList(),
                  onChanged: (newValue) {
                    setState(() {});
                  },
                  // onChanged: (newValue) {
                  //   final selectedTipoUnidad = state.unidadData?.unidadesTipos.firstWhere((unidadTipo) => unidadTipo.idUnidadTipo == newValue);
                  //   if (selectedTipoUnidad != null) {
                  //     setState(() {
                  //       selectedTipoUnidadId    = selectedTipoUnidad.idUnidadTipo;
                  //       selectedTipoUnidadName  = selectedTipoUnidad.name;
                  //       // print('ID: ${selectedTipoUnidad.idUnidadTipo}, Nombre: ${selectedTipoUnidad.name}');
                  //     });
                  //   }
                  // },
                ),
              ],
            ),
            // title: LabeledDropdownFormField(
            //   labelText: 'Tipo:',
            //   onChanged: (_) {},
            //   items: lstFormulariosTipos,
            // ),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.content_copy),
                  tooltip: 'Duplicar elemento',
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  tooltip: 'Eliminar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Row(
                children: [
                  Radio(value: 1, groupValue: 'null', onChanged: (index) {}),
                  const Expanded(
                    child: Text('Sí'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio(
                      value: 1, groupValue: 'null', onChanged: (index) {}),
                  Expanded(child: Text('No'))
                ],
              ),
            ),
          ],
        ),
      ],
    );
    // return SizedBox(
    //   height: 100,
    //   child: GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 3,
    //       crossAxisSpacing: 4,
    //       mainAxisSpacing: 4,
    //     ),
    //     itemCount: 4,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         margin: const EdgeInsets.all(4),
    //         child: Row(
    //           children: <Widget>[
    //             const Radio(value: null, groupValue: null, onChanged: null),
    //             Text('Opción ${index + 1}'),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
