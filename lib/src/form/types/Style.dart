// ignore_for_file: file_names
part of form;

/// option 样式
///
/// alignment option item 对齐方式 [AlignmentDirectional]
class OptionStyle {
  // option item 对齐方式
  AlignmentDirectional? alignment;

  /// option item 要显示的 Widget （一般是Text）
  ///
  /// 默认 Text(gender.label)
  Widget Function(LabelValue value)? child;
  OptionStyle({
    this.alignment,
    this.child,
  });
}
