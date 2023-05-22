import 'dart:math';

double getDoubleRandom() {
  double randomdouble = Random().nextDouble();

  return double.parse(randomdouble.toStringAsFixed(1));
}
