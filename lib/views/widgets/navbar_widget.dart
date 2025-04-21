import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: AppStrings.menuHome,
            ),
            NavigationDestination(
              icon: Icon(Icons.diamond_rounded),
              label: AppStrings.menuProduct,
            ),
            NavigationDestination(
              icon: Icon(Icons.balance_rounded),
              label: AppStrings.menuTransaction,
            ),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
