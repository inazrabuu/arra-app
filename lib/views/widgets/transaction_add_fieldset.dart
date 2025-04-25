import 'package:arrajewelry/views/widgets/products_dropdown_widget.dart';
import 'package:flutter/material.dart';

class TransactionAddFieldset extends StatefulWidget {
  const TransactionAddFieldset({super.key});

  @override
  State<TransactionAddFieldset> createState() => _TransactionAddFieldsetState();
}

class _TransactionAddFieldsetState extends State<TransactionAddFieldset> {
  final List<List<dynamic>> _controllers = [
    [ProductDropdownWidget(), TextEditingController()],
  ];

  void _addField() {
    setState(
      () =>
          _controllers.add([ProductDropdownWidget(), TextEditingController()]),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c[0].dispose();
      c[1].dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Text(
                'Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            ..._controllers.asMap().entries.map((entry) {
              return Row(
                children: [
                  Expanded(flex: 7, child: entry.value[0]),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: entry.value[1],
                      decoration: InputDecoration(labelText: 'Qty'),
                    ),
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _addField,
                icon: Icon(Icons.add_rounded),
                label: Text('Add More Item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
