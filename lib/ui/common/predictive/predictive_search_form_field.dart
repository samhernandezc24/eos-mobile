import 'dart:async';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter/scheduler.dart';

part 'widgets/raw_predictive.dart';

class PredictiveSearchFormField<T extends Object> extends StatelessWidget {
  const PredictiveSearchFormField({
    required this.optionsBuilder,
    Key? key,
    this.displayStringForOption   = RawPredictive.defaultStringForOption,
    this.fieldViewBuilder         = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight         = 200.0,
    this.optionsViewBuilder,
    this.optionsViewOpenDirection = PredictiveOptionsViewOpenDirection.down,
    this.initialValue,
  }) : super(key: key);

  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveFieldViewBuilder fieldViewBuilder;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsBuilder<T> optionsBuilder;
  final PredictiveOptionsViewBuilder<T>? optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final double optionsMaxHeight;
  final TextEditingValue? initialValue;


  static Widget _defaultFieldViewBuilder(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
    return _PredictiveField(
      focusNode             : focusNode,
      textEditingController : textEditingController,
      onFieldSubmitted      : onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawPredictive<T>(
      displayStringForOption    : displayStringForOption,
      fieldViewBuilder          : fieldViewBuilder,
      initialValue              : initialValue,
      onSelected                : onSelected,
      optionsBuilder            : optionsBuilder,
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
