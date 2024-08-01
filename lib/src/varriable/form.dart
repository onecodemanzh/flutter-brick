part of 'varriable.dart';

/// 表单 label 颜色
Color formLabelColor = Colors.black87;

/// 表单 label 字体大小
double formLabelFontSize = 14.0;

/// 表单 label 字体
String formLabelFontFamily = '';

/// 表单 label 粗细
FontWeight formLabelFontWeight = FontWeight.w600;

/// 表单 label 与 输入框 间距 (0-18,大于18,溢出部分隐藏)
double formLabelSpace = 10.0;

/// 表单 label 左边距
double formLabelHeight = 30.0;

/// 表单 label 左边距
double formLabelLeftPadding = 0.0;

Color? formFocusColor;
Color? formHoverColor;
InputBorder? formErrorBorder;
InputBorder? formFocusedBorder =
    OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: _primary));
InputBorder? formFocusedErrorBorder;
InputBorder? formDisabledBorder;
InputBorder? formEnabledBorder;
InputBorder? formBorder =
    OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: _secondary));

// double formInputItemHeight = 30.0; /// 表单 输入框 高度 (formInputPadding)
///  表单输入部分 padding(通过padding + fontSize 间接控制输入框高度)
EdgeInsets formInputPadding = const EdgeInsets.fromLTRB(8, 10, 8, 10);

/// 表单 输入部分 字体大小
double formInputFontSize = 14.0;

/// 表单 输入部分 高度倍数
double formInputHeight = 1.2;

/// 表单 列gap
int formItemColumnGap = 10;

/// 表单 行gap
int formItemRowGap = 3;
