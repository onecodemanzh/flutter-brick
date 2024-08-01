// ignore_for_file: must_be_immutable

part of form;

class FormBuilderCustomButtonField<T> extends StatefulWidget {
  FormBuilderCustomButtonField({
    super.key,
    required this.name,
    this.initialValue,
    this.enabled,
    this.validator,
    this.onChanged,
    this.valueTransformer,
    required this.field,
  });
  final String name;
  final T? initialValue;
  final FormFieldValidator<T?>? validator;
  final bool? enabled;
  final FieldConfig field;
  void Function(T?)? onChanged;
  dynamic Function(T?)? valueTransformer;

  @override
  State<FormBuilderCustomButtonField> createState() =>
      _FormBuilderCustomButtonFieldState();
}

class _FormBuilderCustomButtonFieldState
    extends State<FormBuilderCustomButtonField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      valueTransformer: widget.valueTransformer,
      builder: (FormFieldState<dynamic> field) {
        return Btn(
          widget.field.to.text ?? widget.field.name,
          title: widget.field.to.placeholder ?? '',
          btnType: widget.field.to.btnType,
          disabled: widget.field.to.disabled,
          // btnType: BtnType.Link,
          // classNames: 'pl-15 pr-15',
          // classNames:
          //     'p-20 p-md-30 p-sm-50 pe-10 align-items-center mt-15 mb-2',
          // onPressed: () => {print(' 1')},
          // color: Colors.red,
        );
      },
    );
  }
}

class FormBuilderCustomButtonsField<T> extends StatefulWidget {
  FormBuilderCustomButtonsField({
    super.key,
    required this.name,
    this.initialValue,
    this.enabled,
    this.validator,
    this.onChanged,
    this.valueTransformer,
    required this.field,
  });
  final String name;
  final T? initialValue;
  final FormFieldValidator<T?>? validator;
  final bool? enabled;
  final FieldConfig field;
  void Function(T?)? onChanged;
  dynamic Function(T?)? valueTransformer;

  @override
  State<FormBuilderCustomButtonsField> createState() =>
      _FormBuilderCustomButtonsFieldState();
}

class _FormBuilderCustomButtonsFieldState
    extends State<FormBuilderCustomButtonsField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      valueTransformer: widget.valueTransformer,
      builder: (FormFieldState<dynamic> field) {
        List<BCol> btns = (widget.field.to.btns!(field)).map((btn) {
          var str = getLayoutClass(btn.classNames ?? '');
          return BCol(
            classNames: str,
            child: btn,
          );
        }).toList();
        var classNames = getLayoutClass(widget.field.classNames ?? '');
        var rowGap = widget.field.to.rowGap;
        var columnGap = widget.field.to.columnGap;
        return BRow(
          classNames: '$classNames gc-$columnGap gr-$rowGap',
          children: btns,
        );
      },
    );
  }
}
