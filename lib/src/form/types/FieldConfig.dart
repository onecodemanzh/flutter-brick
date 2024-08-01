// ignore_for_file: file_names
part of form;

// import '../../../../app/types/form/templateOptions.dart';

/// key  标识符 [Key]
///
/// type 字段类型 enum [FieldType];
///
/// name 绑定到表单中的关键字
///
/// value 默认值
///
/// to 配置规范 [TemplateOptions]
///
/// fieldArray [List] [FieldConfig] 子表单数组  type = Array 时用。
class FieldConfig {
  /// key  标识符 [Key]
  Key? key = GlobalKey();

  /// type 字段类型 enum [FieldType];
  FieldType type;

  ///  绑定到表单中的关键字
  String name;

  ///  默认值
  dynamic value;

  /// 配置规范
  TemplateOptions to;

  /// 子表单数组
  ///
  /// type = Array 时用。
  List<FieldConfig>? fieldArray;

  /// 表单项栅格的className
  String? span;

  /// 表单项的className
  String? classNames;

  FieldConfig({
    this.key,
    required this.name,
    required this.type,
    required this.to,
    this.value,
    this.span,
    this.classNames,
  });
}

class FieldGroup {
  String? classNames;
  List<FieldConfig> children = [];
  FieldGroup({
    this.classNames,
    required this.children,
  });
}
