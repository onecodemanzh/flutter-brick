part of '../render.dart';

Future<bool> list_onImageEditingComplete(RenderProps props, DataGrid c,
    Uint8List bts, PlutoColumnRendererContext ctx) async {
  final row = ctx.cell.row;
  final ID = row.cells['ID']!.value;
  dio.FormData formData = dio.FormData.fromMap({
    'fileName': ctx.cell.value,
    'ID': ID,
    'file': base64Encode(bts),
  });
  ctx;
  // ctx.row.state['ID'];
  await props.http.listImageEdit!(formData).then((value) {
    // final Map<String, dynamic> v = value as Map<String, dynamic>;
    // final List<dynamic> arr = v['data'];
    // final total = v['total'];
    // final currentPage = v['currentPage'];
    // final size = v['pageSize'];
    // paginationKey?.currentState?.reset(
    //   total: total,
    //   current: currentPage,
    //   size: size,
    // );
    // // print(t.key);
    // // console.debugger();
    // c.key?.currentState!.controller
    //     .setRowData(arr, c.key!.currentState!.stateManager);
    return true;
  });
  return false;
}
