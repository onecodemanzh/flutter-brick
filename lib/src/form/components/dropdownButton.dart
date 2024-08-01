// ignore_for_file: file_names
part of form;

var options = ["Option 1", "Option 2", "Option 3"];

class DropdownButtonPro extends GetView {
  const DropdownButtonPro({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "name",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Select option",
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: InputBorder.none,
            errorText: field.errorText,
          ),
          // child: Container(
          //   height: 200,
          //   child: CupertinoPicker(
          //     itemExtent: 30,
          //     children: options.map((c) => Text(c)).toList(),
          //     onSelectedItemChanged: (index) {
          //       field.didChange(options[index]);
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}
