// ignore_for_file: unused_element

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';


class BTxt extends StatelessWidget {
  Style? styles;
  String? title;
  double? width;
  double? height;

  /// 字体
  String? fontFamily;
  double? fontSize;
  FontWeight? fontWeight;
  Color? bgColor;
  EdgeInsets? margin;
  EdgeInsets? padding;

  /// 文字颜色
  Color? color;
  BTxt._({
    super.key,
    this.styles,
    this.title,
    this.width,
    this.height,
    this.fontSize,
    this.fontFamily,
    this.color,
    this.bgColor,
    this.margin,
    this.padding,
    this.fontWeight,
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.leadingDistribution,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.maxLines,
  });
  factory BTxt(
    String text, {
    Key? key,
    String? classNames,
    String? title,
    String? fontFamily,
    Color? color,
    Color? bgColor,
    Color? shadowColor,
    double? fontSize,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    FontWeight? fontWeight,
    int? maxLines,
    final TextStyle? style,
    final StrutStyle? strutStyle,
    final TextAlign? textAlign,
    final TextDirection? textDirection,
    final Locale? locale,
    final bool? softWrap,
    final TextOverflow? overflow,
    final FontStyle? fontStyle,
    final double? letterSpacing,
    final double? wordSpacing,
    final TextBaseline? textBaseline,
    final TextLeadingDistribution? leadingDistribution,
    final Paint? foreground,
    final Paint? background,
    final TextDecoration? decoration,
    final Color? decorationColor,
    final TextDecorationStyle? decorationStyle,
    final double? decorationThickness,
    final List<Shadow>? shadows,
    final List<FontFeature>? fontFeatures,
    final List<FontVariation>? fontVariations,
  }) {
    var styles = convertClassNamesToStyle(classNames ?? '');
    return BTxt._(
      text: text,
      styles: styles as Style,
      style: style,
      title: title,
      color: color,
      bgColor: bgColor,
      width: width,
      height: height,
      fontFamily: fontFamily,
      fontSize: fontSize,
      margin: margin,
      padding: padding,
      fontWeight: fontWeight,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      leadingDistribution: leadingDistribution,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      maxLines: maxLines,
    );
  }
  String text;
  final FontStyle? fontStyle;
  final TextStyle? style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final TextLeadingDistribution? leadingDistribution;
  final Paint? foreground;
  final Paint? background;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final List<FontFeature>? fontFeatures;
  final List<FontVariation>? fontVariations;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return MediaQueryBuilder(builder: (context, constraints, screenData) {
      var s = getStyle(screenData, constraints, styles);
      // if (text == 'Info') console.debugger(message: text);
      return Tooltip(
        message: text,
        waitDuration: Durations.long2,
        child: Container(
          color: s.bg,
          // width: 100,
          margin: margin ??
              EdgeInsets.fromLTRB(
                  s.cm!.left, s.cm!.top, s.cm!.right, s.cm!.bottom),
          padding: padding ??
              EdgeInsets.fromLTRB(
                  s.cp!.left, s.cp!.top, s.cp!.right, s.cp!.bottom),
          child: Text(
            text,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            maxLines: maxLines,
            style: style ??
                TextStyle(
                    fontSize: fontSize ?? s.fs,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight ?? s.fw,
                    color: color ?? s.color,
                    backgroundColor: bgColor,
                    fontStyle: fontStyle,
                    letterSpacing: letterSpacing,
                    wordSpacing: wordSpacing,
                    textBaseline: textBaseline,
                    height: height,
                    leadingDistribution: leadingDistribution,
                    locale: locale,
                    foreground: foreground,
                    background: background,
                    shadows: shadows,
                    fontFeatures: fontFeatures,
                    fontVariations: fontVariations,
                    decoration: decoration,
                    decorationColor: decorationColor,
                    decorationStyle: decorationStyle,
                    decorationThickness: decorationThickness,
                    overflow: overflow),
          ),
        ),
      );
    });
  }
}
