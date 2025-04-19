import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/views/pages/home_page.dart';
import 'package:arrajewelry/views/pages/product_page.dart';
import 'package:arrajewelry/views/pages/transaction_page.dart';
import 'package:arrajewelry/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> pages = [HomePage(), ProductPage(), TransactionPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          height: 24,
          width: 24,
          child: SvgPicture.asset('assets/images/logo.svg'),
        ),
        title: const Text('ARRA'),
        centerTitle: false,
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder:
            (context, selectedPage, child) => pages.elementAt(selectedPage),
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }
}
