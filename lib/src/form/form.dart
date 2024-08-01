// ignore_for_file: must_be_immutable
library form;

import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../button.dart';
import '../varriable/varriable.dart';

part 'types/BForm.dart';
part 'types/Events.dart';
part 'types/FieldConfig.dart';
part 'types/FieldType.dart';
part 'types/Hooks.dart';
part 'types/Rule.dart';
part 'types/Style.dart';
part 'types/TemplateOptions.dart';
part 'render/form_components.dart';
part 'render/form_fn.dart';
part 'render/form_validator.dart';
part 'render/render_form.dart';
part 'controllers/form_contoller.dart';
part 'components/button.dart';
part 'components/dropdownButton.dart';
part 'components/rate.dart';
part 'components/text.dart';

class BForm extends StatefulWidget {
  BFormProps props;

  /// ref
  String? ref;
  ValueChanged<FormChangeEvent>? onChanged;
  @override
  GlobalKey<BFormState>? key;
  BForm({
    super.key,
    required this.props,
    this.ref,
    this.onChanged,
  });

  @override
  State<BForm> createState() => BFormState();
}

class BFormState extends State<BForm> {
  final formKey = GlobalKey<FormBuilderState>();
  final loading = false.obs;
  final BFormController controller = Get.put(BFormController());

  @override
  void dispose() {
    super.dispose();
    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 实例化 controller 并 获取controller
    // Get.put(BFormController());
    // fields;
    // Obx(() => print(controller.count));
    // print(props);
    // print(props.fields);
    // const timeout = Duration(seconds: 3);
    // Timer(timeout, () {
    //   formKey.currentState?.saveAndValidate();
    // });
    // borderPrimary
    return MediaQueryBuilder(builder: (context, constraints, screenData) {
      final body = controller.render(
        props: widget.props,
        formKey: formKey,
        context: context,
        constraints: constraints,
        screenData: screenData,
        that: widget,
      );
      return FormBuilder(
        onChanged: () {
          // formKey.currentState?.save();
          // debugPrint(formKey.currentState!.value.toString());
          // if (onChanged != null) onChanged!(formKey.currentState!.value);
        },
        key: formKey,
        child: Wrap(
          children: body,
        ),
      );
    });
  }
}
