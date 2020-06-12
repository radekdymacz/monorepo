import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/config/color_config.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:provider/provider.dart';

class MetricsDropdownButton<T> extends StatelessWidget {
  final EdgeInsets padding;
  final Decoration decoration;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T> onChanged;
  final Widget disabledHint;

  const MetricsDropdownButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.decoration,
    this.value,
    this.items,
    this.onChanged,
    this.disabledHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          disabledHint: disabledHint,
        ),
      ),
    );
  }
}
