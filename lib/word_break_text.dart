library word_break_text;

import 'package:flutter/material.dart';

/// Text widget with word-break.
///
/// It is a verbose and useless widget. Please support natively.
/// CJK sentences cannot support word break like english sentences.
///
/// [WordBreakText] cannot support overflow now.
///
/// ## How to use
/// Same as Text widget.
///
/// ```dart
/// WordBreakText("헬로월드. 이것은 긴 문장입니다. 작은 화면에서 단어를 기준으로 줄바꿈이 되어야 합니다.");
/// WordBreakText("ハローワールド。 これは長い文章です。 小さな画面で単語に基づいて改行する必要があります。");
/// WordBreakText("你好，世界。 这是一个很长的句子。 在小屏幕上， 它应该按字换行。");
/// ```
///
/// ## cons
/// [WordBreakText] widget using Wrap for word-break.
class WordBreakText extends StatelessWidget {
  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  ///
  /// Empty string is not allowed.
  /// Multiple spaces will be change to one space.
  final String data;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The strategy to use when calculating the width of the Text.
  ///
  /// See [TextWidthBasis] for possible values and their implications.
  final TextWidthBasis? textWidthBasis;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment wrapAlignment;

  /// The direction to use as the main axis.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// Who [Wrap] should align children within a run in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment runAlignment;

  /// Space between words.
  ///
  final double spacing;

  /// Space beween lines.
  final double runSpacing;

  /// This is a spacing strategy.
  ///
  /// If `true`, no spaces are added to words,
  /// only the [spacing] of the Wrap widget is used.
  final bool spacingByWrap;

  List<String> get _splitData =>
      data.split(' ').where((element) => element.trim() != '').toList();

  int get _lastWordIndex => _splitData.length - 1;

  const WordBreakText(
    this.data, {
    Key? key,
    this.style,
    this.locale,
    this.textAlign,
    this.textWidthBasis,
    this.textScaleFactor,
    this.textHeightBehavior,
    this.wrapAlignment = WrapAlignment.start,
    this.direction = Axis.horizontal,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.spacingByWrap = false,
  })  : assert(data.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        children: _splitData.asMap().entries.map(_mapTextWidget).toList(),
        crossAxisAlignment: crossAxisAlignment,
        alignment: wrapAlignment,
        direction: direction,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        spacing: spacing,
      );

  Text _mapTextWidget(mapEntry) {
    String data = mapEntry.value;
    if (!spacingByWrap) {
      if (mapEntry.key != _lastWordIndex) data = '$data ';
    }
    return Text(
      data,
      style: style,
      locale: locale,
      textAlign: textAlign,
      textWidthBasis: textWidthBasis,
      textScaleFactor: textScaleFactor,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
