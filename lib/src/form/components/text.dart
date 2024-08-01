part of form;
class FormBuilderCustomTextField<T> extends StatefulWidget {
  FormBuilderCustomTextField({
    super.key,
    required this.name,
    this.initialValue,
    this.enabled,
    this.validator,
    this.onChanged,
    this.valueTransformer,
  });
  final String name;
  final T? initialValue;
  final FormFieldValidator<T?>? validator;
  final bool? enabled;
  void Function(T?)? onChanged;
  dynamic Function(T?)? valueTransformer;

  @override
  State<FormBuilderCustomTextField> createState() =>
      _FormBuilderCustomTextFieldState();
}

class _FormBuilderCustomTextFieldState
    extends State<FormBuilderCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      valueTransformer: widget.valueTransformer,
      builder: (FormFieldState<dynamic> field) {
        return SelectableText(field.value ?? '');
      },
    );
  }
}
