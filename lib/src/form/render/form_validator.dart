// ignore_for_file: curly_braces_in_flow_control_structures
part of form;

List<String? Function(String?)> Function(
        FieldConfig, GlobalKey<FormBuilderState>) validator =
    (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(String?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equal != null) {
    var value = formKey.currentState?.fields[x.to.rules?.equal]?.value;
    print(value);
    if (value != null) {
      list.add(FormBuilderValidators.equal(x.to.rules?.equal ?? ''));
    }
  }
  if (x.to.rules?.notEqual != null) {
    var value = formKey.currentState!.fields[x.to.rules?.notEqual]!.value;
    if (value) {
      list.add(FormBuilderValidators.notEqual(value));
    }
  }
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));
  if (x.to.rules?.minWordsCount != null)
    list.add(
        FormBuilderValidators.minWordsCount(x.to.rules?.minWordsCount ?? 0));
  if (x.to.rules?.maxWordsCount != null)
    list.add(
        FormBuilderValidators.maxWordsCount(x.to.rules?.maxWordsCount ?? 0));
  if (x.to.rules?.email != null) list.add(FormBuilderValidators.email());
  if (x.to.rules?.url != null) list.add(FormBuilderValidators.url());
  if (x.to.rules?.match != null)
    list.add(FormBuilderValidators.match(x.to.rules?.match ?? ''));
  if (x.to.rules?.numeric == true) list.add(FormBuilderValidators.numeric());
  if (x.to.rules?.integer == true) list.add(FormBuilderValidators.integer());
  if (x.to.rules?.creditCard == true)
    list.add(FormBuilderValidators.creditCard());
  if (x.to.rules?.ip == true) list.add(FormBuilderValidators.ip());
  if (x.to.rules?.dateString == true)
    list.add(FormBuilderValidators.dateString());
  return list;
  // return FormBuilderValidators.compose(list);
};

List<String? Function(List<String>?)> Function(
        FieldConfig, GlobalKey<FormBuilderState>) validator1 =
    (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(List<String>?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));

  return list;
  // return FormBuilderValidators.compose(list);
};
List<String? Function(bool?)> Function(FieldConfig, GlobalKey<FormBuilderState>)
    validator2 = (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(bool?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.equal != null) {
    // var value = formKey.currentState!.fields[x.to.rules?.equal]!.value;
    // print(value);
    // if (value) {}
    list.add(FormBuilderValidators.equal(
      x.to.rules?.equal ?? '',
      errorText: 'You must accept terms and conditions to continue',
    ));
  }
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));

  return list;
  // return FormBuilderValidators.compose(list);
};

List<String? Function(Object?)> Function(
        FieldConfig, GlobalKey<FormBuilderState>) validator3 =
    (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(Object?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.equal != null) {
    // var value = formKey.currentState!.fields[x.to.rules?.equal]!.value;
    // print(value);
    // if (value) {}
    list.add(FormBuilderValidators.equal(
      x.to.rules?.equal ?? '',
      errorText: 'You must accept terms and conditions to continue',
    ));
  }
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));

  return list;
  // return FormBuilderValidators.compose(list);
};

List<String? Function(DateTime?)> Function(
        FieldConfig, GlobalKey<FormBuilderState>) validator4 =
    (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(Object?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.equal != null) {
    // var value = formKey.currentState!.fields[x.to.rules?.equal]!.value;
    // print(value);
    // if (value) {}
    list.add(FormBuilderValidators.equal(
      x.to.rules?.equal ?? '',
      errorText: 'You must accept terms and conditions to continue',
    ));
  }
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));

  return list;
  // return FormBuilderValidators.compose(list);
};

List<String? Function(DateTimeRange?)> Function(
        FieldConfig, GlobalKey<FormBuilderState>) validator5 =
    (FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<String? Function(Object?)> list = [];
  if (x.to.rules?.required == true) list.add(FormBuilderValidators.required());
  if (x.to.rules?.equal != null) {
    // var value = formKey.currentState!.fields[x.to.rules?.equal]!.value;
    // print(value);
    // if (value) {}
    list.add(FormBuilderValidators.equal(
      x.to.rules?.equal ?? '',
      errorText: 'You must accept terms and conditions to continue',
    ));
  }
  if (x.to.rules?.min != null)
    list.add(FormBuilderValidators.min(x.to.rules?.min ?? 0));
  if (x.to.rules?.max != null)
    list.add(FormBuilderValidators.max(x.to.rules?.max ?? 0));
  if (x.to.rules?.minLength != null)
    list.add(FormBuilderValidators.minLength(x.to.rules?.minLength ?? 0));
  if (x.to.rules?.maxLength != null)
    list.add(FormBuilderValidators.maxLength(x.to.rules?.maxLength ?? 0));
  if (x.to.rules?.equalLength != null)
    list.add(FormBuilderValidators.equalLength(x.to.rules?.equalLength ?? 0));

  return list;
  // return FormBuilderValidators.compose(list);
};
