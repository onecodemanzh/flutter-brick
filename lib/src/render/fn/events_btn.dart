part of '../render.dart';

btnFocusChange(RenderProps props, Btn c, bool b) {
  // print('btnFocusChange');
}

btnHover(RenderProps props, Btn c, bool b) {
  // print('btnHover');
}

Future<bool> btnLongPress(RenderProps props, Btn c) async {
  // print('btnLongPress');
  var a = true;
  return a;
}

Future<bool> btnPressed(RenderProps props, Btn c) async {
  var a = true;
  await handleAfter(props: props, c: c, afterName: ApiMap.btnClick);
  return a;
}

Future<bool> dataGridPageChange(RenderProps props, DataGrid c, int i) async {
  var a = true;
  await getList_onPageChange(props, c, i + 1);
  return a;
}

Future<bool> dataGridImageEditingComplete(RenderProps props, DataGrid c,
    Uint8List bts, PlutoColumnRendererContext ctx) async {
  var a = true;
  await list_onImageEditingComplete(props, c, bts, ctx);
  return a;
}
