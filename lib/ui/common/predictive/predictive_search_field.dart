import 'package:eos_mobile/ui/common/predictive/widgets/raw_predictive.dart';
import 'package:flutter/material.dart';

class PredictiveSearchField<T extends Object> extends StatelessWidget {
  const PredictiveSearchField({
    super.key,
    this.displayStringForOption     = RawPredictive.defaultStringForOption,
    this.fieldViewBuilder           = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight           = 200.0,
    this.optionsViewBuilder,
    this.optionsViewOpenDirection   = PredictiveOptionsViewOpenDirection.down,
  });

  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveFieldViewBuilder fieldViewBuilder;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsViewBuilder<T>? optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final double optionsMaxHeight;

  static Widget _defaultFieldViewBuilder(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
    return _PredictiveSearchInput(
      focusNode             : focusNode,
      textEditingController : textEditingController,
      onFieldSubmitted      : onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawPredictive<T>(
      fieldViewBuilder          : fieldViewBuilder,
      optionsViewOpenDirection  : optionsViewOpenDirection,
      optionsViewBuilder        : optionsViewBuilder ?? (BuildContext context, PredictiveOnSelected<T> onSelected, List<T> options) {
        return _PredictiveOptions<T>(
          displayStringForOption  : displayStringForOption,
          onSelected              : onSelected,
          options                 : options,
          maxOptionsHeight        : optionsMaxHeight,
        );
      },
    );
  }
}

// El campo de texto por defecto de PredictiveSearchField estilo Material.
class _PredictiveSearchInput extends StatelessWidget {
  const _PredictiveSearchInput({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller        : textEditingController,
      focusNode         : focusNode,
      onFieldSubmitted  : (String value) => onFieldSubmitted(),
    );
  }
}

// Las opciones por defecto de PredictiveSearchField estilo Material.
class _PredictiveOptions<T extends Object> extends StatelessWidget {
  const _PredictiveOptions({
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
    super.key,
  });

  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T> onSelected;
  final List<T> options;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (BuildContext context) {
                    return Container(
                      padding : const EdgeInsets.all(16),
                      child   : Text(displayStringForOption(option)),
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
