import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/image_cloud.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeLatestWidget extends StatelessWidget {
  final List<ProductModel> items;

  const HomeLatestWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppText.heading2(
                AppStrings.homeLatest,
                color: Colors.grey[700],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedPageNotifier,
                    builder: (context, value, _) {
                      return GestureDetector(
                        onTap: () {
                          selectedPageNotifier.value = 1;
                        },
                        child: Text(AppStrings.homeLatestAll),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: ImageCloud(
                            path:
                                "${dotenv.env['BUCKET_PRODUCT']}/${items[index].image}",
                            bucket: dotenv.env['SUPABASE_BUCKET']!,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: AppText.gridTitle(
                            StringUtils.capitalize(
                              items[index].name,
                              allWords: true,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: AppText.gridPrice(
                            Helpers.priceIdrFormat(items[index].price),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
