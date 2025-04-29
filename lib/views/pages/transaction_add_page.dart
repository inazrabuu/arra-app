import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/services/product_service.dart';
import 'package:arrajewelry/services/transaction_service.dart';
import 'package:arrajewelry/views/widgets/transaction_add_fieldset.dart';
import 'package:arrajewelry/views/widgets/transaction_add_trxdate_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionAddPage extends StatefulWidget {
  final TransactionModel? transaction;

  const TransactionAddPage({super.key, this.transaction});

  @override
  State<TransactionAddPage> createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  final ProductService productService = ProductService();
  final TransactionService transactionService = TransactionService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _totalController = TextEditingController(
    text: '0',
  );

  final TextEditingController _trxDateController = TextEditingController();

  int? _id;
  DateTime? _createdAt;
  bool _isPaid = false;
  bool _isFulfilled = false;
  bool _isDebit = false;
  bool _isLoading = false;
  String toastMessage = AppStrings.transactionAddSuccess;

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));

    TransactionModel t = getFormData();
    String res = await transactionService.save(t);

    if (widget.transaction != null) {
      toastMessage = AppStrings.transactionEditSuccess;
    }

    if (res != AppStrings.success) {
      toastMessage = AppStrings.transactionAddFail;
    }

    clearForm();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(toastMessage),
        margin: EdgeInsets.only(bottom: 400),
      ),
    );

    setState(() => _isLoading = false);

    Navigator.of(context).pop();
  }

  TransactionModel getFormData() {
    double total = 0;
    List<Map<String, dynamic>> details = [];
    for (var row in detailsControllersNotifier.value) {
      String item = '';
      int qty = 0;
      double price = 0;
      for (var e in row.asMap().entries) {
        if (e.key == 0) {
          if (e.value is TextEditingController) {
            item = e.value.text;
            price = 0;
          } else {
            List<String> splitted = e.value['selectedItem'].split('_');
            item = splitted[0];
            price = toDouble(splitted[1])!;
          }
        } else {
          qty = toInt(e.value.text)!;
          price = price * qty.toDouble();

          if (!_isDebit) {
            total += price;
          }
        }
      }
      details.add({'item': item, 'price': price, 'qty': qty});
    }

    return TransactionModel(
      id: widget.transaction != null ? _id : null,
      createdAt: widget.transaction != null ? _createdAt : null,
      orderNo: '',
      name: _nameController.text,
      description: _descriptionController.text,
      total: _isDebit ? toDouble(_totalController.text)! : total,
      isPaid: _isPaid,
      isFulfilled: _isFulfilled,
      detail: details,
      trxDate: DateTime.parse(_trxDateController.text),
      isDebit: _isDebit,
    );
  }

  void clearForm() {
    // clear & reset form fields
    _formKey.currentState!.reset();
    _trxDateController.text = DateTime.now().toString();
    _nameController.clear();
    _descriptionController.clear();
    _totalController.text = '0';
    detailsControllersNotifier.value = [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _trxDateController.dispose();
    detailsControllersNotifier.value = [];
    super.dispose();
  }

  @override
  void initState() {
    if (widget.transaction != null) {
      _id = widget.transaction!.id;
      _createdAt = widget.transaction!.createdAt;
      _trxDateController.text = widget.transaction!.trxDate.toString();
      _nameController.text = widget.transaction!.name;
      _descriptionController.text = widget.transaction!.description;
      _totalController.text = widget.transaction!.total.toStringAsFixed(0);
      _isPaid = widget.transaction!.isPaid;
      _isFulfilled = widget.transaction!.isFulfilled;
      _isDebit = widget.transaction!.isDebit;
      widget.transaction!.detail.map((i) async {
        ProductModel p = ProductModel.empty();
        dynamic item;

        if (!_isDebit) {
          String pName = i['item'];
          p = await productService.getByName(pName.toLowerCase());
          item = {'selectedItem': p.getNamePrice()};
        } else {
          item = TextEditingController(text: i['item']);
        }

        detailsControllersNotifier.value.add([
          item,
          TextEditingController(text: i['qty'].toString()),
        ]);

        setState(() => null);
      }).toList();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.transaction == null
              ? AppStrings.transactionAddPageTitle
              : AppStrings.transactionEditPageTitle,
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TransactionAddTrxdateWidget(
                  trxDateController: _trxDateController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Debit?'),
                      Switch(
                        value: _isDebit,
                        onChanged: (value) {
                          setState(() {
                            detailsControllersNotifier.value = [];
                            _isDebit = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 16.0,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter the name"
                                : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16.0,
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter the Description"
                                : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16.0,
                  ),
                  child: TextFormField(
                    controller: _totalController,
                    decoration: const InputDecoration(labelText: 'Total'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final t = int.tryParse(value ?? '');
                      if (t! <= 0) return "Enter valid total";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Paid?'),
                      Switch(
                        value: _isPaid,
                        onChanged: (value) {
                          setState(() => _isPaid = value);
                        },
                      ),
                      Text('Fulfilled?'),
                      Switch(
                        value: _isFulfilled,
                        onChanged: (value) {
                          setState(() => _isFulfilled = value);
                        },
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: detailsControllersNotifier,
                  builder: (context, detailsControllers, child) {
                    return TransactionAddFieldset(isDebit: _isDebit);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          _isLoading
                              ? CircularProgressIndicator()
                              : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_rounded),
                                  SizedBox(
                                    width: 8,
                                  ), // spacing between icon and label
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
