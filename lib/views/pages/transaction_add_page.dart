import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
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
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
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
      body: Padding(
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
                    if (t! < 0) return "Enter valid total";
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                child: Row(children: [Text('Details')]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(labelText: 'Item'),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(labelText: 'Item'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_rounded),
                    label: Text('Add Item'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: SizedBox(
                  width: double.infinity, // makes the button take full width
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // your action here
                    },
                    icon: Icon(Icons.send), // replace with your desired icon
                    label: Text('Send'), // replace with your label
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // button background color
                      foregroundColor: Colors.white, // icon and text color
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 4, // drop shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // rounded corners
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
