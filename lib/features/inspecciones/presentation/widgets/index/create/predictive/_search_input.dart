part of '../../../../pages/index/index_page.dart';

// class _SearchUnidadInput extends StatelessWidget {
//   const _SearchUnidadInput({
//     required this.onSubmit,
//     Key? key,
//   }) : super(key: key);

//   final void Function(String) onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (ctx, constraints) {
//         return Center(
//           child: PredictiveSearchFormField<String>(
//             displayStringForOption: (data) => data,
//             optionsBuilder: (textEditingValue) {
//               return [];
//             },
//             fieldViewBuilder: _buildInput,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
//     return Container(
//       height: 54,
//       decoration: BoxDecoration(
//         color         : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3),
//         border        : Border.all(color: Theme.of(context).primaryColor),
//         borderRadius  : BorderRadius.circular($styles.insets.xxs),
//       ),
//       child: Row(
//         children: <Widget>[
//           Gap($styles.insets.xs * 1.5),
//           const Icon(Icons.search),
//           Expanded(
//             child: TextField(
//               controller        : textController,
//               focusNode         : focusNode,
//               onSubmitted       : onSubmit,
//               style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
//               textAlignVertical : TextAlignVertical.top,
//               textInputAction   : TextInputAction.search,
//               decoration: InputDecoration(
//                 isDense         : true,
//                 fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0),
//                 contentPadding  : EdgeInsets.all($styles.insets.xs),
//                 labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
//                 hintStyle       : TextStyle(color: Theme.of(context).hintColor),
//                 prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
//                 focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
//                 enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
//                 hintText        : AppStrings.searchInputHintText,
//               ),
//             ),
//           ),
//           Gap($styles.insets.xs),
//           ValueListenableBuilder(
//             valueListenable : textController,
//             builder         : (_, value, __) {
//               return Visibility(
//                 visible : textController.value.text.isNotEmpty,
//                 child   : Padding(
//                   padding : EdgeInsets.only(right: $styles.insets.xs),
//                   child   : CircleIconButton(
//                     backgroundColor : $styles.colors.caption,
//                     color           : $styles.colors.white,
//                     icon            : AppIcons.close,
//                     semanticLabel   : AppStrings.searchInputSemanticClear,
//                     iconSize        : $styles.insets.sm,
//                     size            : $styles.insets.md,
//                     onPressed       : () {
//                       textController.clear();
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
