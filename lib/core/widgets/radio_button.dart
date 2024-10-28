import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;
  final Color? labelColor;
  final double? size;
  final TextStyle? labelStyle;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    this.activeColor,
    this.labelColor,
    this.size,
    this.labelStyle,
  });

  @override
  State<CustomRadioButton<T>> createState() => _CustomRadioButtonState<T>();
}

class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = widget.value == widget.groupValue;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onChanged(widget.value),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _isHovered ? theme.hoverColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.size ?? 24.0,
                height: widget.size ?? 24.0,
                child: Radio<T>(
                  value: widget.value,
                  groupValue: widget.groupValue,
                  onChanged: widget.onChanged,
                  activeColor: widget.activeColor ?? theme.primaryColor,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  widget.label,
                  style: widget.labelStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: widget.labelColor ?? theme.textTheme.bodyMedium?.color,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}