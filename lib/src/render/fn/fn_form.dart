part of '../render.dart';

/// 提交表单
Future<bool> submitForm(RenderProps props, Btn c, ApiResultMap x) async {
  if (x.triggerRef == c.ref) {
    var t = props.components
        .firstWhere((dynamic element) => element.ref == x.targetRef);
    if (t is BForm) {
      if (t.key != null) {
        t.key?.currentState!.formKey.currentState?.saveAndValidate();
        return false;
      }
    }
  }
  return true;
}

/// 重置表单
Future<bool> resetForm(RenderProps props, Btn c, ApiResultMap x) async {
  if (x.triggerRef == c.ref) {
    var t = props.components
        .firstWhere((dynamic element) => element.ref == x.targetRef);
    if (t is BForm) {
      if (t.key != null) {
        t.key?.currentState!.formKey.currentState?.reset();
        return true;
      }
    }
  }
  return false;
}
