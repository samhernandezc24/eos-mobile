// // ignore_for_file: unused_element

// part of '../pages/list/list_page.dart';

// /// Campo de texto autocompletable utilizado para buscar Inspecciones
// /// por folio de la inspección, no. economico.
// class _SearchInput extends StatelessWidget {
//   const _SearchInput({
//     required this.onSubmit,
//     required this.inspecciones,
//     Key? key,
//   }) : super(key: key);

//   final void Function(String) onSubmit;
//   final InspeccionesSearchEntity inspecciones;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (ctx, constraints) => Center(
//         child: Autocomplete<String>(
//           displayStringForOption: (data) => data,
//           onSelected: onSubmit,
//           optionsBuilder: _getSuggestions,
//           optionsViewBuilder: (context, onSelected, results) =>
//               _buildSuggestionsView(context, onSelected, results, constraints),
//           fieldViewBuilder: _buildInput,
//         ),
//       ),
//     );
//   }

//   Iterable<String> _getSuggestions(TextEditingValue textEditingValue) {
//     if (textEditingValue.text == '') {
//       return inspecciones.searchSuggestions.getRange(0, 10);
//     }

//     return inspecciones.searchSuggestions.where((str) {
//       return str.startsWith(textEditingValue.text.toLowerCase());
//     }).toList()
//       ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
//   }

//   Widget _buildSuggestionsView(BuildContext context, void Function(String) onSelected, Iterable<String> results, BoxConstraints constraints) {
//     final List<Widget> items = results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList();
//     // ignore: cascade_invocations
//     items.insert(0, _buildSuggestionTitle(context));
//     return Stack(
//       children: [
//         TopLeft(
//           child: Container(
//             margin: EdgeInsets.only(top: $styles.insets.xxs),
//             width: constraints.maxWidth,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.25),
//                   blurRadius: 4,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Container(
//               padding: EdgeInsets.all($styles.insets.xs),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular($styles.insets.xs),
//               ),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 200),
//                 child: ListView(
//                   padding: EdgeInsets.all($styles.insets.xs),
//                   shrinkWrap: true,
//                   children: items,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSuggestionTitle(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
//       margin: EdgeInsets.only(bottom: $styles.insets.xxs),
//       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
//       child: CenterLeft(
//         child: DefaultTextStyle(
//           style: $styles.textStyles.title2.copyWith(color: Colors.black),
//           child: Text(
//             $strings.searchInputTitleSuggestions.toUpperCase(),
//             overflow: TextOverflow.ellipsis,
//             textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
//     return InkWell(
//       onTap: onPressed,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
//         child: ListTile(
//           title: Text(
//             suggestion,
//             style: $styles.textStyles.bodySmall,
//           ),
//           trailing: const Icon(
//             Icons.arrow_forward_ios,
//             size: 24,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInput(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, _) {
//     final Color? captionColor = Theme.of(context).textTheme.bodySmall!.color;
//     return Container(
//       height: $styles.insets.xl,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular($styles.insets.xs),
//       ),
//       child: Row(
//         children: [
//           Gap($styles.insets.xs * 1.5),
//           const Icon(Icons.search),
//           Expanded(
//             child: TextField(
//               onSubmitted: onSubmit,
//               controller: textEditingController,
//               focusNode: focusNode,
//               style: TextStyle(color: captionColor),
//               textAlignVertical: TextAlignVertical.top,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: EdgeInsets.all($styles.insets.xs),
//                 labelStyle: TextStyle(color: captionColor),
//                 hintStyle: TextStyle(color: captionColor!.withOpacity(0.5)),
//                 prefixStyle: TextStyle(color: captionColor),
//                 hintText: $strings.searchInputHintSearch,
//               ),
//             ),
//           ),
//           Gap($styles.insets.xs),
//           ValueListenableBuilder(
//             valueListenable: textEditingController,
//             builder: (_, value, __) => Visibility(
//               visible: textEditingController.value.text.isNotEmpty,
//               child: Padding(
//                 padding: EdgeInsets.only(right: $styles.insets.xs),
//                 child: CircleIconButton(
//                   icon: AppIconsEnums.close,
//                   semanticLabel: $strings.searchInputSemanticClear,
//                   size: $styles.insets.md,
//                   iconSize: $styles.insets.sm,
//                   onPressed: () {
//                     textEditingController.clear();
//                     onSubmit('');
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
