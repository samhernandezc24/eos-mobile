import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_placa_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part '_create_form.dart';

class CreateUnidadPage extends StatefulWidget {
  const CreateUnidadPage({Key? key}) : super(key: key);

  @override
  State<CreateUnidadPage> createState() => _CreateUnidadPageState();
}

class _CreateUnidadPageState extends State<CreateUnidadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nueva unidad', style: $styles.textStyles.h3)),
      body: ListView(
        padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
        children: const <Widget>[
          // FORMULARIO DE UNIDAD
          _CreateForm(),
        ],
      ),
    );
  }
}
