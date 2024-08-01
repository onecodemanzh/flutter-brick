// ignore_for_file: type_literal_in_constant_pattern

part of '../render.dart';

Future<dynamic> handleAfter({
  required RenderProps props,
  Widget? c,
  ApiMap? afterName,
}) async {
  List<ApiResultMap> arr = getAfter(props, afterName);
  for (var x in arr) {
    switch (x.fn) {
      case Fn.submitForm:
        submitForm(props, c as Btn, x);
        break;
      case Fn.setValue:
        break;
      case Fn.initStore:
        break;
      case Fn.BuildId_change_refresh_Map:
        break;
      case Fn.refresh_Map:
        break;
      case Fn.array_exclude:
        break;
      case Fn.clearUrlQuery:
        break;
      case Fn.batchDownload:
        break;
      case Fn.selectCurrentRow:
        break;
      case Fn.patchValue_model:
        break;
      case Fn.patchValue_model_submission:
        break;
      case Fn.upload:
        break;
      case Fn.setSelectOptionsByMap:
        break;
      case Fn.setColumn:
        break;
      case Fn.setSelectOptions:
        break;
      case Fn.setSelectOptions_List:
        break;
      case Fn.setSelectOptions_List_Form:
        break;
      case Fn.search_then_getList:
        break;
      case Fn.clearSelect:
        break;
      case Fn.Return:
        break;
      case Fn.init:
        break;
      case Fn.getList:
        getList(props, c as Btn, x);
        break;
      case Fn.filter:
        break;
      case Fn.add:
        break;
      case Fn.getRow:
        break;
      case Fn.getRow_form:
        break;
      case Fn.resetForm:
        resetForm(props, c as Btn, x);
        break;
      case Fn.remove_selected_row:
        break;
      case Fn.import:
        break;
      case Fn.importExcel:
        break;
      case Fn.getDocumentList:
        break;
      case Fn.getFormFields:
        break;
      case Fn.download:
        break;
      case Fn.keepValue:
        break;
      case Fn.updateSubConPermission:
        break;
      case Fn.setList:
        break;
      case Fn.cellClickedJump:
        break;
      case Fn.setListFieldEmpty:
        break;
      case Fn.setPagination:
        break;
      case Fn.setBaseMap:
        break;
      case Fn.set_UserInfo_and_Login:
        break;
      case Fn.login:
        break;
      case Fn.save:
        break;
      case Fn.closeModal:
        break;
      case Fn.filter_GroupType:
        break;
      case Fn.add_level_list:
        break;
      case Fn.add_list:
        break;
      case Fn.getInitPreset:
        break;
      case Fn.setFormEnabledAndDisabled:
        break;
      case Fn.patchValue_model_photoList:
        break;
      case Fn.generate:
        break;
      case Fn.clearUserData_selectnode:
        break;
      case Fn.validateForm:
        break;
      case Fn.initMap:
        break;
      case Fn.setBtnDisabled:
        break;
    }
  }
  return;
}
