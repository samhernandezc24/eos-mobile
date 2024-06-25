part of '../../../../pages/list/list_page.dart';

class _ResultsPredictiveList extends StatelessWidget {
  const _ResultsPredictiveList({
    required this.lstUnidades,
    Key? key,
  }) : super(key: key);

  final List<UnidadPredictiveListEntity> lstUnidades;

  @override
  Widget build(BuildContext context) {
    return Text('Hola');
    // return GestureDetector(
    //   onTap: FocusManager.instance.primaryFocus?.unfocus,
    //   child: Container(
    //     padding: EdgeInsets.only(top: $styles.insets.xs),
    //     child: LayoutBuilder(
    //       builder: (ctx, constraints) => Center(
    //         child: _buildSuggestionsView(context, lstUnidades, constraints),
    //       ),
    //     ),
    //   ),
    // );
  }

  // Widget _buildSuggestionsView(
  //   BuildContext context,
  //   Iterable<UnidadPredictiveListEntity> results,
  //   BoxConstraints constraints,
  // ) {
  //   final List<Widget> lstItems = results.map((item) => Text('Hola')).toList();
  //   lstItems.insert(0, Text('RESULTADOS'));

  //   return Stack(
  //     children: <Widget>[
  //       // ExcludeSemantics(child: AppBtn.basic(onPressed: FocusManager.instance.primaryFocus!.unfocus, semanticLabel: '', child: const SizedBox.expand())),
  //       TopLeft(
  //         child: Container(
  //           margin: EdgeInsets.only(top: $styles.insets.xxs),
  //           width: constraints.maxWidth,
  //           decoration: BoxDecoration(
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.25),
  //                 blurRadius: 4,
  //                 offset: const Offset(0, 4),
  //               ),
  //             ],
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.all($styles.insets.xs),
  //             decoration: BoxDecoration(
  //               color         : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.92),
  //               border        : Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
  //               borderRadius  : BorderRadius.circular($styles.insets.xs),
  //             ),
  //             child: ConstrainedBox(
  //               constraints : const BoxConstraints(maxHeight: 200),
  //               child: Text('Hola'),
  //               // child       : ListView(
  //               //   padding     : EdgeInsets.all($styles.insets.xs),
  //               //   shrinkWrap  : true,
  //               //   children    : lstItems,
  //               // ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSuggestionsView(
  //   BuildContext context,
  //   void Function(UnidadPredictiveListEntity) onSelected,
  //   Iterable<UnidadPredictiveListEntity> results,
  //   BoxConstraints constraints,
  // ) {
  //   final List<Widget> lstItems = results.map((item) => _buildSuggestion(context, item, () => onSelected(item))).toList();
  //   lstItems.insert(0, _buildSuggestionTitle(context));
  //   return Stack(
  //     children: <Widget>[
  //       ExcludeSemantics(child: AppBtn.basic(onPressed: FocusManager.instance.primaryFocus!.unfocus, semanticLabel: '', child: const SizedBox.expand())),
  //       TopLeft(
  //         child: Container(
  //           margin      : EdgeInsets.only(top: $styles.insets.xxs),
  //           width       : constraints.maxWidth,
  //           decoration  : BoxDecoration(
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.25),
  //                 blurRadius: 4,
  //                 offset: const Offset(0, 4),
  //               ),
  //             ],
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.all($styles.insets.xs),
  //             decoration: BoxDecoration(
  //               color         : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.92),
  //               border        : Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
  //               borderRadius  : BorderRadius.circular($styles.insets.xs),
  //             ),
  //             child: ConstrainedBox(
  //               constraints : const BoxConstraints(maxHeight: 200),
  //               child       : ListView(
  //                 padding     : EdgeInsets.all($styles.insets.xs),
  //                 shrinkWrap  : true,
  //                 children    : lstItems,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSuggestionTitle(BuildContext context) {
  //   return Container(
  //     padding     : EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
  //     margin      : EdgeInsets.only(bottom: $styles.insets.xxs),
  //     decoration  : BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1)))),
  //     child       : CenterLeft(
  //       child: DefaultTextStyle(
  //         style : $styles.textStyles.title2.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
  //         child : Text(
  //           $strings.searchInputSuggestionsTitle.toUpperCase(),
  //           overflow            : TextOverflow.ellipsis,
  //           textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSuggestion(BuildContext context, UnidadPredictiveListEntity suggestion, VoidCallback onPressed) {
  //   return AppBtn.basic(
  //     onPressed     : onPressed,
  //     semanticLabel : suggestion.numeroEconomico,
  //     child         : Padding(
  //       padding : EdgeInsets.all($styles.insets.xs),
  //       child   : CenterLeft(
  //         child: DefaultTextStyle(
  //           style : $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
  //           child : Text(
  //             suggestion.numeroEconomico,
  //             overflow            : TextOverflow.ellipsis,
  //             textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
