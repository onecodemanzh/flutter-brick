// ignore_for_file: curly_braces_in_flow_control_structures, unused_local_variable
part of form;

dynamic onChanged =
    (value, FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  formKey.currentState?.save();
  if (that.onChanged != null)
    that.onChanged!(FormChangeEvent(
        name: x.name,
        model: formKey.currentState!.value,
        value: value,
        formKey: formKey));
};
dynamic valueTransformer =
    (value, FieldConfig x, GlobalKey<FormBuilderState> formKey) {};
// ignore: non_constant_identifier_names
dynamic valueTransformer_Date =
    (DateTime value, FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  // return intl.DateFormat('M/d/y').toString();
};
// // ignore: non_constant_identifier_names

/// 获取指定格式化的字符串
String getDateTimeFormat(DateTime value, [String format = 'M/d/y']) {
  return intl.DateFormat(format).format(value);
}

dynamic onReset = () {};

TextStyle handleTextStyle(FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  Color? color;
  if (x.to.onlyShowLabel == true) {
    // color = const Color(0xff1677FF);
  }
  var style = TextStyle(
    fontSize: 12,
    color: color,
    overflow: TextOverflow.ellipsis,
  );
  return style;
}

/// 表单输入框样式设置
InputDecoration handleInputDecoration(
    FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  late InputDecoration el;
  Widget? label;
  String? labelText;
  EdgeInsetsGeometry? padding = x.to.padding ?? formInputPadding;
  if (x.to.onlyShowLabel == true) {
    if (x.to.label != null) {
      label = x.to.label;
    } else {
      label = Text(x.to.labelText ?? "",
          style: const TextStyle(
            fontSize: 12,
          ));
    }
    labelText = null;
  } else {
    if (x.to.label != null) {
      labelText = null;
      label = x.to.label;
    } else {
      labelText = x.to.labelText;
    }
  }
  el = InputDecoration(
    // label: label,
    // labelText: labelText,
    hintText: x.to.placeholder ?? '',
    floatingLabelBehavior:
        x.to.floatingLabelBehavior ?? FloatingLabelBehavior.never,
    floatingLabelStyle: x.to.floatingLabelStyle,
    floatingLabelAlignment: x.to.floatingLabelAlignment,
    // hintStyle: const TextStyle(fontSize: 10.0),
    // errorStyle: const TextStyle(fontSize: 10.0),
    // helperStyle: const TextStyle(fontSize: 10.0),
    //   this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    // this.floatingLabelAlignment = FloatingLabelAlignment.start,
    border: x.to.border ?? formBorder,
    focusedBorder: formFocusedBorder,
    errorBorder: formErrorBorder,
    focusedErrorBorder: formFocusedBorder,
    disabledBorder: formDisabledBorder,
    enabledBorder: formEnabledBorder,
    isCollapsed: true,
    isDense: true,
    enabled: x.to.disabled != true,
    contentPadding: padding,
  );
  return el;
}

/// Checkbox样式设置
InputDecoration handleCheckboxDecoration(
    FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  late InputDecoration el;
  Widget? label;
  String? labelText;
  EdgeInsetsGeometry? padding = x.to.padding ?? formInputPadding;
  if (x.to.onlyShowLabel == true) {
    if (x.to.label != null) {
      label = x.to.label;
    } else {
      label = Text(x.to.labelText ?? "",
          style: const TextStyle(
            fontSize: 14,
          ));
    }
    labelText = null;
  } else {
    if (x.to.label != null) {
      labelText = null;
      label = x.to.label;
    } else {
      labelText = x.to.labelText;
    }
  }
  el = InputDecoration(
    label: label,
    labelText: labelText,
    hintText: x.to.placeholder ?? '',
    // floatingLabelBehavior:
    //     x.to.floatingLabelBehavior ?? FloatingLabelBehavior.never,
    // floatingLabelStyle: x.to.floatingLabelStyle,
    // floatingLabelAlignment: x.to.floatingLabelAlignment,
    //   this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    // this.floatingLabelAlignment = FloatingLabelAlignment.start,
    border: InputBorder.none,
    // focusedBorder: formFocusedBorder,
    // errorBorder: formErrorBorder,
    // focusedErrorBorder: formFocusedBorder,
    // disabledBorder: formDisabledBorder,
    // enabledBorder: formEnabledBorder,
    enabled: x.to.disabled != true,
    isCollapsed: true,
    // isDense: true,
    // contentPadding: padding,
  );
  return el;
}

/// 表单输入框样式设置
InputDecoration handleGroupDecoration(
    FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  late InputDecoration el;
  Widget? label;
  String? labelText;
  EdgeInsetsGeometry? padding = x.to.padding ?? formInputPadding;
  if (x.to.onlyShowLabel == true) {
    if (x.to.label != null) {
      label = x.to.label;
    } else {
      label = Text(x.to.labelText ?? "",
          style: const TextStyle(
            fontSize: 12,
          ));
    }
    labelText = null;
  } else {
    if (x.to.label != null) {
      labelText = null;
      label = x.to.label;
    } else {
      labelText = x.to.labelText;
    }
  }
  el = InputDecoration(
    label: label,
    // labelText: labelText,
    // hintText: x.to.placeholder ?? '',
    // floatingLabelBehavior:
    //     x.to.floatingLabelBehavior ?? FloatingLabelBehavior.never,
    // floatingLabelStyle: x.to.floatingLabelStyle,
    // floatingLabelAlignment: x.to.floatingLabelAlignment,
    // hintStyle: const TextStyle(fontSize: 10.0),
    // errorStyle: const TextStyle(fontSize: 10.0),
    // helperStyle: const TextStyle(fontSize: 10.0),
    //   this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    // this.floatingLabelAlignment = FloatingLabelAlignment.start,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    isCollapsed: true,
    isDense: true,
    enabled: x.to.disabled != true,
    // contentPadding: padding,
  );
  return el;
}

List<DropdownMenuItem<dynamic>> handleOptions(
    FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  List<LabelValue> opt = x.to.options ?? [];
  opt.insertAll(0, x.to.prefixOption ?? []);
  bool enabled = true;
  if (x.to.onlyShowLabel == true) {
    enabled = false;
  }
  List<LabelValue> options = opt;
  return options.map((gender) {
    Widget child = Text(gender.label);
    var item = DropdownMenuItem(
      enabled: enabled,
      alignment:
          x.to.optionsStyle?.alignment ?? AlignmentDirectional.centerStart,
      value: gender.value,
      child: x.to.optionsStyle?.child != null
          ? x.to.optionsStyle!.child!(gender)
          : child,
    );
    return item;
  }).toList();
}

Widget handleCheckboxTitle(FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  if (x.to.title != null) {
    return x.to.title ?? const Text("");
  } else {
    return Text(x.to.text ?? "");
  }
}

AutovalidateMode handleAutoValidateMode(
    FieldConfig x, GlobalKey<FormBuilderState> formKey) {
  return x.to.autovalidateMode ?? AutovalidateMode.onUserInteraction;
}
