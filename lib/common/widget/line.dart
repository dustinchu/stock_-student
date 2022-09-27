import 'package:flutter/material.dart';

Widget line() {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.white.withOpacity(0.1),
  );
}

Widget marginLine() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    height: 1,
    width: double.infinity,
    color: Colors.white.withOpacity(0.1),
  );
}
