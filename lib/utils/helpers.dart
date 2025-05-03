import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

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

  static Future<void> downloadInvoice(
    TransactionModel t,
    BuildContext context,
  ) async {
    final dio = Dio();
    String apiUrl = dotenv.env['INVOICE_API_URL']!;
    Directory? downloadPath;

    if (!await Helpers.requestPermission()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Storage permission denied')));
      return;
    }

    if (Platform.isAndroid) {
      downloadPath = Directory('/storage/emulated/0/Download');
    } else {
      downloadPath = await getApplicationDocumentsDirectory();
    }

    List<Map<String, dynamic>> detail = [];
    t.detail.map((i) {
      detail.add({
        "name": StringUtils.capitalize(i['item'], allWords: true),
        "qty": i['qty'],
        "price": i['price'],
      });
    }).toList();

    final data = {
      "invoiceNo": t.orderNo,
      "customerName": t.name,
      "date": t.trxDate.toString(),
      "total": t.total,
      "items": detail,
      "paymentInfo": Helpers.getPaymentInfo(),
    };

    try {
      final response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Content-Type': 'application/json'},
        ),
        onReceiveProgress: (received, total) {
          null;
        },
      );

      String fileName = 'downloaded_file';
      final contentDisposition = response.headers.map['content-disposition'];
      if (contentDisposition != null && contentDisposition.isNotEmpty) {
        final regExp = RegExp(r'filename[^;=\n]*=([^;\n]*)');
        final match = regExp.firstMatch(contentDisposition[0]);
        if (match != null) {
          fileName = match.group(1)!.replaceAll('"', '').trim();
        }
      }

      final savePath = path.join(downloadPath.path, fileName);

      final file = File(savePath);
      await file.writeAsBytes(response.data);

      Flushbar(
        message: 'Downloaded to ${file.path}',
        duration: Duration(seconds: 2),
      )..show(context);

      await OpenFile.open(file.path);
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.downloadFailed)));
    }
  }

  static Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }

    return true;
  }
}
