import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class DescriptionHeadingWidget extends StatefulWidget {
  final String heading;
  final String description;
  bool isCenteredHeading;

  DescriptionHeadingWidget({
    super.key,
    this.isCenteredHeading = false,
    required this.heading,
    required this.description,
  });

  @override
  State<DescriptionHeadingWidget> createState() =>
      _DescriptionHeadingWidgetState();
}

class _DescriptionHeadingWidgetState extends State<DescriptionHeadingWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final truncatedDescription = widget.description.length > 300
        ? '${widget.description.substring(0, 300)}... '
        : widget.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: widget.isCenteredHeading
              ? Alignment.center
              : Alignment.centerLeft,
          child: Text(
            widget.heading,
            style: textTheme.titleLarge,
            // textAlign: TextAlign.left,
          ),
        ),
        const ThemeGap(5),
        Align(
          alignment: widget.isCenteredHeading
              ? Alignment.center
              : Alignment.centerLeft,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: RichText(
              textAlign:
                  widget.isCenteredHeading ? TextAlign.justify : TextAlign.left,
              text: TextSpan(
                style: textTheme.labelMedium,
                children: [
                  TextSpan(
                    text:
                        _isExpanded ? widget.description : truncatedDescription,
                  ),
                  if (widget.description.length > 300)
                    TextSpan(
                      text: _isExpanded ? " less" : " more",
                      style: const TextStyle(color: ThemeColors.primaryBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
