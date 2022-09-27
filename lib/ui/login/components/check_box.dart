import 'package:flutter/material.dart';

class CkBox extends StatelessWidget {
  const CkBox(
      {Key? key,
      required this.value,
      required this.changed,
      required this.text})
      : super(key: key);
  final Function(bool? value) changed;
  final bool value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          child: Checkbox(
            // shape: CircleBorder(),
            value: value,
            onChanged: changed,
          ),
        ),
        Text(text)
      ],
    );
  }
}
