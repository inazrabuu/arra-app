import 'package:another_flushbar/flushbar.dart';
import 'package:arrajewelry/constants/candy_colors.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionDetailWidget extends StatelessWidget {
  final TransactionModel transaction;
  final BuildContext? context;

  const TransactionDetailWidget({
    super.key,
    required this.transaction,
    this.context,
  });

  Icon boolIcon(bool value) {
    return value
        ? Icon(Icons.check_rounded, color: CandyColors.colors['green'])
        : Icon(Icons.close_rounded, color: CandyColors.colors['red']);
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, y').format(transaction.trxDate);

    final idrFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    String total = idrFormat.format(transaction.total);

    dynamic debit = {
      "text": transaction.isDebit ? 'DEBIT' : 'CREDIT',
      "color":
          transaction.isDebit
              ? CandyColors.colors['red']
              : CandyColors.colors['green'],
    };

    double detailsHeight = MediaQuery.of(context).size.width < 375 ? 130 : 150;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: AppText.heading2(
                        'Transaction #${transaction.orderNo}',
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            constraints: const BoxConstraints(minWidth: 40),
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: debit['color'],
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                debit['text'],
                                style: TextStyle(
                                  color: debit['color'],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey[350]),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          boolIcon(transaction.isPaid),
                          SizedBox(width: 4),
                          AppText.bold('Paid'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          boolIcon(transaction.isFulfilled),
                          SizedBox(width: 4),
                          AppText.bold('Fulfilled'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                          transaction.isDebit
                              ? SizedBox.shrink()
                              : Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String textToCopy =
                                          Helpers.trxToClipboard(transaction);

                                      Clipboard.setData(
                                        ClipboardData(text: textToCopy),
                                      );
                                      Flushbar(
                                        message: 'Copied to Clipboard',
                                        duration: Duration(seconds: 2),
                                      )..show(context);
                                    },
                                    child: Icon(Icons.content_copy_rounded),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      Helpers.downloadInvoice(
                                        transaction,
                                        context,
                                      );
                                    },
                                    child: Icon(Icons.file_download_rounded),
                                  ),
                                ],
                              ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey[350]),
                Row(
                  children: [
                    Expanded(flex: 4, child: AppText.bold('Date')),
                    Expanded(flex: 6, child: Text(formattedDate)),
                  ],
                ),
                Divider(color: Colors.grey[350]),
                Row(
                  children: [
                    Expanded(flex: 4, child: AppText.bold('Name')),
                    Expanded(flex: 6, child: Text(transaction.name)),
                  ],
                ),
                Divider(color: Colors.grey[350]),
                Row(
                  children: [
                    Expanded(flex: 4, child: AppText.bold('Description')),
                    Expanded(flex: 6, child: Text(transaction.description)),
                  ],
                ),
                Divider(color: Colors.grey[350]),
                Row(
                  children: [
                    Expanded(flex: 4, child: AppText.bold('Total')),
                    Expanded(flex: 6, child: AppText.gridPrice(total)),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(maxHeight: detailsHeight),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!, width: 1),
                  ),
                  child: ListView.builder(
                    itemCount: transaction.detail.length,
                    itemBuilder: (context, index) {
                      String item = StringUtils.capitalize(
                        transaction.detail[index]['item'],
                        allWords: true,
                      );
                      String qty = transaction.detail[index]['qty'].toString();
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text(item)),
                                Expanded(child: Center(child: Text(qty))),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
