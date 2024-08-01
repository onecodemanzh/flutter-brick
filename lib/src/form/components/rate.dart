// ignore: must_be_immutable
part of form;
class FormBuilderCustomRateField<T> extends StatefulWidget {
  FormBuilderCustomRateField({
    super.key,
    required this.name,
    this.initialValue,
    this.enabled,
    this.validator,
    this.onChanged,
    this.valueTransformer,
    required this.field,
    required this.formKey,
  });
  GlobalKey<FormBuilderState> formKey;
  final String name;
  final T? initialValue;
  final FormFieldValidator<T?>? validator;
  final bool? enabled;
  final FieldConfig field;
  void Function(T?)? onChanged;
  dynamic Function(T?)? valueTransformer;

//  @required this.rate,
//     this.size = 24.0,
//     this.filledColor = Colors.amber,
//     this.emptyColor = Colors.grey
  @override
  State<FormBuilderCustomRateField> createState() =>
      _FormBuilderCustomRateFieldState();
}

class _FormBuilderCustomRateFieldState
    extends State<FormBuilderCustomRateField> {
  @override
  Widget build(BuildContext context) {
    Color filledColor = Colors.amber;
    Color emptyColor = Colors.grey;
    double size = 24;
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      valueTransformer: widget.valueTransformer,
      builder: (FormFieldState<dynamic> field) {
        final rate = (field.value ?? 0) > 0 ? field.value : -1;
        return Row(
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () {
                widget.formKey.currentState?.patchValue({
                  widget.field.name: index + 1,
                });
              },
              child: Icon(
                Icons.star,
                color: index < rate ? filledColor : emptyColor,
                size: size,
              ),
            );
          }),
        );
      },
    );
  }
}
