import 'package:arrajewelry/models/transaction_model.dart';
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
      text += '- ${i['item']} ${i['qty']}\n';
    }
    text += '\nTotal: ${Helpers.priceIdrFormat(t.total)}\n\n';
    text += 'Please transfer your payment to:\n';
    text += 'BCA 1781199856\n';
    text += 'Arman Barzani Rizal';

    return text;
  }
}
