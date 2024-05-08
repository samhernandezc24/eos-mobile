// import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
// import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_form.dart';
// import 'package:eos_mobile/shared/shared_libraries.dart';

// class CreateUnidadPage extends StatefulWidget {
//   const CreateUnidadPage({Key? key}) : super(key: key);

//   @override
//   State<CreateUnidadPage> createState() => _CreateUnidadPageState();
// }

// class _CreateUnidadPageState extends State<CreateUnidadPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.of(context).pop();
//             const predictiveSearch = PredictiveSearchReqEntity(search: '');
//             context.read<RemoteUnidadBloc>().add(const PredictiveUnidad(predictiveSearch));
//           },
//         ),
//         title: Text('Nueva unidad', style: $styles.textStyles.h3),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
//         children: const <Widget>[
//           // CAMPOS PARA CREAR LA UNIDAD TEMPORAL
//           CreateUnidadForm(),
//         ],
//       ),
//     );
//   }
// }
