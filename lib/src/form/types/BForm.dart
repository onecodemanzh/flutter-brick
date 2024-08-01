// ignore_for_file: file_names
part of form;

/// Key [Key]
///
/// fields  [List] [FieldConfig]  表单字段配置
///
/// model [dynamic] 表单 value 绑定对象
///
/// colon [bool]  是否显示 label 后面的冒号
///
/// layout  [FormLayout]  表单项 布局（[FormLayout.vertical] | [FormLayout.inline]）
///
/// labelWidth  [int] label width([FormLayout.inline] 时才用)
///
/// hideFormItemBorder  [bool] 隐藏 表单项 边框
///
/// showRequire [bool]  是否显示必填（表单验证不通过时，表单项边框是否显示红色）
///
/// disabled  [bool]  是否禁用
///
/// canNew  [bool]  表单内new按钮能否点击
///
/// canDelete [bool]  表单内save delete按钮能否点击
///
/// size  [FormSize]  表单项大小 [FormSize.small] [FormSize.middle] [FormSize.large]
///
/// child [Widget]  默认插槽
///
/// columnSizes 列宽度配置 [List] [TrackSize] 参照 css grid-template-columns）
///
/// rowSizes  行高度配置 [List] [TrackSize] 参照 css grid-template-rows
///
/// columnGap 列间距  [double] (参照 css grid-column-gap)
///
/// rowGap  行间距  [double] (参照 css grid-row-gap)
///
/// areas [String] 定义网格的命名区域，用于按名称放置网格项。
///
/// responsiveLayout [ResponsiveLayout]  响应式布局
class BFormProps {
  /// key  标识符 [Key]
  Key? key;

  /// 表单字段配置
  List<FieldGroup> fields = List.empty();

  /// 表单 value 绑定对象
  dynamic model = Object();

  /// 是否显示 label 后面的冒号
  bool? colon;

  /// 表单项 布局（[FormLayout.vertical] | [FormLayout.inline]）
  FormLayout? layout = FormLayout.vertical;

  /// label width([FormLayout.inline] 时才用)
  int? labelWidth;

  /// 隐藏 表单项 边框
  bool? hideFormItemBorder;

  /// 是否显示必填（表单验证不通过时，表单项边框是否显示红色）
  bool? showRequire;

  ///  是否禁用
  bool? disabled;

  ///  表单内new按钮能否点击
  bool? canNew;

  ///  表单内save delete按钮能否点击
  bool? canDelete;

  ///  表单项大小 [FormSize.small] [FormSize.middle] [FormSize.large]
  FormSize? size = FormSize.middle;

  ///  默认插槽
  Widget? child;

  /// 列间距  (参照 css grid-column-gap)
  double? columnGap = 20;

  /// 行间距   (参照 css grid-row-gap)
  double? rowGap = 6;

  /// 响应式布局

  BFormProps({
    this.key,
    required this.fields,
    this.columnGap,
    this.rowGap,
    this.model,
    this.colon,
    this.layout,
    this.labelWidth,
    this.hideFormItemBorder,
    this.showRequire,
    this.disabled,
    this.canNew,
    this.canDelete,
    this.size,
    this.child,
  });
}

class LabelValue {
  String label;
  dynamic value;
  LabelValue({required this.label, this.value});

  map(FormBuilderChipOption<Null> Function(dynamic o) param0) {}
}

enum FormLayout {
  vertical,
  inline,
}

enum FormSize {
  small,
  middle,
  large,
}
