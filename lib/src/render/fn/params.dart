part of '../render.dart';

dynamic getBeforeAfterParams() {
  ;
}

List<ApiResultMap> getAfter(
  RenderProps props,
  ApiMap? afterName,
) {
  var after = props.pageConfig.apiAfter;
  if (after.containsKey(afterName)) {
    return after[afterName] ?? [];
  }
  return [];
}
