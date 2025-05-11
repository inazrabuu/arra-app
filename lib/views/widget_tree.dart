import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/views/pages/home_page.dart';
import 'package:arrajewelry/views/pages/product_page.dart';
import 'package:arrajewelry/views/pages/transaction_add_page.dart';
import 'package:arrajewelry/views/pages/transaction_page.dart';
import 'package:arrajewelry/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final transactionPageKey = GlobalKey<TransactionPageState>();

List<Widget> pages = [
  HomePage(),
  ProductPage(),
  TransactionPage(key: transactionPageKey),
];

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
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
        ),
        centerTitle: false,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Center(child: Text('More to come 👍')),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return IndexedStack(index: selectedPage, children: pages);
        },
      ),
      bottomNavigationBar: const NavbarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, _, _) => const TransactionAddPage(),
              transitionsBuilder: (context, animation, _, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
        child: Icon(Icons.add_rounded, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
