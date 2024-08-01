// ignore_for_file: type_literal_in_constant_pattern

part of '../render.dart';

class RenderController extends _get.GetxController {
  final componentRefs = _get.RxMap<String, Refs>({});
  @override
  void onInit() {
    super.onInit();
    debugPrint('render onInit');
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('render onReady');
  }

  @override
  void onClose() {
    debugPrint('render onClose');
    super.onClose();
  }

  /// 给每个组件 加个GlobalKey
  ///
  /// 然后，把key注册到服务里。
  ///
  /// 再返回 加工后的组件
  List<Widget> getComponts(RenderProps props) {
    List<Widget> arr = [];
    for (var x in props.components) {
      Key key = GlobalKey();
      dynamic a = x;

      /// 处理所有组件事件
      handleEvents(x, props);
      switch (x.runtimeType) {
        case BForm:
          key = GlobalKey<BFormState>();
          (x as BForm).key = key as GlobalKey<BFormState>;
          break;
        case DataGrid:
          key = GlobalKey<DataGridState>();
          (x as DataGrid).key = key as GlobalKey<DataGridState>;
          break;
        case Btn:
          key = GlobalKey();
          (x as Btn).key = key;
          break;
      }
      componentRefs.addAll({
        a.ref.toString(): Refs(c: x, key: key),
      });
      arr.add(x);
    }
    return arr;
  }

  List<Widget> getBody(List<BRow> body, List<Widget> components,
      {List<Widget> arr = const []}) {
    List<Widget> arr = [];
    for (var row in body) {
      for (var col in row.children) {
        if (col.child != null && col.child.runtimeType == BRow) {
          getBody([col.child as BRow], components);
        } else {
          if (col.childRef != null) {
            var a = components
                .firstWhere((dynamic element) => element.ref == col.childRef);
            col.child = a;
          } else {
            // col;
          }
        }
      }

      arr.add(row);
    }
    // // console.debugger();

    return arr;
  }

  /// -------------------------------

  List<Widget> render({
    required BuildContext context,
    required BoxConstraints constraints,
    required ScreenData screenData,
    required RenderProps props,
    required Render that,
  }) {
    var components = getComponts(props);
    var body = getBody(props.body, components);
    // console.debugger();

    return body;
    // return props.body
    //     .map((g) => )
    //     .toList();
  }
}
