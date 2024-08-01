// ignore_for_file: type_literal_in_constant_pattern

part of '../render.dart';

/// 处理所有组件 事件
///
Future<dynamic> handleEvents(Widget c, RenderProps props) async {
  switch (c.runtimeType) {
    case BForm:
      // (c as BForm).key = key;
      break;
    case Btn:
      c as Btn;
      c.onFocusChange = (bool b) => btnFocusChange(props, c, b);
      c.onHover = (bool b) => btnHover(props, c, b);
      c.onLongPress = () => btnLongPress(props, c);
      c.onPressed = () => btnPressed(props, c);
      break;
    case DataGrid:
      c as DataGrid;
      c.onPageChange = (int i) => dataGridPageChange(props, c, i);
      c.onImageEditingComplete = (Uint8List bts, PlutoColumnRendererContext ctx) => dataGridImageEditingComplete(props, c, bts, ctx);
      break;
  }
}
