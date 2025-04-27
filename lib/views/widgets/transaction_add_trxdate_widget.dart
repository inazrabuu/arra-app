import 'package:flutter/material.dart';

class TransactionAddTrxdateWidget extends StatefulWidget {
  final TextEditingController trxDateController;

  const TransactionAddTrxdateWidget({
    super.key,
    required this.trxDateController,
  });

  @override
  State<TransactionAddTrxdateWidget> createState() =>
      _TransactionAddTrxdateWidgetState();
}

class _TransactionAddTrxdateWidgetState
    extends State<TransactionAddTrxdateWidget> {
  DateTime _selectedDateTime = DateTime.now();

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
      initialDate: _selectedDateTime,
    );

    if (pickedDate != null && pickedDate != _selectedDateTime) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          widget.trxDateController.text = _selectedDateTime.toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.trxDateController.text == '') {
      widget.trxDateController.text = _selectedDateTime.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
      child: TextFormField(
        controller: widget.trxDateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Transaction Date',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: _selectDateTime,
        validator:
            (value) =>
                value == null || value.isEmpty
                    ? "Enter the Transaction Date"
                    : null,
      ),
    );
  }
}
