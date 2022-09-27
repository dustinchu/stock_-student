import 'package:flutter/material.dart';

class PercentageRow extends StatelessWidget {
  final List<double> percentages;
  final List<Widget> children;

  const PercentageRow({required this.percentages, required this.children});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: percentages
          .map((p) => IntrinsicColumnWidth(flex: p))
          .toList()
          .asMap(),
      children: [TableRow(children: children)],
    );
  }
}
