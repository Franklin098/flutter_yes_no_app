import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MessageFieldBox extends StatelessWidget {
  // ValueChange is the signature for a callback that returns a value
  final ValueChanged<String> onValueSubmitted;

  // we are going to receive a Function as a parameter (a callback)
  const MessageFieldBox({super.key, required this.onValueSubmitted});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
        hintText: 'End your message with a "?"',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            print('button: $textValue');
            textController.clear();
            onValueSubmitted(textValue);
          },
        ));

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        print('Submit value $value');
        textController.clear();
        onValueSubmitted(value);
        focusNode
            .requestFocus(); // avoid hiding the keyboard (loosing the focus)
      },
      onChanged: (value) {
        print('changed: $value');
      },
    );
  }
}
