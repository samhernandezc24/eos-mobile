import 'package:eos_mobile/ui/common/predictive/widgets/raw_predictive.dart';

import 'package:flutter/material.dart';

class PredictiveSearchField<T extends Object> extends StatelessWidget {
  const PredictiveSearchField({
    super.key,
    this.fieldViewBuilder         = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight         = 200.0,
    this.optionsViewBuilder,
    this.optionsViewOpenDirection = PredictiveOptionsViewOpenDirection.down,
    this.initialValue,
  });

  final PredictiveFieldViewBuilder fieldViewBuilder;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsViewBuilder<T>? optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final double optionsMaxHeight;
  final TextEditingValue? initialValue;

  static Widget _defaultFieldViewBuilder(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
    return _PredictiveField(
      focusNode             : focusNode,
      onFieldSubmitted      : onFieldSubmitted,
      textEditingController : textEditingController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawPredictive<T>(
      fieldViewBuilder: fieldViewBuilder,
      initialValue: initialValue,
      optionsViewOpenDirection: optionsViewOpenDirection,
      optionsViewBuilder: optionsViewBuilder ?? (BuildContext context, PredictiveOnSelected<T> onSelected, List<T> options) {
        return _PredictiveOptions<T>(
          onSelected        : onSelected,
          maxOptionsHeight  : optionsMaxHeight,
        );
      },
      onSelected: onSelected,
    );
  }
}

// El campo de texto por defecto de PredictiveSearchField estilo Material.
class _PredictiveField extends StatelessWidget {
  const _PredictiveField({
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.textEditingController,
  });

  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}

// Las opciones por defecto de PredictiveSearchField estilo Material.
class _PredictiveOptions<T extends Object> extends StatelessWidget {
  const _PredictiveOptions({
    required this.onSelected,
    required this.maxOptionsHeight,
    super.key,
  });

  final PredictiveOnSelected<T> onSelected;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
        ),
      ),
    );
  }
}
