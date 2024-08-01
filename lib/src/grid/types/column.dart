// ignore_for_file: non_constant_identifier_names

part of '../dataGrid.dart';

/// 表格 列定义
class ColumnDef {
  /// 列标题
  String headerName;

  /// 列绑定的字段
  String field;

  /// 列类型
  ColumnType type;

  /// 是否开启 图片编辑器 (当[type] = [ColumnType.photo], 是否开启 图片编辑功能)
  final bool? enabled_imgEditor;

  /// 是否开启 图片编辑器 画笔 功能
  final bool? enabled_imgEditor_paint;

  /// 是否开启 图片编辑器 文字输入 功能
  final bool? enabled_imgEditor_text;

  /// 是否开启 图片编辑器 裁剪和旋转 功能
  final bool? enabled_imgEditor_cropRotate;

  /// 是否开启 图片编辑器 滤镜 功能
  final bool? enabled_imgEditor_filter;

  /// 是否开启 图片编辑器 高斯模糊 功能
  final bool? enabled_imgEditor_blur;

  /// 是否开启 图片编辑器 表情 功能
  final bool? enabled_imgEditor_emoji;
  ColumnDef({
    required this.headerName,
    required this.field,
    this.type = ColumnType.text,
    this.enabled_imgEditor = false,
    this.enabled_imgEditor_paint = true,
    this.enabled_imgEditor_text = true,
    this.enabled_imgEditor_cropRotate = false,
    this.enabled_imgEditor_filter = false,
    this.enabled_imgEditor_blur = false,
    this.enabled_imgEditor_emoji = false,
  });
}

enum ColumnType {
  text,
  number,
  currency,
  select,
  date,
  time,
  photo,
  input,
}
