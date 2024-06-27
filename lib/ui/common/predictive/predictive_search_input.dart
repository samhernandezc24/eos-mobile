import 'package:eos_mobile/ui/common/predictive/widgets/predictive.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PredictiveSearchField<T extends Object> extends StatelessWidget {
  const PredictiveSearchField({
    required this.lstRows,
    Key? key,
    this.displayStringForOption             = RawPredictive.defaultStringForOption,
    this.fieldViewBuilder                   = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight                   = 200.0,
    this.optionsViewBuilder,
    this.predictiveOptionsViewOpenDirection = PredictiveOptionsViewOpenDirection.down,
    this.boolError,
    this.initialValue,
  }) : super(key: key);

  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveFieldViewBuilder fieldViewBuilder;
  final PredictiveOptions<T> lstRows;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsViewBuilder<T>? optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection predictiveOptionsViewOpenDirection;
  final double optionsMaxHeight;
  final bool? boolError;
  final TextEditingValue? initialValue;

  static Widget _defaultFieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return _PredictiveInputField(
      focusNode             : focusNode,
      textEditingController : textEditingController,
      onFieldSubmitted      : onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawPredictive<T>(
      displayStringForOption  : displayStringForOption,
      fieldViewBuilder        : fieldViewBuilder,
      initialValue            : initialValue,
      optionsViewBuilder      : optionsViewBuilder ?? (BuildContext context, PredictiveOnSelected<T> onSelected) {
        return _PredictiveOptions<T>(
          displayStringForOption  : displayStringForOption,
          onSelected              : onSelected,
          options                 : lstRows,
          maxOptionsHeight        : optionsMaxHeight,
        );
      },
      // optionsViewBuilder      : optionsViewBuilder ?? (BuildContext context, PredictiveOnSelected<T> onSelected, Iterable<T> options) {
      //   return _PredictiveOptions<T>(
      //     displayStringForOption  : displayStringForOption,
      //     onSelected              : onSelected,
      //     options                 : options,
      //     maxOptionsHeight        : optionsMaxHeight,
      //   );
      // },
      onSelected             : onSelected,
      lstRows                : lstRows,
    );
  }
}

// El campo de texto por defecto de PredictiveSearchField estilo Material.
class _PredictiveInputField extends StatelessWidget {
  const _PredictiveInputField({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller        : textEditingController,
      focusNode         : focusNode,
      onFieldSubmitted  : (String value) {
        onFieldSubmitted();
      },
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
        elevation: 4,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (BuildContext context) {
                    final bool highlight = PredictiveHighlightedOption.of(context) == index;
                    if (highlight) {
                      SchedulerBinding.instance.addPostFrameCallback(
                        (Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        },
                        debugLabel: 'PredictiveOptions.ensureVisible',
                      );
                    }
                    return Container(
                      color   : highlight ? Theme.of(context).focusColor : null,
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
