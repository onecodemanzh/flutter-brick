// ignore_for_file: file_names
part of form;

/// 表单验证规则
///
/// max [int]
///
/// min [int]
///
/// maxLength [int]
///
/// minLength [int]
///
/// pattern [RegExp]
///
/// required  [bool]
class Rule {
  bool? required;

  /// 目标字段
  dynamic equal;

  /// 目标字段
  String? notEqual;
  int? min;
  int? max;
  int? minLength;
  int? maxLength;
  int? equalLength;
  int? minWordsCount;
  int? maxWordsCount;
  String? email;
  String? url;
  String? match;
  bool? numeric;
  bool? integer;
  bool? creditCard;
  bool? ip;
  bool? dateString;

  /* 
    requiredErrorText
     */
  Rule({
    this.required,
    this.equal,
    this.notEqual,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.equalLength,
    this.minWordsCount,
    this.maxWordsCount,
    this.email,
    this.url,
    this.match,
    this.numeric,
    this.integer,
    this.creditCard,
    this.ip,
    this.dateString,
  });
}

/// 错误信息
///
/// errorText [Text] 根据规则计算出的来的文字
///
/// importantErrorText [Text]  错误文本 比 errorText 权重高
///
/// showErrorTooltip [bool] 显示错误提示
class ErrorInfo {
  /// 根据规则计算出的来的文字
  Text? errorText;

  /// 错误文本 比 errorText 权重高
  Text? importantErrorText;

  /// 显示错误提示
  bool? showErrorTooltip;
  ErrorInfo(
    this.errorText,
    this.importantErrorText,
    this.showErrorTooltip,
  );
}
