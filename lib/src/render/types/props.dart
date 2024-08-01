part of '../render.dart';

/// render组件 渲染时，要用的参数
class RenderProps {
  /// 布局
  final List<BRow> body;

  /// 要渲染的组件
  final List<Widget> components;

  /// 页面配置
  final PageConfig pageConfig;

  /// http api 配置
  final Https http;

  /// http 参数映射
  final HttpParamsMap httpParamsMap;

  /// http 结果映射
  final HttpResultMap? httpResultMap;

  /// 下拉项 映射
  final List<SelectMap> selectMap;

  RenderProps({
    required this.body,
    required this.components,
    required this.pageConfig,
    required this.http,
    required this.httpParamsMap,
    this.httpResultMap,
    this.selectMap = const <SelectMap>[],
  });
}
