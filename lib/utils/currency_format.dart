import 'dart:io';

import 'package:intl/intl.dart';

formatCurrency(amount, currencyCode) {
  var value = double.parse(amount.toString());
  return NumberFormat.simpleCurrency(
          name: currencyCode, decimalDigits: 2, locale: Platform.localeName)
      .format(value);
}
