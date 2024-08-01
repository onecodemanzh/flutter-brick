// ignore_for_file: non_constant_identifier_names, sort_child_properties_last
part of form;

Widget render_button(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCustomButtonField el = FormBuilderCustomButtonField(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    field: x,
    enabled: x.to.disabled != true,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_buttons(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCustomButtonsField el = FormBuilderCustomButtonsField(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    field: x,
    enabled: x.to.disabled != true,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_cascader(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_checkbox(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCheckbox el = FormBuilderCheckbox(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // onChanged: _onChanged,
    title: handleCheckboxTitle(x, formKey),
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    validator: FormBuilderValidators.compose(validator2(x, formKey)),
    decoration: handleCheckboxDecoration(x, formKey),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    // validator: FormBuilderValidators.equal(
    //   true,
    //   errorText: 'You must accept terms and conditions to continue',
    // ),
    // subtitle: Text('111'),
  );
  return el;
}

Widget render_checkboxButtonGroup(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_checkboxGroup(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  var el = FormBuilderCheckboxGroup<String>(
    key: x.key,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    // decoration: const InputDecoration(labelText: ''),
    name: x.name,
    // initialValue: const ['Dart'],
    initialValue: x.value,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    options: x.to.options!.map((f) {
      return FormBuilderFieldOption(
        value: '${f.value}',
        child: SelectableText(f.label),
      );
    }).toList(),
    onChanged: (value) => onChanged(value, x, formKey, that),
    validator: FormBuilderValidators.compose(validator1(x, formKey)),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    // separator: const VerticalDivider(
    //   width: 10,
    //   thickness: 5,
    //   color: Colors.red,
    // ),
    // validator: FormBuilderValidators.compose([
    //   FormBuilderValidators.minLength(1),
    //   FormBuilderValidators.maxLength(3),
    // ]),
  );
  return el;
}

Widget render_datePicker(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  var format = intl.DateFormat('M/d/y');
  FormBuilderDateTimePicker el = FormBuilderDateTimePicker(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator4(x, formKey)),
    style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    // valueTransformer: (DateTime? value) => valueTransformer_Date(value, x, formKey),
    format: format,
  );
  return el;
}

Widget render_dateRangePicker(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  var format = intl.DateFormat('M/d/y');
  var firstDate = DateTime(2000);
  var lastDate = DateTime(3000);
  FormBuilderDateRangePicker el = FormBuilderDateRangePicker(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator5(x, formKey)),
    style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    // valueTransformer: (DateTime? value) => valueTransformer_Date(value, x, formKey),
    format: format,
    firstDate: firstDate,
    lastDate: lastDate,
  );
  return el;
}

Widget render_dateShow(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCustomTextField el = FormBuilderCustomTextField(
    key: x.key,
    name: x.name,
    initialValue: x.value != null ? getDateTimeFormat(x.value) : null,
    enabled: x.to.disabled != true,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
  );
  return el;
}

Widget render_dropdown(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  DropdownButtonPro el = const DropdownButtonPro();
  return el;
}

Widget render_dropdownPro(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  DropdownButtonPro el = const DropdownButtonPro();
  return el;
}

Widget render_form(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_input(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderTextField el = FormBuilderTextField(
    key: x.key,
    name: x.name,
    readOnly: x.to.readOnly ?? false,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator(x, formKey)),
    cursorHeight: formInputFontSize + 2.0,
    style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_inputNumber(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_inputSearch(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_password(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderTextField el = FormBuilderTextField(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    readOnly: x.to.readOnly ?? false,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator(x, formKey)),
    cursorHeight: formInputFontSize + 2.0,
    style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    obscureText: true,
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_radio(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  dynamic groupValue = '';
  var el = FormBuilderField(
    name: x.name,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    initialValue: x.value,
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    builder: (FormFieldState<dynamic> field) {
      var btns = [((x.to.options ?? []).first)]
          .map((o) => SizedBox(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Radio(
                      value: o.value,
                      groupValue: groupValue,
                      onChanged: (value) {
                        if (x.to.disabled == true) return;
                        groupValue = o.value;
                        formKey.currentState?.patchValue({
                          x.name: field.value == o.value ? null : o.value,
                        });
                      },
                    ),
                    SelectableText(
                      o.label,
                      onTap: () {
                        if (x.to.disabled == true) return;
                        groupValue = o.value;
                        formKey.currentState?.patchValue({
                          x.name: field.value == o.value ? null : o.value,
                        });
                      },
                    ),
                  ],
                ),
              ))
          .first;
      // var classNames = getLayoutClass(x.classNames ?? '');
      return btns;
    },
  );
  return el;
}

Widget render_radioGroup(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  // dynamic groupValue = '';
  // var el = FormBuilderField(
  //   name: x.name,
  //   validator: FormBuilderValidators.compose(validator3(x, formKey)),
  //   initialValue: x.value,
  //   onChanged: (value) => onChanged(value, x, formKey, that),
  //   valueTransformer: (value) => valueTransformer(value, x, formKey),
  //   builder: (FormFieldState<dynamic> field) {
  //     var btns = ((x.to.options ?? []))
  //         .map((o) => SizedBox(
  //               child: Wrap(
  //                 crossAxisAlignment: WrapCrossAlignment.center,
  //                 children: [
  //                   Radio(
  //                     value: o.value,
  //                     groupValue: groupValue,
  //                     onChanged: (value) {
  //                       if (x.to.disabled == true) return;
  //                       groupValue = o.value;
  //                       formKey.currentState?.patchValue({
  //                         x.name: field.value == o.value ? null : o.value,
  //                       });
  //                     },
  //                   ),
  //                   SelectableText(
  //                     o.label,
  //                     onTap: () {
  //                       if (x.to.disabled == true) return;
  //                       groupValue = o.value;
  //                       formKey.currentState?.patchValue({
  //                         x.name: field.value == o.value ? null : o.value,
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ))
  //         .toList();
  //     // var classNames = getLayoutClass(x.classNames ?? '');

  //     return Wrap(
  //       children: btns,
  //     );
  //   },
  // );
  // return el;
  FormBuilderRadioGroup el = FormBuilderRadioGroup(
    name: x.name,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    initialValue: x.value,
    onChanged: (value) => onChanged(value, x, formKey, that),
    decoration: handleGroupDecoration(x, formKey),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    options: ((x.to.options ?? []))
        .map((o) => FormBuilderFieldOption(
              value: o.value,
              child: Text(o.label),
            ))
        .toList(growable: false),
  );
  return el;
}

Widget render_rate(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCustomRateField el = FormBuilderCustomRateField(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    field: x,
    enabled: x.to.disabled != true,
    formKey: formKey,
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_rangeSlider(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderRangeSlider el = FormBuilderRangeSlider(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    min: 0,
    max: 100,
  );
  return el;
}

Widget render_responseText(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_text(x, formKey, that);
}

Widget render_select(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderDropdown el = FormBuilderDropdown(
    name: x.name,
    key: x.key,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    alignment: AlignmentDirectional.centerEnd,
    style: handleTextStyle(x, formKey),
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    // validator: FormBuilderValidators.compose(validator(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // onReset: () => onReset(x, formKey),
    // valueTransformer: (value) => valueTransformer(value, x, formKey),
    items: handleOptions(x, formKey),
    selectedItemBuilder: (BuildContext ctxt) {
      return x.to.options!.map<Widget>((item) {
        return DropdownMenuItem(
            alignment: x.to.align ?? AlignmentDirectional.centerStart,
            child: Text("${item.label}",
                style:
                    TextStyle(color: x.to.selectSelectedColor ?? Colors.black)),
            value: item.value);
      }).toList();
    },
    // focusColor: Color(0xff1677FF),
  );
  return el;
}

Widget render_slider(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderSlider el = FormBuilderSlider(
    key: x.key,
    name: x.name,
    initialValue: x.value ?? 0,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    min: 0,
    max: 100,
  );

  return el;
}

Widget render_switch(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderSwitch el = FormBuilderSwitch(
    key: x.key,
    name: x.name,
    initialValue: x.value ?? false,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    title: Text('${x.to.text} '),
  );

  return el;
}

Widget render_choiceChip(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderChoiceChip el = FormBuilderChoiceChip(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    spacing: 6,
    options: ((x.to.options ?? []))
        .map((o) => FormBuilderChipOption(
              value: o.value,
              child: Text(o.label),
            ))
        .toList(),
  );

  return el;
}

Widget render_filterChip(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderFilterChip el = FormBuilderFilterChip(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    decoration: handleGroupDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    onChanged: (value) => onChanged(value, x, formKey, that),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
    spacing: 6,
    options: ((x.to.options ?? []))
        .map((o) => FormBuilderChipOption(
              value: o.value,
              child: Text(o.label),
            ))
        .toList(),
  );

  return el;
}

Widget render_subsectionCard(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_text(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  FormBuilderCustomTextField el = FormBuilderCustomTextField(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    // decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator3(x, formKey)),
    // cursorHeight: formInputFontSize + 2.0,
    // style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    // // onReset: () => onReset(x, formKey),
    valueTransformer: (value) => valueTransformer(value, x, formKey),
  );
  return el;
}

Widget render_textArea(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}

Widget render_timePicker(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  var format = intl.DateFormat('HH:mm:ss');
  FormBuilderDateTimePicker el = FormBuilderDateTimePicker(
    key: x.key,
    name: x.name,
    initialValue: x.value,
    enabled: x.to.disabled != true,
    // autovalidateMode: handleAutoValidateMode(x, formKey),
    decoration: handleInputDecoration(x, formKey),
    validator: FormBuilderValidators.compose(validator4(x, formKey)),
    style: TextStyle(fontSize: formInputFontSize, height: formInputHeight),
    onChanged: (value) => onChanged(value, x, formKey, that),
    inputType: InputType.time,
    // initialEntryMode: DatePickerEntryMode.,
    // timePickerInitialEntryMode: TimePickerEntryMode.input,
    // initialDatePickerMode:DatePickerMode. ,
    // // onReset: () => onReset(x, formKey),
    // valueTransformer: (DateTime? value) => valueTransformer_Date(value, x, formKey),
    format: format,
  );
  return el;
}

Widget render_upload(
    FieldConfig x, GlobalKey<FormBuilderState> formKey, BForm that) {
  return render_input(x, formKey, that);
}
