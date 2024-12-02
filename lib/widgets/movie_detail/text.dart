import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  const ExpandableText({
    Key? key,
    required this.text,
    this.maxLines = 3,
    this.textStyle,
    this.linkStyle,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = widget.textStyle ?? const TextStyle(fontSize: 16);
        final linkStyle = widget.linkStyle ??
            const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            );

        // Tạo TextPainter để tính toán
        final span = TextSpan(
          text: widget.text,
          style: textStyle,
        );

        final textPainter = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        if (!isOverflowing || isExpanded) {
          // Trường hợp hiển thị toàn bộ văn bản
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.text,
                  style: textStyle,
                ),
                if (isOverflowing)
                  TextSpan(
                    text: " Show Less",
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isExpanded = false;
                        });
                      },
                  ),
              ],
            ),
          );
        } else {
          // Trường hợp bị cắt bớt
          final visibleText = _calculateVisibleText(
              widget.text, textPainter, constraints.maxWidth, linkStyle, textStyle);

          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: visibleText,
                  style: textStyle,
                ),
                TextSpan(
                  text: "... Show More",
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  /// Tính toán phần văn bản hiển thị vừa với số dòng và thêm chỗ cho "Show More"
  String _calculateVisibleText(String fullText, TextPainter textPainter,
      double maxWidth, TextStyle linkStyle, TextStyle textStyle) {
    final linkSpan = TextSpan(text: "... Show More", style: linkStyle);
    final linkPainter = TextPainter(
      text: linkSpan,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final linkWidth = linkPainter.width;
    final endOffset = textPainter.getPositionForOffset(
      Offset(textPainter.size.width - linkWidth, textPainter.size.height),
    );

    return fullText.substring(0, endOffset.offset).trim();
  }
}
