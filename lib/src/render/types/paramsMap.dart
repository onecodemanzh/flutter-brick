part of '../render.dart';

/// 参数映射
class ParamsMap {
  /// 映射后的字段名
  final String key;

  /// 目标对象上的映射字段名
  /// [mapKey], [mapKeys], [fixedValue] 3个，只会有一个生效（fixedValue > mapKey > mapKeys）
  final String? mapKey;

  /// 目标对象上的映射字段名
  /// [mapKey], [mapKeys], [fixedValue] 3个，只会有一个生效（fixedValue > mapKey > mapKeys）
  final List<String>? mapKeys;

  /// 固定值
  /// [mapKey], [mapKeys], [fixedValue] 3个，只会有一个生效（fixedValue > mapKey > mapKeys）
  final dynamic fixedValue;

  ParamsMap({
    required this.key,
    this.mapKey,
    this.mapKeys,
    this.fixedValue,
  });
}

/// 下拉项 映射
class SelectMap extends ParamsMap {
  SelectMap({
    required super.key,
  });
}

/// (Api 请求 或 某个操作) 完成后 ，处理结果配置
class ApiResultMap {
  /// 要执行的操作
  final Fn fn;

  /// 目标ref
  String? targetRef;

  /// 源 ref
  String? originRef;

  /// 目标对象ref数组
  String? targetRefs;

  /// 触发 这次操作的 ref
  String? triggerRef;

  /// (Api 请求 或 某个操作) 完成后 ，处理结果配置
  ApiResultMap({
    required this.fn,
    this.targetRef,
    this.originRef,
    this.targetRefs,
    this.triggerRef,
  });
}
