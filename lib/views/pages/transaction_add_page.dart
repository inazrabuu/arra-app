import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/transaction_add_fieldset.dart';
import 'package:arrajewelry/views/widgets/transaction_add_trxdate_widget.dart';
import 'package:flutter/material.dart';

class TransactionAddPage extends StatefulWidget {
  const TransactionAddPage({super.key});

  @override
  State<TransactionAddPage> createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _totalController = TextEditingController(
    text: '0',
  );

  final TextEditingController _trxDateController = TextEditingController();
  bool _isPaid = false;
  bool _isFulfilled = false;
  bool _isDebit = false;
  bool _isLoading = false;

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    // clear & reset form fields
    _formKey.currentState!.reset();
    _trxDateController.text = DateTime.now().toString();
    _nameController.clear();
    _descriptionController.clear();
    _totalController.text = '0';
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Transaction added successfully!"),
        margin: EdgeInsets.only(bottom: 400),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _trxDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
          AppStrings.transactionAddPageTitle,
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
                          setState(() => _isDebit = value);
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
                TransactionAddFieldset(),
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
