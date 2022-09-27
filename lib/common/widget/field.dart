import 'package:flutter/material.dart';

import '../../ui/theme/app_theme.dart';

class Field extends StatefulWidget {
  Field(
      {Key? key,
      required this.onChanged,
      required this.isPassword,
      required this.hintText,
      required this.controller,
      required this.theme,
      required this.isShowEye})
      : super(key: key);
  bool isPassword;
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;
  final AppTheme theme;
  final bool isShowEye;

  @override
  State<Field> createState() => _FieldState();
}

bool isShow = false;

class _FieldState extends State<Field> {
  displayCallback() {
    isShow = !isShow;
    widget.isPassword = !widget.isPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("is show eye ${widget.isShowEye}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                  onChanged: widget.onChanged,
                  controller: widget.controller,
                  obscureText: widget.isPassword,
                  obscuringCharacter: "*",
                  style: widget.theme.textTheme.h40,
                  keyboardType: TextInputType.text,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //     RegExp("[a-zA-Z]|[0-9]|[!@#\$%^&*=+-_)()]"),
                  //   ),
                  // ],
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    suffixIcon: widget.isShowEye
                        ? IconButton(
                            onPressed: displayCallback,
                            // onPressed: _controller.clear,
                            icon: Icon(isShow
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined))
                        : const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.transparent,
                            ),
                          ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: widget.theme.appColors.primary,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: widget.theme.appColors.primary,
                        width: 0.5,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
