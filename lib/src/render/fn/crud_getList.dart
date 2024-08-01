// ignore_for_file: type_literal_in_constant_pattern

part of '../render.dart';

/// getList
Future<bool> getList(RenderProps props, Btn c, ApiResultMap x) async {
  if (x.triggerRef == c.ref) {
    var t = props.components
        .firstWhere((dynamic element) => element.ref == x.targetRef);
    if (t is DataGrid) {
      if (t.key != null) {
        GlobalKey<PaginationState>? paginationKey =
            t.key!.currentState!.pagination.key;
        var pageSize = paginationKey?.currentState?.pageSize;
        var currentPageIndex = paginationKey?.currentState?.currentPageIndex;
        props
            .http
            .getList!({
          'pageSize': pageSize,
          'currentPage': (currentPageIndex ?? 0) + 1
        })
            .then((value) {
          final Map<String, dynamic> v = value as Map<String, dynamic>;
          final List<dynamic> arr = v['data'];
          final total = v['total'];
          final currentPage = v['currentPage'];
          final size = v['pageSize'];
          paginationKey?.currentState?.reset(
            total: total,
            current: currentPage,
            size: size,
          );
          // print(t.key);
          // console.debugger();
          t.key?.currentState!.controller
              .setRowData(arr, t.key!.currentState!.stateManager);
          return true;
        });
      }
    }
  }
  return false;
}

Future<bool> getList_onPageChange(RenderProps props, DataGrid c, int i) async {
  GlobalKey<PaginationState>? paginationKey =
      c.key!.currentState!.pagination.key;
  var pageSize = paginationKey?.currentState?.pageSize;
  var currentPageIndex = paginationKey?.currentState?.currentPageIndex;
  await props
      .http
      .getList!
          ({'pageSize': pageSize, 'currentPage': (currentPageIndex ?? 0) + 1})
      .then((value) {
    final Map<String, dynamic> v = value as Map<String, dynamic>;
    final List<dynamic> arr = v['data'];
    final total = v['total'];
    final currentPage = v['currentPage'];
    final size = v['pageSize'];
    paginationKey?.currentState?.reset(
      total: total,
      current: currentPage,
      size: size,
    );
    // print(t.key);
    // console.debugger();
    c.key?.currentState!.controller
        .setRowData(arr, c.key!.currentState!.stateManager);
    return true;
  });
  return false;
}
