part of '../render.dart';

// ignore: constant_identifier_names
const EMPTY_ID = '00000000-0000-0000-0000-000000000000';

/// 页面初始 可能要运行的 api
enum BootstrapApi {
  /// 初始化
  init,

  /// 获取表格数据
  getList,

  /// 通过id打开某条记录
  getRow,

  /// 初始化地图
  initMap,
}

class BootstrapConfig {
  /// 页面初始 要调的api
  final BootstrapApi? api;

  /// 调api时，携带的目标组件
  final String? targetRef;

  /// 页面初始 要运行的函数 （fn优先级高，如果同时传了 api, 会忽略api）
  final String? fn;

  BootstrapConfig({
    this.api,
    this.targetRef,
    this.fn,
  });
}

class PageConfig {
  final List<BootstrapConfig>? bootstrap;

  ///  Entity Field name
  final String entityField;

  ///  表单 主键
  final String formPrimaryKey;

  ///  表单 主键 空值
  final String formPrimaryKeyEmptyValue;

  ///  受控的表单字段
  final List<String> controlledFields;

  /// new 操作 ，要设置给表单的对象
  final Map<String, dynamic> newFormObj;

  /// 请求接口前的操作（映射关系）
  final Map<ApiMap, List<ApiResultMap>> apiBefore;

  /// 请求接口后的操作（映射关系）
  final Map<ApiMap, List<ApiResultMap>> apiAfter;

  PageConfig({
    this.bootstrap,
    this.entityField = 'Entity',
    this.formPrimaryKey = 'ID',
    this.formPrimaryKeyEmptyValue = EMPTY_ID,
    this.controlledFields = const [],
    this.newFormObj = const <String, dynamic>{},
    required this.apiBefore,
    required this.apiAfter,
  });
}
