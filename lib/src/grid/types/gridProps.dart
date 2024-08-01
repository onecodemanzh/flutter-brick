// ignore_for_file: non_constant_identifier_names

part of '../dataGrid.dart';

class GridProps {
  /// 表格高度 默认400
  double height;

  /// 列定义 列表
  List<ColumnDef> columns;

  /// 列分组 列表
  List<PlutoColumnGroup>? columnGroups;

  /// 数据 列表
  List<Map<String, dynamic>> rowData;

  /// 加载完成 生命周期钩子
  void Function(PlutoGridOnLoadedEvent)? onLoaded;

  /// 数据改变 生命周期钩子
  void Function(PlutoGridOnChangedEvent)? onChanged;

  /// 配置
  PlutoGridConfiguration config;

  final bool showPagination;
  Pagination pagination;
  GridProps._({
    required this.height,
    required this.columns,
    this.columnGroups,
    this.rowData = const [],
    this.config = const PlutoGridConfiguration(),
    this.showPagination = false,
    required this.pagination,
    this.onLoaded,
    this.onChanged,
  });
  factory GridProps({
    double height = 400,
    required List<ColumnDef> columns,
    List<PlutoColumnGroup>? columnGroups,
    List<Map<String, dynamic>> rowData = const [],
    PlutoGridConfiguration config = const PlutoGridConfiguration(),
    bool showPagination = false,
    Pagination? pagination,
    void Function(PlutoGridOnLoadedEvent)? onLoaded,
    void Function(PlutoGridOnChangedEvent)? onChanged,
  }) {
    pagination ??= Pagination(
      key: GlobalKey<PaginationState>(),
      total: 0,
      pageSize: 20,
      showTotal: false,
    );
    return GridProps._(
      height: height,
      columns: columns,
      columnGroups: columnGroups,
      rowData: rowData,
      config: config,
      showPagination: showPagination,
      pagination: pagination,
      onLoaded: onLoaded,
      onChanged: onChanged,
    );
  }
}
