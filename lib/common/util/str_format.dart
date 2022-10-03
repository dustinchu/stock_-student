import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String getFormatStepCount(String count) {
  String s = Decimal.parse(count).toString();
  // return NumberFormat.decimalPattern('en').format(
  //   s,
  // );
  if (s.length > 3) {
    var format = NumberFormat('0,000');
    return format.format(double.parse(s));
    // return NumberFormat.decimalPattern('en').format(
    //   double.parse(s),
    // );
  } else {
    return s;
  }
}

String getFormatStepCount2(double count) {
  String s = Decimal.parse(count.toString()).toString();
  // return NumberFormat.decimalPattern('en').format(
  //   s,
  // );
  if (s.length > 3) {
    var format = NumberFormat('0,000.00');
    return format.format(double.parse(s));
    // return NumberFormat.decimalPattern('en').format(
    //   double.parse(s),
    // );
  } else {
    return s;
  }
}
