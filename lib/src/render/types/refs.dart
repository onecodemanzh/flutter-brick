part of '../render.dart';

/// 组件存储结构定义
class Refs {
  /// 当前组件定义
  dynamic c;

  /// 当前组件GlobalKey
  Key key;
  Refs({
    required this.c,
    required this.key,
  });
}
