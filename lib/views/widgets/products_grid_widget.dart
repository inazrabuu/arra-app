import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/widgets/image_cloud.dart';
import 'package:flutter/material.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductModel> items;

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
        childAspectRatio: MediaQuery.of(context).size.width > 375 ? 0.68 : 0.65,
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
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: ImageCloud(
                        path:
                            "${dotenv.env['BUCKET_PRODUCT']}/${items[index].image}",
                        bucket: dotenv.env['SUPABASE_BUCKET']!,
                        width: 175,
                        height: 175,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        StringUtils.capitalize(
                          items[index].cat,
                          allWords: true,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: AppText.gridTitle(
                        StringUtils.capitalize(
                          items[index].name,
                          allWords: true,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: AppText.gridPrice(
                      Helpers.priceIdrFormat(items[index].price),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
