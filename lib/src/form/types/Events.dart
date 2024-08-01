// ignore_for_file: file_names
part of form;

interface class FormChangeEvent {
  /// 当前表单 字段名
  String name;

  /// 当前表单 字段名 对应值
  dynamic value;

  /// 当前表单 绑定值 对象
  dynamic model;

  /// 当前表单 GlobalKey
  GlobalKey<FormBuilderState> formKey;

  FormChangeEvent({
    required this.name,
    required this.value,
    required this.model,
    required this.formKey,
  });
}
