import 'package:arrajewelry/constants/candy_colors.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:flutter/material.dart';

class HomeBalanceWidget extends StatefulWidget {
  final double balance;

  const HomeBalanceWidget({super.key, required this.balance});

  @override
  State<HomeBalanceWidget> createState() => _HomeBalanceWidgetState();
}

class _HomeBalanceWidgetState extends State<HomeBalanceWidget> {
  String balance = '';
  bool isMasked = true;
  Color? color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    color =
        widget.balance > 0
            ? CandyColors.colors['green']
            : CandyColors.colors['red'];

    balance = Helpers.numberFormat(widget.balance);
    Widget t = Text(
      isMasked ? Helpers.maskString(balance) : balance,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
      ),
    );
    IconData iconData =
        isMasked ? Icons.visibility_rounded : Icons.visibility_off_rounded;

    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(child: t),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isMasked = !isMasked;
                  });
                },
                icon: Icon(iconData, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
