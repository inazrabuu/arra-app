import 'package:arrajewelry/data/app_data.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/views/widgets/image_cloud.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TransactionAddFieldset extends StatefulWidget {
  final bool isDebit;
  const TransactionAddFieldset({super.key, required this.isDebit});

  @override
  State<TransactionAddFieldset> createState() => _TransactionAddFieldsetState();
}

class _TransactionAddFieldsetState extends State<TransactionAddFieldset> {
  List<ProductModel> _products = [];

  void _addField() {
    dynamic item;

    Map<String, dynamic> dropdown = {
      'selectedItem': _products[0].getNamePrice(),
    };

    if (!widget.isDebit) {
      item = dropdown;
    } else {
      item = TextEditingController();
    }

    setState(() {
      detailsControllersNotifier.value.add([
        item,
        TextEditingController(text: '1'),
      ]);
    });
  }

  @override
  void initState() {
    super.initState();
    _products = AppData().products!;
  }

  @override
  void dispose() {
    for (final c in detailsControllersNotifier.value) {
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
            ...detailsControllersNotifier.value.asMap().entries.map((entry) {
              return Row(
                children: [
                  Expanded(
                    flex: 8,
                    child:
                        !widget.isDebit
                            ? DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 16,
                                ),
                              ),
                              value: entry.value[0]['selectedItem'],
                              items:
                                  _products.map((i) {
                                    return DropdownMenuItem<String>(
                                      value: i.getNamePrice(),
                                      child: Row(
                                        children: [
                                          ImageCloud(
                                            path:
                                                '${dotenv.env['BUCKET_PRODUCT']}/${i.image}',
                                            bucket:
                                                dotenv.env['SUPABASE_BUCKET']!,
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            StringUtils.capitalize(
                                              i.name,
                                              allWords: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(
                                  () => entry.value[0]['selectedItem'] = value,
                                );
                              },
                            )
                            : TextFormField(
                              controller: entry.value[0],
                              decoration: InputDecoration(labelText: 'Item'),
                            ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: MediaQuery.of(context).size.width < 375 ? 1 : 2,
                    child: TextFormField(
                      controller: entry.value[1],
                      decoration: InputDecoration(labelText: 'Qty'),
                      keyboardType: TextInputType.number,
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
