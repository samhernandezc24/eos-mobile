// part of '../../pages/configuracion/categorias/categorias_page.dart';

// class _CreateForm extends StatefulWidget {
//   const _CreateForm({Key? key, this.inspeccionTipo}) : super(key: key);

//   final InspeccionTipoEntity? inspeccionTipo;

//   @override
//   State<_CreateForm> createState() => _CreateFormState();
// }

// class _CreateFormState extends State<_CreateForm> {
//   // GLOBAL KEY
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // CONTROLLERS
//   late final TextEditingController _nameController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   // METHODS
//   void _handleStoreCategoria() {
//     final CategoriaStoreReqEntity objData = CategoriaStoreReqEntity(
//       name                  : _nameController.text,
//       idInspeccionTipo      : widget.inspeccionTipo?.idInspeccionTipo ?? '',
//       inspeccionTipoCodigo  : widget.inspeccionTipo?.codigo           ?? '',
//       inspeccionTipoName    : widget.inspeccionTipo?.name             ?? '',
//     );

//     final bool isValidForm = _formKey.currentState!.validate();

//     // Verificar la validacion en el formulario.
//     if (isValidForm) {
//       _formKey.currentState!.save();
//       BlocProvider.of<RemoteCategoriaBloc>(context).add(StoreCategoria(objData));
//     }
//   }

//   Future<void> _showFailureDialog(BuildContext context, RemoteCategoriaServerFailure state) {
//     return showDialog<void>(
//       context   : context,
//       builder   : (_) => AlertDialog(
//         title   : const SizedBox.shrink(),
//         content : Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             Gap($styles.insets.sm),
//             Flexible(
//               child: Text(
//                 state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la categoria de nuevo.',
//                 style: $styles.textStyles.title2.copyWith(height: 1.5),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(onPressed: () => context.pop(), child: Text($strings.acceptButtonText, style: $styles.textStyles.button)),
//         ],
//       ),
//     );
//   }

//   Future<void> _showFailedMessageDialog(BuildContext context, RemoteCategoriaServerFailedMessage state) {
//     return showDialog<void>(
//       context   : context,
//       builder   : (_) => AlertDialog(
//         title   : const SizedBox.shrink(),
//         content : Row(
//           children: <Widget>[
//             Icon(Icons.error, color: Theme.of(context).colorScheme.error),
//             Gap($styles.insets.sm),
//             Flexible(
//               child: Text(
//                 state.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la categoria de nuevo.',
//                 style: $styles.textStyles.title2.copyWith(height: 1.5),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(onPressed: () => context.pop(), child: Text($strings.acceptButtonText, style: $styles.textStyles.button)),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           // NOMBRE:
//           LabeledTextFormField(
//             autoFocus   : true,
//             controller  : _nameController,
//             hintText    : 'Ingrese nombre de categoria...',
//             label       : 'Nombre:',
//             validator   : FormValidators.textValidator,
//           ),

//           Gap($styles.insets.lg),

//           BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
//             listener: (BuildContext context, RemoteCategoriaState state) {
//               if (state is RemoteCategoriaServerFailure) {
//                 _showFailureDialog(context, state);
//               }

//               if (state is RemoteCategoriaServerFailedMessage) {
//                 _showFailedMessageDialog(context, state);
//               }

//               if (state is RemoteCategoriaStored) {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context)
//                 ..hideCurrentSnackBar()
//                 ..showSnackBar(
//                   SnackBar(
//                     content         : Text(state.objResponse?.message ?? '', softWrap: true),
//                     backgroundColor : Colors.green,
//                     behavior        : SnackBarBehavior.fixed,
//                     elevation       : 0,
//                   ),
//                 );
//               }
//             },
//             builder: (BuildContext context, RemoteCategoriaState state) {
//               if (state is RemoteCategoriaStoring) {
//                 return FilledButton(
//                   onPressed : null,
//                   style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
//                   child     : const AppLoadingIndicator(width: 20, height: 20),
//                 );
//               }

//               return FilledButton(
//                 onPressed : _handleStoreCategoria,
//                 style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
//                 child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
