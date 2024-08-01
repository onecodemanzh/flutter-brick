part of form;
class BFormController extends GetxController {
  // TODO: Implement BFormController

  final count = 2.obs;
  @override
  void onInit() {
    super.onInit();
    // debugPrint('onInit');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  /// -------------------------------

  List<Widget> render({
    required BuildContext context,
    required BoxConstraints constraints,
    required ScreenData screenData,
    required BFormProps props,
    required GlobalKey<FormBuilderState> formKey,
    required BForm that,
  }) {
    return props.fields
        .map((g) => renderGroup(
            constraints: constraints,
            screenData: screenData,
            context: context,
            g: g,
            formKey: formKey,
            that: that))
        .toList();
  }
}
