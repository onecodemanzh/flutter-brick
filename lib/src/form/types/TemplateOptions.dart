// ignore_for_file: file_names

part of form;

///
/// prefix  [Widget]  前缀
///
/// suffix  [Widget]  后缀
///
/// text  [String]  做为文本组件显示 用
///
/// label [String]  标签
///
/// title [Widget]  Checkbox 文本
///
/// placeholder [String]  提示文本
///
/// format  [String]  日期控件 格式化
///
/// options [List] [LabelValue] 下拉项
///
/// prefixOption [List] [LabelValue]  在后端返回 的下拉项前，要加的项 （一般 加 all）
///
/// optionsStyle [OptionStyle] option 样式
///
/// rules [Rule]  当前控件 验证规则配置
///
/// errorInfo [ErrorInfo] 当前控件 错误信息配置
///
/// validateFirst [bool]  当某一规则校验不通过时，是否停止剩下的规则的校验
///
/// hooks [List] [Hooks]  表单联动关系
///
/// disabled [bool]  是否禁用
///
/// autovalidateMode [AutovalidateMode] 用于配置[FormField]和[Form] Widget 的自动验证。
class TemplateOptions {
  /// 前缀
  Widget? prefix;

  /// 后缀
  Widget? suffix;

  /// 做为文本组件显示 用
  String? text;

  /// 标签 ([label] 和 [labelText] 同时存在，以[label]优先)
  Widget? label;

  /// 标签文本 ([label] 和 [labelText] 同时存在，以[label]优先)
  String? labelText;

  /// 配合 label 属性使用，表示是否显示 label 后面的冒号
  bool? colon;

  /// Checkbox 文本
  Widget? title;

  /// 提示文本
  String? placeholder;

  /// 日期控件 格式化
  String? format;

  /// 下拉项
  List<LabelValue>? options = [];

  /// 在后端返回 的下拉项前，要加的项 （一般 加 all）
  List<LabelValue>? prefixOption;

  /// option 样式
  OptionStyle? optionsStyle;

  /// 当前控件 验证规则配置
  Rule? rules;

  /// 当前控件 错误信息配置
  ErrorInfo? errorInfo;

  /// 当某一规则校验不通过时，是否停止剩下的规则的校验
  bool? validateFirst = true;

  /// 表单联动关系
  List<Hooks>? hooks;

  /// 是否禁用
  bool? disabled = false;
  bool? readOnly = false;

  /// 用于配置[FormField]和[Form] Widget 的自动验证。
  AutovalidateMode? autovalidateMode;

  InputBorder? border;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final TextStyle? floatingLabelStyle;

  /// 下拉项，主 文本 显示颜色
  Color? selectSelectedColor;
  bool? onlyShowLabel;

  ///  input select 等 显示区域 padding
  EdgeInsetsGeometry? padding;

  ///  input select 等 显示区域 对齐方式
  AlignmentDirectional? align;

  /// 按钮类型 （单个按钮 Button 用）
  BtnType? btnType;

  /// 按钮配置 Buttons
  List<Btn> Function(FormFieldState<dynamic>)? btns;

  ///  Buttons rowGap
  double? rowGap = 10;

  ///  Buttons columnGap
  double? columnGap = 10;

  TemplateOptions({
    this.prefix,
    this.suffix,
    this.text,
    this.label,
    this.labelText,
    this.colon,
    this.title,
    this.placeholder,
    this.format,
    this.options,
    this.prefixOption,
    this.optionsStyle,
    this.rules,
    this.errorInfo,
    this.validateFirst,
    this.hooks,
    this.disabled,
    this.readOnly,
    this.autovalidateMode,
    this.border = const OutlineInputBorder(),
    this.floatingLabelBehavior,
    this.floatingLabelAlignment,
    this.floatingLabelStyle,
    this.onlyShowLabel,
    this.selectSelectedColor,
    this.padding,
    this.align,
    this.btnType,
    this.btns,
    this.rowGap = 10,
    this.columnGap = 10,
  });
}
