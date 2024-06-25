import 'package:eos_mobile/core/enums/predictive_view_open_direction.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/predictive/widgets/predictive.dart';
import 'package:flutter/scheduler.dart';

class PredictiveSearchInput<T extends Object> extends StatelessWidget {
  /// Creates an instance of [PredictiveSearchInput]
  const PredictiveSearchInput({
    // required this.controller,
    // required this.onSubmit,
    Key? key,
    this.displayStringForOption   = RawPredictive.defaultStringForOption,
    this.fieldViewBuilder         = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight         = 200.0,
    this.optionsViewBuilder,
    this.optionsViewOpenDirection = PredictiveViewOpenDirection.down,
  }) : super(key: key);

  // final TextEditingController controller;
  // final void Function(String) onSubmit;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveFieldViewBuilder fieldViewBuilder;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsViewBuilder<T>? optionsViewBuilder;
  final PredictiveViewOpenDirection optionsViewOpenDirection;

  /// La altura máxima utilizada para el widget de lista de opciones por defecto.
  ///
  /// Cuando [optionsViewBuilder] es `null`, esta propiedad establece la altura máxima
  /// que puede ocupar el widget de opciones.
  ///
  /// El valor por defecto es 200.
  final double optionsMaxHeight;

  static Widget _defaultFieldViewBuilder(BuildContext context, TextEditingController textController, FocusNode focusNode, VoidCallback onSubmit) {
    return _PredictiveTextField(
      focusNode      : focusNode,
      textController : textController,
      onSubmit       : onSubmit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawPredictive<T>(
      displayStringForOption    : displayStringForOption,
      fieldViewBuilder          : fieldViewBuilder,
      optionsViewOpenDirection  : optionsViewOpenDirection,
      optionsViewBuilder        : optionsViewBuilder ?? (BuildContext context, PredictiveOnSelected<T> onSelected, Iterable<T> options) {
        return _PredictiveOptions<T>(
          displayStringForOption  : displayStringForOption,
          onSelected              : onSelected,
          options                 : options,
          maxOptionsHeight        : optionsMaxHeight,
        );
      },
      onSelected: onSelected,
    );
  }
}

// El campo de texto predictivo por defecto.
class _PredictiveTextField extends StatelessWidget {
  const _PredictiveTextField({
    required this.focusNode,
    required this.textController,
    required this.onSubmit,
  });

  final FocusNode focusNode;
  final VoidCallback onSubmit;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color         : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0.3),
        border        : Border.all(color: Theme.of(context).primaryColor),
        borderRadius  : BorderRadius.circular($styles.insets.xxs),
      ),
      child: Row(
        children: <Widget>[
          Gap($styles.insets.xs * 1.5),
          const Icon(Icons.search),
          Expanded(
            child: TextField(
              onSubmitted       : (String value) {

              },
              controller        : textController,
              focusNode         : focusNode,
              style             : TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlignVertical : TextAlignVertical.top,
              textInputAction   : TextInputAction.search,
              decoration        : InputDecoration(
                isDense         : true,
                fillColor       : Theme.of(context).inputDecorationTheme.fillColor?.withOpacity(0),
                filled          : true,
                contentPadding  : EdgeInsets.all($styles.insets.xs),
                labelStyle      : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle       : TextStyle(color: Theme.of(context).hintColor),
                prefixStyle     : TextStyle(color: Theme.of(context).colorScheme.onSurface),
                focusedBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder   : const OutlineInputBorder(borderSide: BorderSide.none),
                hintText        : $strings.searchInputHintText,
              ),
            ),
          ),
          Gap($styles.insets.xs),
          ValueListenableBuilder(
            valueListenable : textController,
            builder         : (_, value, __) => Visibility(
              visible : textController.value.text.isNotEmpty,
              child   : Padding(
                padding: EdgeInsets.only(right: $styles.insets.xs),
                child: CircleIconButton(
                  backgroundColor : const Color(0xFF7D7873),
                  color           : Colors.white,
                  icon            : AppIcons.close,
                  iconSize        : $styles.insets.sm,
                  semanticLabel   : $strings.searchInputSemanticClear,
                  size            : $styles.insets.md,
                  onPressed       : () {
                    textController.clear(); // Limpia el campo de búsqueda
                    // onSubmit('');           // Limpia la consulta
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Las opciones por defecto del Predictive.
class _PredictiveOptions<T extends Object> extends StatelessWidget {
  const _PredictiveOptions({
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
    Key? key,
  }) : super(key: key);

  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T> onSelected;
  final Iterable<T> options;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 3,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            padding     : EdgeInsets.zero,
            shrinkWrap  : true,
            itemCount   : options.length,
            itemBuilder : (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (BuildContext context) {
                    final bool highlight = PredictiveHighlightOption.of(context) == index;
                    if (highlight) {
                      SchedulerBinding.instance.addPersistentFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                      });
                    }
                    return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
                      padding: EdgeInsets.all($styles.insets.sm),
                      child: Text(displayStringForOption(option)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
