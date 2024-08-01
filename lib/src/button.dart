// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names, constant_identifier_names

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'text.dart';
import 'varriable/varriable.dart';

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  @override
  Key? key;
  Key? btnKey;
  String? ref;
  String? classNames;
  double? width;
  double? height;

  /// 字体
  String? fontFamily;
  double? fontSize;
  FontWeight? fontWeight;
  bool? disabled;
  Color? bgColor;
  String? title;

  /// 边框圆角
  double? borderRadius;

  /// 边框颜色
  Color? borderColor;

  /// 鼠标移上去的背景覆盖区域颜色 OverlayColor
  Color? overlayColor;

  /// 阴影颜色
  Color? shadowColor;
  Style? styles;

  /// 文字颜色
  Color? color;
  Btn._({
    super.key,
    this.text,
    this.btnType,
    this.targetRef,
    this.ghost,
    this.ref,
    this.classNames,
    required this.borderWidth,
    this.style,
    this.targetListRef,
    this.otherRefs,
    this.actionTargets,
    this.ignoreDisabled,
    this.ignorePermission,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.enableLoading,
    this.width,
    this.height,
    this.borderColor,
    this.shadowColor,
    this.overlayColor,
    this.fontFamily,
    this.borderRadius,
    this.disabled,
    this.styles,
    this.title,
    this.color,
    this.bgColor,
    this.fontSize,
  });
  factory Btn(
    String text, {
    Key? key,
    String? ref,
    String? classNames,
    String? title = '',
    String? targetRef,
    String? fontFamily,
    ButtonStyle? style,
    String? targetListRef,
    double? borderRadius,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? color,
    Color? bgColor,
    Color? shadowColor,
    double? fontSize,
    bool? ghost,
    List<String>? otherRefs,
    List<String>? actionTargets,
    bool? ignoreDisabled,
    BtnType? btnType = BtnType.Default,
    bool? ignorePermission,
    double? borderWidth,
    Color? borderColor,
    Color? overlayColor,
    bool? disabled,
    double? width,
    double? height,
    Future<bool> Function()? onPressed,
    Future<bool> Function()? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    bool? enableLoading,
  }) {
    var styles = convertClassNamesToStyle(classNames ?? '');

    return Btn._(
      key: key,
      ref: ref,
      styles: styles as Style,
      classNames: classNames,
      text: text,
      btnType: btnType,
      style: style,
      title: title,
      color: color,
      bgColor: bgColor,
      fontSize: fontSize,
      ghost: ghost,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      borderWidth: borderWidth ?? 1,
      borderColor: borderColor,
      overlayColor: overlayColor,
      shadowColor: shadowColor,
      fontFamily: fontFamily,
      borderRadius: borderRadius,
      targetRef: targetRef,
      targetListRef: targetListRef,
      otherRefs: otherRefs,
      actionTargets: actionTargets,
      ignoreDisabled: ignoreDisabled,
      ignorePermission: ignorePermission,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      enableLoading: enableLoading,
      disabled: disabled,
    );
  }

  String? text = '';

  BtnType? btnType;
  ButtonStyle? style;

  /// 权限类型
  // PermissionType? permissionType;
  // ActionType? actionType;
  // ActionType? aliasActionType;
  // List<ActionType>? aliasActionTypes;
  // List<FileType>? fileType;

  String? targetRef;
  String? targetListRef;
  List<String>? otherRefs;

  /// 指定 操作的表单对象 ref (设置受控字段时用)
  List<String>? actionTargets;
  // FN? fn;

  /// 附带值
  dynamic attachValue;

  /// 忽略 普通的禁用
  bool? ignoreDisabled;

  /// 忽略 权限
  bool? ignorePermission;

  ///幽灵按钮 幽灵按钮将按钮的内容反色，背景变为透明，常用在有色背景上。
  bool? ghost;

  /// 边框宽度
  double borderWidth;

  IconData? prefixIcon;
  IconData? suffixIcon;

  Color? _color;
  Color? _bgColor;
  Color? _borderColor;
  Color? _overlayColor;

  MouseCursor get _mouseCursor {
    return disabled == true
        ? SystemMouseCursors.forbidden
        : WidgetStateMouseCursor.clickable;
  }

  /// 按钮操作时，参数映射关系
  // List<ParamsMap> paramsMap;

  final isHover = false.obs;

  final loading = false.obs;

  /// 启用 loading动画
  bool? enableLoading;
  Future<bool> Function()? onPressed;
  Future<bool> Function()? onLongPress;
  ValueChanged<bool>? onHover;
  ValueChanged<bool>? onFocusChange;
  ButtonStyle _getButtonStyle(StyleAbbrSet s, BoxConstraints constraints) {
    double _width = constraints.maxWidth; // 获取宽度
    double _height = constraints.maxHeight; // 获取宽度
    EdgeInsets l_padding =
        EdgeInsets.fromLTRB(s.cp!.left, s.cp!.top, s.cp!.right, s.cp!.bottom);

    var btnStyle = ButtonStyle(
        overlayColor:
            WidgetStateProperty.all(bgColor ?? const BColors().black50),
        foregroundColor:
            WidgetStateProperty.all(color ?? const BColors().primary),
        backgroundColor:
            WidgetStateProperty.all(bgColor ?? const BColors().white),
        shadowColor:
            WidgetStateProperty.all(shadowColor ?? const BColors().white),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? btnBorderRadius))));
    switch (btnType) {
      case BtnType.Dashed:
      case BtnType.Text:
        if (s.cp == null) {
          l_padding = EdgeInsets.zero;
        }
        _color = color ?? btnTextColor;
        _bgColor = bgColor ?? btnTextBgColor;
        _overlayColor = overlayColor ?? btnTextOverlayColor;
        if (isHover.value == true) {
          // _bgColor = lighten(_borderColor, amount: 45);
          // _borderColor = darken(_borderColor, amount: 5);
          _color = darken(_color, amount: 18);
        }
        if (disabled == true) {
          // _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
          mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
          maximumSize: WidgetStateProperty.all(
              Size(width ?? _width, height ?? btnHeight)),
          minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
          fixedSize: WidgetStateProperty.all(
              Size(width ?? _width, height ?? btnHeight)),
          padding: WidgetStateProperty.all(l_padding),
          splashFactory: NoSplash.splashFactory,
          textStyle: WidgetStateProperty.all(TextStyle(
              fontSize: fontSize ?? btnFontSize,
              fontFamily: fontFamily,
              overflow: TextOverflow.ellipsis)),
          overlayColor: WidgetStateProperty.all(_overlayColor),
          foregroundColor: WidgetStateProperty.all(_color),
          backgroundColor: WidgetStateProperty.all(_bgColor),
        );
        break;
      case BtnType.Icon:
        if (s.cp == null) {
          l_padding = EdgeInsets.zero;
        }
        _color = color ?? btnIconColor;
        _bgColor = bgColor ?? btnIconBgColor;
        _borderColor = borderColor ?? btnIconBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          _color = lighten(_color, amount: 50);
        }
        if (disabled == true) {
          // _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnIconShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Link:
        if (s.cp == null) {
          l_padding = EdgeInsets.zero;
        }
        _color = color ?? btnLinkColor;
        _bgColor = bgColor ?? btnLinkBgColor;
        _overlayColor = overlayColor ?? btnLinkOverlayColor;
        if (isHover.value == true) {
          // _bgColor = lighten(_borderColor, amount: 45);
          // _borderColor = darken(_borderColor, amount: 5);
          _color = lighten(_color, amount: 18);
        }
        if (disabled == true) {
          // _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
          mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
          // maximumSize: WidgetStateProperty .all(Size(width ?? _width, 20)),
          // minimumSize: WidgetStateProperty .all(const Size(20, 20)),
          // fixedSize: WidgetStateProperty .all(Size(width ?? _width, 20)),
          maximumSize: WidgetStateProperty.all(
              Size(width ?? _width, height ?? btnHeight)),
          minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
          fixedSize: WidgetStateProperty.all(
              Size(width ?? _width, height ?? btnHeight)),
          padding: WidgetStateProperty.all(l_padding),
          splashFactory: NoSplash.splashFactory,
          textStyle: WidgetStateProperty.all(TextStyle(
              fontSize: fontSize ?? btnFontSize,
              fontFamily: fontFamily,
              overflow: TextOverflow.ellipsis)),
          overlayColor: WidgetStateProperty.all(_overlayColor),
          foregroundColor: WidgetStateProperty.all(_color),
          backgroundColor: WidgetStateProperty.all(_bgColor),
          shadowColor: WidgetStateProperty.all(shadowColor ?? btnShadowColor),
          // shape: WidgetStateProperty .all(RoundedRectangleBorder(
          //     borderRadius:
          //         BorderRadius.circular(borderRadius ?? btnBorderRadius))),
        );
        break;
      case BtnType.Primary:
        _color = color ?? btnPrimaryColor;
        _bgColor = bgColor ?? btnPrimaryBgColor;
        _borderColor = borderColor ?? btnPrimaryBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnPrimaryShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Secondary:
        _color = color ?? btnSecondaryColor;
        _bgColor = bgColor ?? btnSecondaryBgColor;
        _borderColor = borderColor ?? btnSecondaryBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnSecondaryShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Success:
        _color = color ?? btnSuccessColor;
        _bgColor = bgColor ?? btnSuccessBgColor;
        _borderColor = borderColor ?? btnSuccessBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnSuccessShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Danger:
        _color = color ?? btnDangerColor;
        _bgColor = bgColor ?? btnDangerBgColor;
        _borderColor = borderColor ?? btnDangerBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnDangerShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Warning:
        _color = color ?? btnWarningColor;
        _bgColor = bgColor ?? btnWarningBgColor;
        _borderColor = borderColor ?? btnWarningBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnWarningShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case BtnType.Info:
        _color = color ?? btnInfoColor;
        _bgColor = bgColor ?? btnInfoBgColor;
        _borderColor = borderColor ?? btnInfoBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_bgColor, amount: 12);
          // _borderColor = darken(_borderColor, amount: 5);
          // _color = darken(_color, amount: 5);
        }
        if (ghost == true) {
          var _ghost = _color;
          _color = _bgColor;
          _bgColor = _ghost;
          _borderColor = _color;
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor:
                WidgetStateProperty.all(shadowColor ?? btnInfoShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
      case null:
      case BtnType.Default:
      default:
        _color = color ?? btnColor;
        _bgColor = bgColor ?? btnBgColor;
        _borderColor = borderColor ?? btnBorderColor;
        _overlayColor = overlayColor;
        if (isHover.value == true) {
          _bgColor = lighten(_borderColor, amount: 45);
          _borderColor = darken(_borderColor, amount: 5);
          _color = darken(_color, amount: 5);
        }
        if (disabled == true) {
          _bgColor = disabledBgColor;
          _color = disabledColor;
        }
        btnStyle = ButtonStyle(
            mouseCursor: WidgetStateProperty.all<MouseCursor>(_mouseCursor),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            minimumSize: WidgetStateProperty.all(Size(20, height ?? btnHeight)),
            padding: WidgetStateProperty.all(l_padding),
            fixedSize: WidgetStateProperty.all(
                Size(width ?? _width, height ?? btnHeight)),
            textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: fontSize ?? btnFontSize,
                fontFamily: fontFamily,
                overflow: TextOverflow.ellipsis)),
            overlayColor: WidgetStateProperty.all(_overlayColor),
            foregroundColor: WidgetStateProperty.all(_color),
            backgroundColor: WidgetStateProperty.all(_bgColor),
            shadowColor: WidgetStateProperty.all(shadowColor ?? btnShadowColor),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? btnBorderRadius))),
            side: WidgetStateProperty.all(BorderSide(
                width: borderWidth, color: _borderColor ?? btnBorderColor)));
        break;
    }
    return btnStyle;
  }

  Widget _getChildren(StyleAbbrSet s) {
    List<Widget> children = [];
    if (prefixIcon != null) {
      children.add(Icon(prefixIcon));
    }
    children.add(get_textWidget(s));
    if (suffixIcon != null) {
      children.add(Icon(suffixIcon));
    }
    return Wrap(
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.up,
      // crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.center,
      children: children,
    );
  }

  BTxt get_textWidget(StyleAbbrSet s) {
    return BTxt(
      (text ?? '').tr,
      fontWeight: s.fw,
      fontSize: s.fs,
    );
  }

  Widget _getBtn(StyleAbbrSet s, BoxConstraints constraints) {
    late Widget btn;

    var _textWidget = get_textWidget(s);
    Widget _child = _getChildren(s);
    switch (btnType) {
      case BtnType.Dashed:
        btn = OutlinedButton(
          key: btnKey,
          onPressed: _onPressed,
          onLongPress: _onLongPress,
          onHover: _onHover,
          onFocusChange: _onFocusChange,
          child: _textWidget,
          /*   style: const OutlineInputBorder(
            borderSide: BorderSide.lerp(
                const BorderSide(width: 1, style: BorderStyle.solid),
                const BorderSide(width: 1, style: BorderStyle.none),
                1),
          ), */
        );
        break;
      case BtnType.Text:
        btn = TextButton(
          key: btnKey,
          onPressed: _onPressed,
          onLongPress: _onLongPress,
          onHover: _onHover,
          onFocusChange: _onFocusChange,
          style: _getButtonStyle(s, constraints),
          child: _textWidget,
        );
        break;
      case BtnType.Icon:
        var icon = prefixIcon ?? suffixIcon;
        if (icon != null) {
          btn = IconButton(
            key: btnKey,
            onPressed: _onPressed,
            icon: Icon(icon),
            style: _getButtonStyle(s, constraints),
          );
        } else {
          throw StateError('Icon is null');
        }
        break;
      case BtnType.Default:
      case BtnType.Primary:
      case BtnType.Secondary:
      case BtnType.Success:
      case BtnType.Danger:
      case BtnType.Warning:
      case BtnType.Info:
        btn = ElevatedButton(
          key: btnKey,
          onPressed: disabled == true ? null : _onPressed,
          onLongPress: disabled == true ? null : _onLongPress,
          onHover: disabled == true ? null : _onHover,
          onFocusChange: _onFocusChange,
          style: _getButtonStyle(s, constraints),
          child: _child,
        );
        break;
      case BtnType.Link:
        btn = TextButton(
          key: btnKey,
          onPressed: _onPressed,
          onLongPress: _onLongPress,
          onHover: _onHover,
          onFocusChange: _onFocusChange,
          style: _getButtonStyle(s, constraints),
          child: _textWidget,
        );
        break;
      case null:
      default:
        btn = OutlinedButton(
          key: btnKey,
          onPressed: _onPressed,
          onLongPress: _onLongPress,
          onHover: _onHover,
          onFocusChange: _onFocusChange,
          style: _getButtonStyle(s, constraints),
          child: _child,
        );
        break;
    }
    return btn;
  }

  _onPressed() {
    if (onPressed != null) {
      if (loading.value == true) {
        return;
      }
      loading.value = true;
      Future<bool> future = onPressed!();

      future.then((x) {
        loading.value = false;
        // print(x);
        // console.debugger();
      }).catchError((err) {
        loading.value = false;
      });
    }
  }

  _onLongPress() {
    if (onLongPress != null) {
      if (loading.value == true) {
        return;
      }
      loading.value = true;
      Future<bool> future = onLongPress!();

      future.then((x) {
        loading.value = false;
        // print(x);
        // console.debugger();
      }).catchError((err) {});
    }
  }

  ValueChanged<bool>? _onHover(bool e) {
    isHover.value = e;
    if (e && onHover != null) {
      onHover!(e);
    }
    return null;
  }

  ValueChanged<bool>? _onFocusChange(bool e) {
    if (e && onFocusChange != null) {
      onHover!(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQueryBuilder(builder: (context, constraints, screenData) {
      var s = getStyle(screenData, constraints, styles);
      // if (text == 'Info') console.debugger(message: text);
      return Tooltip(
        message: title,
        waitDuration: Durations.long2,
        child: Obx(() => Stack(
              children: [
                _getBtn(s, constraints),
                if (loading.value == true && enableLoading == true)
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: (height ?? btnHeight) * .8,
                        height: (height ?? btnHeight) * .8,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      );
    });
  }
}

enum BtnType {
  Text,
  Icon,
  Primary,
  Dashed,
  Link,
  Default,
  Secondary,
  Success,
  Danger,
  Warning,
  Info,
}

  /// 类样式中的 mt mb ml mr mx my pt pb pl pr px py 含义
  ///
  /// 内边距（pading）外边距（margin）
  ///
  /// m - for classes 代表 margin
  ///
  /// p - for classes 代表 padding
  ///
  /// t - for classes that set margin-top or padding-top 设置margin-top或padding-top
  ///
  /// b - for classes that set margin-bottom or padding-bottom 设置margin-bottom或padding-bottom
  ///
  /// l - for classes that set margin-left or padding-left 设置margin-left或padding-left
  ///
  /// r - for classes that set margin-right or padding-right 设置margin-right或padding-right
  ///
  /// x - for classes that set both -left and -right 设置padding-left和padding-right或margin-left和margin-right
  ///
  /// y - for classes that set both -top and -bottom 设置padding-top和padding-bottom或margin-top和margin-bottom
 