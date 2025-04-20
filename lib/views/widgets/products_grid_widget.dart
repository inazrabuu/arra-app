import 'package:flutter/material.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:basic_utils/basic_utils.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ProductsGridWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 8 / 10,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF6F6F6),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/products/1.png',
                      width: 100.0,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(StringUtils.capitalize(items[index]['cat'])),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: AppText.gridTitle(
                        StringUtils.capitalize(items[index]['name']),
                      ),
                    ),
                  ),
                  Center(child: AppText.gridPrice("${items[index]['price']}")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
