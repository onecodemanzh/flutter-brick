part of form;

BRow renderGroup({
  required FieldGroup g,
  formKey,
  required BForm that,
  required BoxConstraints constraints,
  required ScreenData screenData,
  required BuildContext context,
}) {
  var children = g.children.map((x) {
    // var styles = _convertClassNamesToStyle(x.classNames ?? '');
    // var s = getStyle(screenData, constraints, styles);
    return BCol(
      classNames: x.span,
      child: renderFormItem(
        x: x,
        el: renderComponents(x, formKey, that),
        constraints: constraints,
        screenData: screenData,
        context: context,
      ),
    );
  });
  return BRow(
    classNames: 'gc-$formItemColumnGap gr-$formItemRowGap ${g.classNames}',
    children: children.toList(),
  );
}

Widget renderFormItem(
    {required FieldConfig x,
    required Widget el,
    required BoxConstraints constraints,
    required ScreenData screenData,
    required BuildContext context}) {
  // var styles = _convertClassNamesToStyle(x.classNames ?? '');
  // var s = getStyle(screenData, constraints, styles);
  if (x.to.label == null && x.to.labelText == null) {
    return el;
  }
  final label = Stack(
      // textDirection: TextDirection.ltr,
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        /// 框
        Padding(
          /// label 标签 高度
          padding: EdgeInsets.only(top: formLabelHeight),
          child: el,
        ),

        /// label 标签
        Positioned(
          top: 15 - formLabelSpace,
          left: formLabelLeftPadding,
          child: SelectableText(
            (x.to.labelText ?? '').tr,
            style: TextStyle(
              color: formLabelColor,
              fontSize: formLabelFontSize,
              fontFamily: formLabelFontFamily,
              fontWeight: formLabelFontWeight,
            ),
          ),
        ),
      ]);
  return label;
}

Widget renderComponents(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  late Widget el;
  switch (x.type) {
    case FieldType.array:
      el = render_button(x, formKey, that);
      break;
    case FieldType.button:
      el = render_button(x, formKey, that);
      break;
    case FieldType.buttons:
      el = render_buttons(x, formKey, that);
      break;
    case FieldType.checkbox:
      el = render_checkbox(x, formKey, that);
      break;
    case FieldType.checkboxButtonGroup:
      el = render_checkboxButtonGroup(x, formKey, that);
      break;
    case FieldType.checkboxGroup:
      el = render_checkboxGroup(x, formKey, that);
      break;
    case FieldType.datePicker:
      el = render_datePicker(x, formKey, that);
      break;
    case FieldType.dateRangePicker:
      el = render_dateRangePicker(x, formKey, that);
      break;
    case FieldType.dateShow:
      el = render_dateShow(x, formKey, that);
      break;
    case FieldType.dropdown:
      el = render_dropdown(x, formKey, that);
      break;
    case FieldType.form:
      el = render_form(x, formKey, that);
      break;
    case FieldType.input:
      el = render_input(x, formKey, that);
      break;
    case FieldType.inputNumber:
      el = render_inputNumber(x, formKey, that);
      break;
    case FieldType.inputSearch:
      el = render_inputSearch(x, formKey, that);
      break;
    case FieldType.password:
      el = render_password(x, formKey, that);
      break;
    case FieldType.radio:
      el = render_radio(x, formKey, that);
      break;
    case FieldType.radioGroup:
      el = render_radioGroup(x, formKey, that);
      break;
    case FieldType.rangeSlider:
      el = render_rangeSlider(x, formKey, that);
      break;
    case FieldType.rate:
      el = render_rate(x, formKey, that);
      break;
    case FieldType.responseText:
      el = render_responseText(x, formKey, that);
      break;
    case FieldType.select:
      el = render_select(x, formKey, that);
      break;
    case FieldType.slider:
      el = render_slider(x, formKey, that);
      break;
    case FieldType.Switch:
      el = render_switch(x, formKey, that);
      break;
    case FieldType.choiceChip:
      el = render_choiceChip(x, formKey, that);
      break;
    case FieldType.filterChip:
      el = render_filterChip(x, formKey, that);
      break;
    case FieldType.text:
      el = render_text(x, formKey, that);
      break;
    case FieldType.textArea:
      el = render_textArea(x, formKey, that);
      break;
    case FieldType.timePicker:
      el = render_timePicker(x, formKey, that);
      break;
    case FieldType.upload:
      el = render_upload(x, formKey, that);
      break;
    default:
      el = render_input(x, formKey, that);
      break;
  }
  return el;
}
