import 'package:intl/intl.dart';

class Helpers {
  static String priceIdrFormat(double price) {
    final idrFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return idrFormat.format(price);
  }
}
