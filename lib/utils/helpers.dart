import 'package:arrajewelry/models/transaction_model.dart';
import 'package:basic_utils/basic_utils.dart';
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

  static String numberFormat(double number) {
    return NumberFormat.decimalPattern('de').format(number);
  }

  static String trxToClipboard(TransactionModel t) {
    String text = '';

    text += '#${t.orderNo}\n';
    text += 'Name: ${t.name}\n\n';
    text += 'Purchase:\n';
    for (var i in t.detail) {
      text +=
          '- ${StringUtils.capitalize(i['item'], allWords: true)} ${i['qty']}\n';
    }
    text += '\nTotal: ${Helpers.priceIdrFormat(t.total)}\n\n';
    text += 'Please transfer your payment to:\n';

    for (var i in Helpers.getPaymentInfo()) {
      text += '$i\n';
    }

    return text;
  }

  static List<String> getPaymentInfo() {
    return ["BCA 1280360933", "Artie Maharani"];
  }
}
