import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextCell extends StatefulWidget {
  String value;
  final Function(String) onChanged;
  TextCell({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TextCell> createState() => _TextCellState();
}

class _TextCellState extends State<TextCell> {
  var controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    controller.value = TextEditingValue(
      text: widget.value,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          var isBackspace = 'Backspace' == event.logicalKey.keyLabel;
          var str = widget.value;
          if (isBackspace) {
            str = widget.value.substring(0, widget.value.length - 1);
          } else if (event.character != null) {
            str = widget.value + event.character!;
          }
          setState(() {
            widget.value = str;
            controller.value = TextEditingValue(
              text: widget.value,
              selection: TextSelection.fromPosition(
                TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: widget.value.toString().length,
                ),
              ),
            );
          });
          widget.onChanged(str);
        }
      },
      child: TextField(
        enabled: true,
        controller: controller,
      ),
    );
  }
}
